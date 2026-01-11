# AI CLI Manager - Linux & macOS Guide

This version of AI CLI Manager (`AI_CLI_Manager.sh`) provides a terminal interface to install, manage, and launch your supported AI CLI tools on Linux and macOS systems.

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the following installed:
*   **Node.js**: Required for most CLIs (npm).
*   **Python 3 & pip**: Required for Mistral Vibe.

To check if you have them:
```bash
node -v
python3 --version
```

### 2. Make Executable
Before running the script, you must give it execution permissions. Open your terminal in the project folder and run:

```bash
chmod +x AI_CLI_Manager.sh
```

### 3. Run the Manager
Run the script directly from your terminal:

```bash
./AI_CLI_Manager.sh
```

## 🛠️ Features

The script offers a simple interactive menu:

*   **1. Check and Install All CLIs**: Automatically checks if supported tools (Gemini, Jules, iFlow, OpenCode, Qwen, KiloCode, Mistral Vibe) are installed. If missing, it attempts to install them via `npm` or `pip`.
    *   *Note*: If you run into permission errors, the script will attempt to ask for `sudo` password to install global packages.
*   **2. Show Installed CLI Versions**: Displays the currently installed version of each tool.

### Launch Tools
Launch any of the supported CLIs directly from the menu:
*   Gemini CLI
*   Jules CLI
*   Mistral Vibe
*   iFlow CLI
*   OpenCode CLI
*   Qwen Code CLI
*   KiloCode CLI

## ⚠️ Known Differences (vs Windows)
*   **Context Menu**: The "Add to Right-Click Menu" feature is currently **Windows-only**. Linux/Mac context menus vary wildly (Finder, Nautilus, Dolphin, etc.), so they are not automatically configured by this script.
*   **Terminal**: Does not automatically detect or launch a separate terminal window; it runs inside the current shell.
