# AI CLI Manager - User Guide

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## 📖 Overview
**AI CLI Manager (v1.1.10)** is your central hub for installing, launching, and integrating AI coding assistants into Windows.

![Release Banner](assets/release_banner-v1.1.10.1.png)

<img src="assets/release_banner-v1.1.10.png" width="500" alt="Release Banner">

## 📚 Project Documentation
- **[Technical Documentation](CODE_DOCUMENTATION.md)**: Architecture, core methods, and data flow.
- **[Design Philosophy](DESIGN_PHILOSOPHY.md)**: The rationale, principles, and target users.
- **[Contributing Guide](CONTRIBUTING.md)**: How to report bugs and submit code.
- **[Linux & macOS Guide](LINUX_MAC_README.md)**: Specific instructions for non-Windows platforms.

## 🚀 Getting Started (Windows)

1.  **Run the Manager**: Double-click `AI_CLI_Manager.bat`
    *   ✅ **Auto-elevation**: Automatically requests Administrator privileges
    *   ✅ **Windows Terminal detection**: Falls back to CMD if WT not available
2.  **Main Menu**: Type the number of the option you want and press Enter

## ⚙️ Main Menu Options

### --- CLI Management ---

#### `I` Check and Install All CLIs
*   **What it does:** Checks if each CLI is installed
*   **Action:** Only installs missing tools (skips already installed)
*   **Output:** `[ALREADY INSTALLED]` or `[INSTALLED]` for each tool
*   **Prerequisites:** Requires Node.js (and Python for Mistral Vibe)
*   **Launch Pad**: Instantly launch Gemini, Jules, Vibe, iFlow, OpenCode, Qwen, KiloCode, Copilot, NanoCode, Claude, or OpenAI Codex.
*   **Smart Install**: Automatically checks for Node.js, Python, and Git. Installs missing CLIs via `npm`, `pip`, or `git clone` into the `/Tools` directory followed by `npm link`.

#### `V` Show Installed CLI Versions
*   **Version Check**: Quickly see which versions of Gemini, Jules, Vibe, etc., are installed.
*   **Shows:** Package name with version, or `[NOT INSTALLED]`

### --- Launch CLIs ---

#### `1-9` Launch Specific CLIs
| Option | Tool |
|--------|------|
| 1 | Gemini CLI |
| 2 | Jules CLI |
| 3 | Mistral Vibe CLI |
| 4 | iFlow CLI |
| 5 | OpenCode CLI |
| 6 | Qwen Code CLI |
| 7 | KiloCode CLI |
| 8 | GitHub Copilot CLI |
| 9 | NanoCode CLI |
| 10 | Claude CLI |
| 11 | OpenAI Codex CLI |

*   **Behavior:** Opens in Windows Terminal (or CMD fallback)
*   **Directory:** Uses passed path or defaults to User Profile folder

### --- Context Menu ---

#### `A` Add to Windows Context Menu 🔥
*   **What it does:** Adds "Open with AI CLI" cascading menu to right-click
*   **Technical:** Uses `MUIVerb` for proper cascading submenu support
*   **How to use after adding:**
    1.  Go to **any folder** in Windows Explorer
    2.  **Right-click** on empty space (or the folder itself)
    3.  Hover over **"Open with AI CLI"**
    4.  Select the AI agent you want
    5.  Terminal opens **exactly in that folder**

#### `B` Remove from Windows Context Menu
*   **What it does:** Completely removes the right-click menu entries
*   **Confirmation:** Asks Y/N before proceeding

#### `C` Export Registry Backup
*   **What it does:** Saves a backup of registry settings to `Log Files` folder
*   **Recommendation:** Run this *before* using Option A for the first time

### --- Utilities ---

#### `D` Restart File Explorer
*   **What it does:** Restarts Windows Explorer to apply menu changes.
*   **Technical:** Uses `taskkill /f /im explorer.exe` then `start explorer.exe`.

#### `E` Deep Refresh Icons (Clear Cache) 🔥
*   **What it does:** Force-clears the Windows Icon Cache to resolve issues where old or broken icons persist.
*   **Recommended:** Use this after modifying or updating icon files.
*   **Technical:** Deletes `IconCache.db` and Explorer's `iconcache*.db` then restarts File Explorer.

#### `0` Exit
*   **What it does:** Closes the manager and ends session

## 📦 Supported Tools

| Tool | Package | Type | Command |
|------|---------|------|---------|
| **Gemini** | `@google/gemini-cli` | NPM | `gemini` |
| **Jules** | `@google/jules` | NPM | `jules` |
| **Mistral Vibe** | `mistral-vibe` | PIP | `vibe` |
| **iFlow** | `@iflow-ai/iflow-cli` | NPM | `iflow` |
| **OpenCode** | `opencode-ai` | NPM | `opencode` |
| **Qwen Code** | `@qwen-code/qwen-code` | NPM | `qwen` |
| **KiloCode** | `@kilocode/cli` | NPM | `kilocode` |
| **GitHub Copilot** | `@github/copilot` | NPM | `copilot` |
| **NanoCode** | `nanocode-agent` | Git + NPM Link | `nanocode` |
| **Claude** | `@anthropic-ai/claude-code` | NPM | `claude` |
| **OpenAI Codex** | `@openai/codex` | NPM | `codex` |

## 📝 Logging

All actions are logged to timestamped files in the `Log Files` folder:
- **Log files:** `AI_CLI_MG_YYYYMMDD_HHMMSS_mmm.log`
- **Registry backups:** `AI_CLI_Backup_YYYYMMDD_HHMMSS.reg`

**Logged items:** User inputs, operations, errors, timestamps

## ⚠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| **"Access Denied"** | Right-click > "Run as Administrator" |
| **Tool not found after install** | Restart terminal or computer to refresh PATH |
| **Menu not appearing** | Use Option D to restart Explorer, or reboot |
| **Old icons still show** | Use Option E (Deep Refresh) to clear the system icon cache |
| **Submenu not showing** | Run Option B then Option A to re-add menu |

---

## 🍎 Getting Started (Linux / macOS)

1.  **Make Executable**: `chmod +x AI_CLI_Manager.sh`
2.  **Run**: `./AI_CLI_Manager.sh`
3.  *See `LINUX_MAC_README.md` for full details.*


## 🐧 Testing & Using Linux/Mac Script on Windows

You can run the `AI_CLI_Manager.sh` script on Windows to test its functionality or use it in a Linux-like environment.

### Option 1: Using Git Bash (Easiest)
If you have Git installed, you likely have **Git Bash**.

1.  **Right-click** inside the `ai_cli_manager` folder.
2.  Select **"Open Git Bash Here"**.
3.  Make the script executable:
    ```bash
    chmod +x AI_CLI_Manager.sh
    ```
4.  Run the script:
    ```bash
    ./AI_CLI_Manager.sh
    ```
    *   *Note: `sudo` commands may fail, but menu navigation and standard installs should work.*

### Option 2: Using WSL (Recommended for Full Testing)
For a complete Linux experience, use **Windows Subsystem for Linux (WSL)**.

1.  **Install WSL** (if not already installed):
    *   Open PowerShell as Administrator and run: `wsl --install`
    *   Restart your computer if prompted.
2.  **Open WSL Terminal**:
    *   Open "Ubuntu" (or your distro) from the Start Menu.
3.  **Navigate to Project**:
    *   WSL mounts your C: drive at `/mnt/c`.
    ```bash
    cd /mnt/c/Users/krishnakanthb13/Documents/GitHub/ai_cli_manager
    ```
4.  **Run the Script**:
    ```bash
    chmod +x AI_CLI_Manager.sh
    ./AI_CLI_Manager.sh
    ```

## ⚖️ License

This project is licensed under the **GNU General Public License v3**. See the [LICENSE](LICENSE) file for the full text.

Copyright (C) 2026 Krishna Kanth B
