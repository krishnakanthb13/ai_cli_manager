# AI CLI Manager - Linux & macOS Guide

This version of AI CLI Manager (`AI_CLI_Manager.sh`) provides a terminal interface to install, manage, and launch your supported AI CLI tools on Linux and macOS systems.

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the following installed:
*   **Node.js**: Required for most CLIs (npm).
*   **Python 3 & pip**: Required for Mistral Vibe.
*   **Git**: Required for NanoCode (cloned from GitHub).
*   **curl**: Required for Junie and Kiro CLI installers.

To check if you have them:
```bash
node -v
python3 --version
git --version
curl --version
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

*   **I. Check and Install All CLIs**: Automatically checks if supported tools (Gemini, Jules, iFlow, OpenCode, Qwen, KiloCode, Mistral Vibe, GitHub Copilot CLI, NanoCode, Claude, OpenAI Codex, Cline, Qoder) are installed. If missing, it attempts to install them via `npm` or `pip`.

    *   *Note*: If you run into permission errors, the script will attempt to ask for `sudo` password to install global packages.
    *   Junie and Kiro are installed via official `curl | bash` scripts. The download URL is shown before the script runs.
*   **V. Show Installed CLI Versions**: Displays the currently installed version of each tool.

### Launch Tools
All launch options verify the CLI exists in PATH before spawning a terminal. A clear error message is shown if a tool is not installed.

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
*   Claude CLI
*   OpenAI Codex CLI
*   Cline CLI
*   Junie CLI *(installed via JetBrains official script)*
*   Kiro CLI *(installed via official curl script)*
*   Qoder CLI


## ⚠️ Known Differences (vs Windows)
*   **Context Menu (Linux)**: The script supports adding right-click options for **Nautilus (GNOME)** file manager. Other file managers (Dolphin, Thunar, etc.) are not currently supported.
    *   The script auto-detects your terminal emulator (`gnome-terminal`, `xfce4-terminal`, `konsole`, `tilix`, `alacritty`, `xterm`) and uses it when generating context menu scripts.
*   **Context Menu (macOS)**: Not supported natively by the script. See the workaround below to add it properly using Mac's Automator.
*   **Terminal**: Launch options spawn the selected CLI in a new terminal window (auto-detected: `gnome-terminal`, `konsole`, `xfce4-terminal`, `tilix`, `alacritty`, `kitty`, `xterm`, `x-terminal-emulator`; on macOS the system Terminal.app via `osascript`). The manager menu stays open in the original shell. If no terminal emulator is detected, the script falls back to running the CLI inline.
*   **Kiro CLI**: Supported on Linux/macOS via `curl | bash`. Not available on Windows (WSL required).

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
    - gemini, jules, vibe, iflow, opencode, qwen, kilocode, copilot, nanocode, claude, codex, cline, qoder.


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
