import os
import time
from datetime import datetime

SESSIONS_DIR = os.path.expanduser("~/nudge/sessions")
PROMPT_FILE = os.path.expanduser("~/nudge/prompts/current_goal.txt")
INTERVAL_FILE = os.path.expanduser("~/nudge/prompts/interval.txt")
MONITOR_LOG = os.path.expanduser("~/nudge/logs/monitor.log")

def read_file(path):
    with open(path, "r") as f:
        return f.read().strip()

def log_to_monitor(data):
    with open(MONITOR_LOG, "a") as f:
        f.write(f"[{datetime.now().isoformat()}] {data}\n")

def simulate_iteration(session_path, i, goal):
    output = f"Iteration {i+1}: {goal} | Simulated improvement."
    with open(os.path.join(session_path, f"result_{i+1:03}.txt"), "w") as f:
        f.write(output)
    log_to_monitor(output)

def main():
    iteration = 0
    session_time = datetime.now().strftime("%Y%m%d_%H%M%S")
    session_path = os.path.join(SESSIONS_DIR, f"session_{session_time}")
    os.makedirs(session_path, exist_ok=True)
    log_to_monitor(f"Started session: {session_path}")

    while True:
        try:
            interval = int(read_file(INTERVAL_FILE))
            goal = read_file(PROMPT_FILE)
            simulate_iteration(session_path, iteration, goal)
            iteration += 1
            time.sleep(interval)
        except Exception as e:
            log_to_monitor(f"Error during iteration: {e}")
            break

if __name__ == "__main__":
    main()
