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

*   **I. Check and Install All CLIs**: Automatically checks if supported tools (Gemini, Jules, iFlow, OpenCode, Qwen, KiloCode, Mistral Vibe, GitHub Copilot, NanoCode) are installed. If missing, it attempts to install them via `npm` or `pip`.
    *   *Note*: If you run into permission errors, the script will attempt to ask for `sudo` password to install global packages.
*   **V. Show Installed CLI Versions**: Displays the currently installed version of each tool.

### Launch Tools
Launch any of the supported CLIs directly from the menu:
*   Gemini CLI
*   Jules CLI
*   Mistral Vibe
*   iFlow CLI
*   OpenCode CLI
*   Qwen Code CLI
*   KiloCode CLI
*   GitHub Copilot CLI
*   NanoCode CLI

## ⚠️ Known Differences (vs Windows)
*   **Context Menu (Linux)**: The script supports adding right-click options for **Nautilus (GNOME)** file manager. Other file managers (Dolphin, Thunar, etc.) are not currently supported.
*   **Context Menu (macOS)**: Not supported natively by the script. See the workaround below to add it properly using Mac's Automator.
*   **Terminal**: Launches tools inside the current shell window rather than spawning new ones (unless using the Linux Context Menu integration).

---

## 🍏 macOS: How to Add Context Menu (Manual Workaround)

Since macOS context menus ("Quick Actions") are complex to script, you can create them manually using the built-in **Automator** app. This allows you to right-click a folder and open an AI tool.

### Step-by-Step Guide

1.  Open **Automator** (cmd + space, type "Automator").
2.  Select **New Document** -> **Quick Action** -> **Choose**.
3.  Configure the settings at the top:
    *   **Workflow receives current**: `folders`
    *   **In**: `Finder`
4.  In the left sidebar search, find **"Run AppleScript"** and drag it to the right panel.
5.  Paste the following code (replace `gemini` with the tool you want, e.g., `jules`, `vibe`):
    - gemini, jules, vibe, iflow, opencode, qwen, kilocode, copilot, nanocode.

```applescript
on run {input, parameters}
    tell application "Terminal"
        activate
        -- Get the path of the selected folder
        set folderPath to POSIX path of (item 1 of input)
        -- Open new window, cd to folder, and run tool
        do script "cd " & quoted form of folderPath & "; gemini"
    end tell
    return input
end run
```

6.  Save the Quick Action (File -> Save) and name it something clear, like **"Open Gemini CLI"**.
7.  **Done!** Now you can right-click any folder in Finder, go to **Quick Actions**, and select your new tool.

*Repeat these steps for each tool you want to duplicate.*
