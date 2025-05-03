# viewer_server.py

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
import asyncio
from pathlib import Path
import json

app = FastAPI()

# Path where session iteration logs are stored (adjust this to your setup)
LOG_PATH = Path("/Mayorgate_Logs/Heartbeat_Iteration_Summaries/")

# Keep track of active WebSocket connections
class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)

manager = ConnectionManager()

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await manager.connect(websocket)
    try:
        while True:
            # Check for the latest log file and send its contents
            latest_log = max(LOG_PATH.glob("*.json"), key=lambda f: f.stat().st_mtime)
            with open(latest_log, "r") as file:
                log_data = json.load(file)
            await manager.broadcast(json.dumps(log_data))
            await asyncio.sleep(5)  # Adjust heartbeat frequency as needed
    except WebSocketDisconnect:
        manager.disconnect(websocket)

@app.get("/")
async def read_root():
    return HTMLResponse(content="<h1>Glassflow Viewer WebSocket Server Running...</h1>", status_code=200)
