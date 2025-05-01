mkdir -p ~/nudge/logs ~/nudge/sessions

# Activate environment
source ~/nudge_env/bin/activate

# Kill any existing processes
pkill -f uvicorn
pkill -f monitor_cli.py
pkill -f heartbeat.py

# Start Uvicorn
nohup uvicorn viewer_server:app --host 0.0.0.0 --port 8000 --reload > ~/nudge/logs/uvicorn.log 2>&1 &

# Start monitor
nohup python ~/nudge/monitor_cli.py > ~/nudge/logs/monitor.log 2>&1 &

# Start heartbeat
nohup python ~/heartbeat_engine/heartbeat.py > ~/nudge/logs/heartbeat.log 2>&1 &

echo "Nudge environment fully launched."
