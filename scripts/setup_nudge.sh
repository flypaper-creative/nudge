#!/data/data/com.termux/files/usr/bin/bash

# === NUDGE SETUP SCRIPT ===
echo "[*] Starting Nudge setup..."

# Check for necessary packages
echo "[*] Checking required packages..."
pkg update -y && pkg upgrade -y
pkg install -y git python jq curl termux-api

# Create required folders if missing
mkdir -p heartbeat_engine/logs
mkdir -p logs
mkdir -p scripts

# Ensure permissions
chmod +x prompt_chatgpt.sh
chmod +x sync_nudge.sh
chmod +x dynamic_prompt_gen.sh

# Check for Python venv
if [ ! -d "venv" ]; then
  echo "[*] Setting up Python virtual environment..."
  python -m venv venv
fi

# Activate venv and install OpenAI
source venv/bin/activate
pip install --upgrade pip
pip install openai requests

# Verify environment variable for API key
if [ -f ".env" ]; then
  echo "[*] .env file detected."
else
  echo "[*] No .env file found. Creating a placeholder..."
  echo 'OPENAI_API_KEY="sk-your-api-key-here"' > .env
fi

# Reminder to check the .env file
echo "[*] Please confirm your API key is correct inside .env"

echo "[*] Nudge setup complete!"
echo "[*] To start Nudge manually, run: bash heartbeat_engine/heartbeat.sh"
