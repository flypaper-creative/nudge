# Nudge Engine

**Nudge** is an autonomous, modular automation engine built to enhance investigative workflows, creative projects, and AI-assisted task cycles. It serves as the central automation system for coordinating processes like OCR, scraping, auto-prompt cycling, forensic analysis, and more—all while keeping your context clear and your GPT actively working without manual intervention.

This system is designed to integrate seamlessly with OpenAI's API, operate in Termux on Android, and support dynamic, self-regulating task execution with flexible modes: Full Auto, Manual, and Hybrid.

---

## Table of Contents

- [Features](#features)
- [Directory Structure](#directory-structure)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Operational Modes](#operational-modes)
- [Prompt Cycling](#prompt-cycling)
- [Logging and Monitoring](#logging-and-monitoring)
- [Versioning (ver*) System](#versioning-ver-system)
- [License](#license)
- [Credits](#credits)

---

## Features

- Autonomous **heartbeat-style task execution** with customizable intervals.
- Dynamic **prompt cycling** and automatic GPT continuation.
- Modular design supporting flexible plug-in task modules.
- Self-healing context engine leveraging your knowledge base and shard system.
- Integrated logging and health-check pings.
- GitHub synchronization for keeping your repo updated (`sync_nudge.sh`).
- Fully compatible with OpenAI API (supports GPT-3.5-turbo, GPT-4, GPT-4o).
- Includes **dynamic prompt generation** based on context.
- **Signature shard system** for modular reuse of elements like extracted SVG signatures.
- Implements the proprietary **ver*** versioning and quality algorithm, including `ver@com` (commercial-quality mode).

---

## Directory Structure

nudge/ ├── LICENSE ├── README.md ├── config/                  # .env and configuration files ├── engine/                  # Core heartbeat and prompt scripts ├── logs/                    # Output logs (e.g., gpt_output.log) ├── prompts/                 # Saved prompt sets ├── scripts/                 # Utility scripts (sync, setup, monitoring) ├── sessions/                # Stored conversation sessions ├── shards/                  # Modular data shards (e.g., signature SVGs) ├── templates/               # Document templates (motions, filings, etc.) ├── viewers/                 # Viewer utilities (e.g., viewer_server.py) └── venv/                    # Python virtual environment (excluded from Git)

---

## Installation

### 1. Clone the Repository:
```bash
git clone https://github.com/flypaper-creative/nudge.git
cd nudge

2. Install Dependencies:

pkg install python python3 git jq
pip install openai python-dotenv

> Note: If using virtual environments:



python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt


---

Configuration

1. Create a .env file in the config/ directory:



OPENAI_API_KEY=your-openai-api-key-here

2. Adjust intervals, prompt behavior, and other settings inside engine/heartbeat_engine/config.json (if available).




---

Usage

Start Nudge (Heartbeat) Manually:

bash engine/auto_prompt.sh

Sync with GitHub:

bash scripts/sync_nudge.sh

Generate Prompts Dynamically:

bash engine/dynamic_prompt_gen.sh


---

Operational Modes

1. Full Auto Mode: Nudge runs entirely on its own, cycling prompts, monitoring outputs, and syncing as needed.


2. Manual Mode: Nudge is idle until you trigger commands manually.


3. Hybrid Mode: Nudge operates automatically but pauses when you interact directly (keeps GPT responsive to your input).



Mode selection is configurable in the main heartbeat_engine logic or via a control file (mode.conf planned for future versions).


---

Prompt Cycling

Default behavior:

Sends "Please continue where you left off with {LAST_OUTPUT}" unless overridden.

Can read randomized prompts from prompts/prompts.txt.

Supports dynamic prompt generation using dynamic_prompt_gen.sh.



---

Logging and Monitoring

Logs are stored in logs/ folder (e.g., gpt_output.log).

Heartbeat pings confirm the active status every set interval.

Optional health check: logs/health_check.log.



---

Versioning (ver*) System

This project uses the proprietary ver* versioning syntax with intensity modifiers:

Minor [m], Average [a], Strong [s]

Supports exponential mode (x) and new-feature mode (n).

Example: ver+5[s], ver@com for auto-calculated commercial-quality standard.


The versioning system ensures consistent upgrades and clear changelogs between versions.


---

License

This project is licensed under the terms of the MIT License.


---

Credits

Developed as part of the Sueño Project.

Integrates ideas from the Mayorgate GPT system.

OpenAI API integration.

Proprietary ver* and shard systems by Joshua Ian Durden.



---

> Note: Contributions, enhancements, and module submissions are welcome!
Future planned modules: OCR engine, forensic data comb, motion generator, shard viewer, and anomaly detector.
