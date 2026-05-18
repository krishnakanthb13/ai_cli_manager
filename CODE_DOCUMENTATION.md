# AI CLI Manager - Technical Documentation

## 🛠️ Technical Overview

This document describes the technical implementation and architecture of the AI CLI Manager.

## 📂 File Structure

| File | Description |
|------|-------------|
| `AI_CLI_Manager.bat` | Main automation script for Windows (Batch). |
| `AI_CLI_Manager.sh` | Main automation script for Linux and macOS (Bash). |
| `Multi_CLI_Grid.bat` | **[NEW]** Beast Mode grid launcher for Windows Terminal. |
| `Multi_CLI_Grid.sh` | **[NEW]** Beast Mode grid launcher for tmux (Linux/macOS). |
| `/Batch Files/` | Standalone `.bat` launch scripts for individual tools (Windows). |
| `/Shell Files/` | Standalone `.sh` launch scripts for individual tools (Linux/macOS). |
| `Icons/` | Directory containing tool icons and the conversion script. |
| `Icons/*_v2.ico` | Standardized icons with `_v2` suffix to bypass Windows Icon Cache (Cache Busting). |
| `Icons/convert_icons.py` | Python utility to convert images to .ico format with automatic `_v2` naming. |
| `Tools/` | Local storage for Git-cloned CLI tools (e.g., NanoCode). |
| `Log Files/` | Storage for session logs and registry backups. |
| `README.md` | Primary user guide and orientation. |
| `CODE_DOCUMENTATION.md` | Technical deep-dive into the codebase. |
| `DESIGN_PHILOSOPHY.md` | Rationale, design principles, and project goals. |
| `CONTRIBUTING.md` | Guidelines for external contributors. |
| `LICENSE` | GNU General Public License v3. |

## 🏗️ Architecture

### Main Components (Windows)
1. **Auto-Elevation Module**: Ensures the script runs with administrative privileges for registry modifications.
2. **Logging System**: A centralized logging mechanism using WMIC for cross-locale timestamping and storage in `Log Files/`.
3. **Dependency Manager**: Checks for Node.js, Python, and Git; installs missing CLI tools via `npm`, `pip`, or `git clone`.
4. **Registry Integrator**: Adds cascading context menus to Windows Explorer via `reg.exe`.
5. **CLI Wrapper**: Launches external terminal applications with proper directory context.

### Main Components (Linux/macOS)
1. **Dependency Checker**: Verifies environment requirements including Node.js, Python 3, Git, and curl.
2. **Nautilus Script Generator**: (Linux only) Creates scripts in `~/.local/share/nautilus/scripts` for context menu integration. Auto-detects the available terminal emulator (`gnome-terminal`, `xfce4-terminal`, `konsole`, `tilix`, `alacritty`, `xterm`).
3. **tmux Orchestrator**: Manages session creation and pane splitting for Grid View.
4. **Script-Relative Paths**: `SCRIPT_DIR` is resolved via `$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)` so logs and paths are always correct regardless of the calling directory.

## 🏁 CLI Beast Mode (Grid Architecture)

The "Beast Mode" grid (2x2) is implemented differently per platform to ensure native performance:

### 🖥️ Windows (Windows Terminal)
Uses the `wt.exe` command-line interface with sub-commands chained by semicolons:
- `new-tab -d [DIR] cmd /k [TL]`: Opens the first pane.
- `split-pane -V -d [DIR] cmd /k [TR]`: Vertically splits TL to create TR.
- `split-pane -H -d [DIR] cmd /k [BR]`: Horizontally splits TR to create BR.
- `move-focus left`: Shifts focus back to TL.
- `split-pane -H -d [DIR] cmd /k [BL]`: Horizontally splits TL to create BL.

### 🐧 Linux/macOS (tmux)
Uses standard `tmux` commands for session orchestration:
- `tmux new-session -d -s [NAME] -c [DIR]`: Creates the session.
- `tmux split-window -h -t [PANE] -c [DIR]`: Creates horizontal/vertical splits.
- `tmux send-keys`: Sends the CLI start command to each specific pane.
- Supports **detaching** (`Ctrl+B D`), allowing AI agents to persist in the background.

## 🧩 Core Methods & Functions (Windows Batch)

| Method/Label | Function |
|--------------|----------|
| `:ADMIN_CHECK` | Checks for `net session` and requests `RunAs` elevation if needed. |
| `:LOGGING_SETUP` | Initializes the `Log Files` directory and session log file. |
| `:MAIN_MENU` | Central navigation loop for the interface. |
| `:INSTALL_ALL` | Iterates through supported CLIs and installs them if missing. Uses `npm link` for local Git-based tools. |
| `:CHECK_NPM` | Checks and installs/updates a global NPM package. Compares local vs. registry version. |
| `:CHECK_PIP` | Checks and installs/updates a PIP package. Uses PyPI JSON API for latest version lookup. |
| `:CHECK_NANOCODE` | Specific logic for NanoCode: Clones from GitHub into `Tools/nanocode-2` and runs `npm link`. |
| `:CHECK_JUNIE` | Logic for Junie: Downloads and executes the official JetBrains installation script (`install.ps1`) via PowerShell. Displays the source URL before running. |
| `:CHECK_KIRO` | Logic for Kiro: Skipped on Windows (no native support). Refer to Linux script for curl-based install. |
| `:CHECK_CLI_EXEC` | **[v1.2.17]** Pre-launch guard. Uses `where` to verify a CLI command is in PATH before a terminal is spawned. Returns exit code 1 and shows a descriptive error if the command is missing. Called by every `:LAUNCH_*` label. |
| `:SHOW_VERSIONS` | Displays currently installed versions of all managed tools. Handles scoped NPM packages, PIP version parsing, and local binary checks for Junie and Kiro. |
| `:ADD_CONTEXT_MENU` | Performs `reg add` operations to create the cascading "Open with AI CLI" menu. Uses `%SCRIPT_DIR%` for absolute Kiro launcher path with double-double-quoting for space-safe registry values. |
| `:REMOVE_CONTEXT_MENU` | Performs `reg delete` to clean up registry entries. |
| `:BACKUP_REGISTRY` | Exports relevant registry keys to a `.reg` file for safety. |
| `:RESTART_EXPLORER` | Restarts the `explorer.exe` process. Polls `tasklist` in a loop to wait until the process is fully terminated before restarting. |
| `:DEEP_REFRESH_ICONS` | Force-clears Windows Icon Cache by deleting `.db` files and restarting Explorer. Uses the same poll-loop as `:RESTART_EXPLORER` to avoid race conditions on slow systems. |
| `:LAUNCH_*` | Wrapper labels for launching specific tools (Gemini, Jules, Claude, Codex, Cline, Junie, Qoder, etc.) with directory context. Each calls `:CHECK_CLI_EXEC` before spawning a terminal. |


## 🧩 Core Functions (Linux/macOS Bash)

| Function | Description |
|----------|-------------|
| `check_dependencies()` | Verifies Node.js, Python 3. Curl is checked inline before Junie/Kiro installs. |
| `install_npm_cli()` | Checks for and installs/updates global NPM packages. Compares local vs. registry version. |
| `install_pip_cli()` | Checks for and installs/updates Python pip packages via PyPI JSON API. |
| `install_nanocode()` | Git-clone + `npm link` workflow for NanoCode. Verifies `git` is available first. |
| `launch_tool()` | **[v1.2.17]** Pre-launch guard using `command -v` before executing a CLI. Shows a clear error and returns to menu if not found. |
| `create_script_file()` | **[v1.2.17]** Generates a Nautilus context menu script. Auto-detects the available terminal emulator in priority order: `gnome-terminal` → `xfce4-terminal` → `konsole` → `tilix` → `alacritty` → `xterm` → `x-terminal-emulator`. |
| `add_context_menu_linux()` | Generates Nautilus scripts for GNOME users by calling `create_script_file()` for each tool. |
| `remove_context_menu_linux()` | Removes the `AI CLI Tools` Nautilus scripts directory. |
| `restart_nautilus()` | Kills all Nautilus processes to refresh the context menu. |
| `show_versions()` | Displays installed versions for all managed tools. |

## 🔄 Data Flow

1. **Initialization**: Script runs → Admin Check → Logging Setup → Terminal Detection.
2. **Selection**: User selects an option from the interactive menu.
3. **Execution**:
   - **Install**: Check Node.js/Python/Git/curl → Check tool existence → `npm install`, `pip install`, or curl-based script.
   - **Launch**: Verify CLI in PATH (`CHECK_CLI_EXEC` / `command -v`) → Show error if missing → Detect directory → Spawn `wt.exe` or `cmd.exe` in target path.
   - **Registry**: Show safety info → User confirmation → `reg export` (optional) → `reg add` using absolute paths.
4. **Explorer Restart**: Terminate `explorer.exe` → Poll until process is gone → Clear cache files → Restart.
5. **Finalization**: Log action → Loop back to menu or Exit.

## 📦 Dependencies

- **Node.js**: Required for most CLIs.
- **Python 3 & pip**: Required for Mistral Vibe.
- **Git**: Required for cloning NanoCode and other repository-based tools.
- **curl**: (Linux/macOS) Required for Junie and Kiro installation scripts.
- **Windows Terminal**: Highly recommended for the best experience on Windows.
- **Nautilus**: (Linux) Required for the script's automated context menu feature.
- **tmux**: (Linux/macOS) Required for CLI Beast Mode grid layout.
- **Pillow (PIL)**: Python library required only if running the `convert_icons.py` utility. Install with `pip install Pillow`.

## 🔌 API & External Integrations

The project integrates with the following package managers:
- **npm (Node Package Manager)**: For `@google/gemini-cli`, `@google/jules`, `@iflow-ai/iflow-cli`, `@github/copilot`, `@anthropic-ai/claude-code`, `@openai/codex`, `cline`, `@qoder-ai/qodercli`, etc.

- **Git & npm link**: Specifically for `nanocode-agent` (cloned from GitHub).
- **Official One-liners**: For `Junie` (JetBrains) and `Kiro`.
- **pip (Python Package Installer)**: For `mistral-vibe`.
- **Windows Registry**: For shell context menu integration.
