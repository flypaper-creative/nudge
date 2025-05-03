# monitor_cli.py

import asyncio
import websockets
from rich.console import Console
from rich.table import Table
from rich.live import Live
from datetime import datetime
import json

console = Console()

WEBSOCKET_URL = "ws://localhost:8000/ws"

def build_table(session_data):
    table = Table(title=f"NUDGE Live Session Monitor — {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    table.add_column("Session Name", style="cyan", no_wrap=True)
    table.add_column("Status", style="green")
    table.add_column("Iterations", style="magenta")
    table.add_column("Quality Gate", style="yellow")

    for session in session_data:
        table.add_row(session["name"], session["status"], str(session["iterations"]), session["quality"])

    return table

async def monitor():
    async with websockets.connect(WEBSOCKET_URL) as websocket:
        with Live(build_table([]), refresh_per_second=1) as live:
            while True:
                message = await websocket.recv()
                session_data = json.loads(message)
                live.update(build_table(session_data))

if __name__ == "__main__":
    try:
        asyncio.run(monitor())
    except KeyboardInterrupt:
        console.print("[bold red]Monitor stopped by user.[/bold red]")
