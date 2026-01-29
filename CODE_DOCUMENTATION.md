# AI CLI Manager - Technical Documentation

## 🛠️ Technical Overview

This document describes the technical implementation and architecture of the AI CLI Manager.

## 📂 File Structure

| File | Description |
|------|-------------|
| `AI_CLI_Manager.bat` | Main automation script for Windows (Batch). |
| `AI_CLI_Manager.sh` | Main automation script for Linux and macOS (Bash). |
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
1. **Dependency Checker**: Verifies environment requirements.
2. **Nautilus Script Generator**: (Linux only) Creates scripts in `~/.local/share/nautilus/scripts` for context menu integration.

## 🧩 Core Methods & Functions (Windows Batch)

| Method/Label | Function |
|--------------|----------|
| `:ADMIN_CHECK` | Checks for `net session` and requests `RunAs` elevation if needed. |
| `:LOGGING_SETUP` | Initializes the `Log Files` directory and session log file. |
| `:MAIN_MENU` | Central navigation loop for the interface. |
| `:INSTALL_ALL` | Iterates through supported CLIs and installs them if missing. Uses `npm link` for local Git-based tools. |
| `:CHECK_NANOCODE` | Specific logic for NanoCode: Clones from GitHub into `Tools/nanocode-2` and runs `npm link`. |
| `:SHOW_VERSIONS` | Displays currently installed versions of all managed tools. Handles scoped NPM packages and PIP version parsing. |
| `:ADD_CONTEXT_MENU` | Performs `reg add` operations to create the cascading "Open with AI CLI" menu. |
| `:REMOVE_CONTEXT_MENU` | Performs `reg delete` to clean up registry entries. |
| `:BACKUP_REGISTRY` | Exports relevant registry keys to a `.reg` file for safety. |
| `:RESTART_EXPLORER` | Restarts the `explorer.exe` process to refresh shell extensions. |
| `:DEEP_REFRESH_ICONS` | Force-clears Windows Icon Cache by deleting `.db` files and restarting Explorer. |
| `:LAUNCH_*` | Wrapper labels for launching specific tools (Gemini, Jules, etc.) with directory context. |

## 🧩 Core Functions (Linux/macOS Bash)

| Function | Description |
|----------|-------------|
| `install_npm_cli()` | Checks for and installs global NPM packages. |
| `install_pip_cli()` | Checks for and installs Python pip packages. |
| `add_context_menu_linux()` | Generates Nautilus scripts for GNOME users. |

## 🔄 Data Flow

1. **Initialization**: Script runs -> Admin Check -> Logging Setup -> Terminal Detection.
2. **Selection**: User selects an option from the interactive menu.
3. **Execution**:
   - **Install**: Check tool existence -> `npm install` or `pip install`.
   - **Launch**: Detect directory -> Spawn `wt.exe` or `cmd.exe` in target path.
   - **Registry**: Show safety info -> User confirmation -> `reg export` (optional) -> `reg add`.
4. **Finalization**: Log action -> Loop back to menu or Exit.

## 📦 Dependencies

- **Node.js**: Required for most CLIs.
- **Python 3 & pip**: Required for Mistral Vibe.
- **Git**: Required for cloning NanoCode and other repository-based tools.
- **Windows Terminal**: Highly recommended for the best experience.
- **Nautilus**: (Linux) Required for the script's automated context menu feature.
- **Pillow (PIL)**: Python library required only if running the `convert_icons.py` utility.

## 🔌 API & External Integrations

The project integrates with the following package managers:
- **npm (Node Package Manager)**: For `@google/gemini-cli`, `@google/jules`, `@iflow-ai/iflow-cli`, `@github/copilot`, etc.
- **Git & npm link**: Specifically for `nanocode-agent` (cloned from GitHub).
- **pip (Python Package Installer)**: For `mistral-vibe`.
- **Windows Registry**: For shell context menu integration.
