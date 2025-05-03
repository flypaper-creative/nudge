#!/data/data/com.termux/files/usr/bin/bash

Script: free_port_8000.sh

Purpose: Automatically kill any process using port 8000

Check if lsof is installed

if ! command -v lsof &> /dev/null then echo "Installing lsof..." pkg install -y lsof fi

Find PID using port 8000

PID=$(lsof -ti :8000)

if [ -z "$PID" ]; then echo "Port 8000 is already free." else echo "Killing process on port 8000 (PID: $PID)..." kill -9 $PID echo "Port 8000 is now free." fi

