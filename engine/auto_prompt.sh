#!/data/data/com.termux/files/usr/bin/bash

# ============================
# NUDGE HEARTBEAT: Auto-Prompt Cycle Module
# ============================

# Activate Virtual Environment
source ~/nudge/venv/bin/activate

# Environment Variables
if [ -f ~/nudge/.env ]; then
    export $(cat ~/nudge/.env | xargs)
else
    echo "[ERROR] .env file not found!"
    exit 1
fi

# Define Paths
OUTPUT_LOG=~/nudge/heartbeat_engine/logs/gpt_output.log
PROMPT_SCRIPT=~/nudge/prompt_chatgpt.sh
INTERVAL=120   # Interval between cycles in seconds (adjust as needed)

echo "[*] Auto-Prompt Cycling Started. Interval: $INTERVAL seconds."

# Infinite Loop with Heartbeat Control
while true; do
    TIMESTAMP=$(date)
    echo "[*] [Auto-Prompt Cycle] Ping at $TIMESTAMP"
    
    # Call the prompt_chatgpt script
    bash "$PROMPT_SCRIPT"

    # Check for Stop Flag
    if [ -f ~/nudge/STOP_HEARTBEAT ]; then
        echo "[*] Stop signal detected. Halting Auto-Prompt Cycle."
        rm ~/nudge/STOP_HEARTBEAT
        break
    fi

    # Sleep for interval
    sleep "$INTERVAL"
done
