#!/data/data/com.termux/files/usr/bin/bash

# ============================
# NUDGE HEARTBEAT: Auto-Prompt Cycle Module (Enhanced)
# ============================

# -------- CONFIG --------
DEFAULT_INTERVAL=120  # Default interval if none provided

# -------- FUNCTIONS --------
check_dependencies() {
    for dep in jq curl; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "[ERROR] Missing dependency: $dep"
            echo "Please install with: pkg install $dep"
            exit 1
        fi
    done
}

load_api_key() {
    if [ -f ~/nudge/.env ]; then
        export $(grep -v '^#' ~/nudge/.env | xargs)
    else
        echo "[ERROR] .env file not found!"
        exit 1
    fi
}

run_prompt_cycle() {
    bash "$PROMPT_SCRIPT"
}

# -------- MAIN --------
# Check Dependencies First
check_dependencies

# Load API Key
load_api_key

# Handle Optional Interval Argument
if [ -n "$1" ]; then
    INTERVAL="$1"
else
    INTERVAL="$DEFAULT_INTERVAL"
fi

# Paths
OUTPUT_LOG=~/nudge/heartbeat_engine/logs/gpt_output.log
PROMPT_SCRIPT=~/nudge/prompt_chatgpt.sh
STOP_FILE=~/nudge/STOP_HEARTBEAT

echo "[*] NUDGE Auto-Prompt Cycling Started."
echo "[*] Interval: $INTERVAL seconds. Stop anytime by 'touch $STOP_FILE'"

# -------- BEGIN CYCLE --------
while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[*] [Cycle Ping] $TIMESTAMP"

    if [ ! -f "$PROMPT_SCRIPT" ]; then
        echo "[ERROR] prompt_chatgpt.sh not found at $PROMPT_SCRIPT"
        exit 1
    fi

    run_prompt_cycle

    # Check for STOP Signal
    if [ -f "$STOP_FILE" ]; then
        echo "[*] Stop signal detected. Ending Heartbeat Cycle."
        rm "$STOP_FILE"
        break
    fi

    sleep "$INTERVAL"
done

echo "[*] Heartbeat Auto-Cycle Finished at $(date '+%Y-%m-%d %H:%M:%S')"
