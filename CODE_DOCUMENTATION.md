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
| `/Batch Files/archive/` | Legacy/superseded launcher scripts kept for historical reference (e.g., `AI_CLI_Manager_0.bat`). |
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
4. **Registry Integrator**: Adds cascading context menus ("AI CLI Manager (Primary)" and "AI CLI Manager (Secondary)") to Windows Explorer via `reg.exe` (split into two menus to bypass the Windows 16-item limit).
5. **CLI Wrapper**: Launches external terminal applications with proper directory context.

### Main Components (Linux/macOS)
1. **Dependency Checker**: Verifies environment requirements including Node.js, Python 3, Git, and curl.
2. **Nautilus Script Generator**: (Linux only) Creates scripts in `~/.local/share/nautilus/scripts` for context menu integration. Auto-detects the available terminal emulator (`gnome-terminal`, `xfce4-terminal`, `konsole`, `tilix`, `alacritty`, `xterm`).
3. **tmux Orchestrator**: Manages session creation and pane splitting for Grid View.
4. **Script-Relative Paths**: `SCRIPT_DIR` is resolved via `$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)` so logs and paths are always correct regardless of the calling directory.

## 🏁 CLI Beast Mode (Grid Architecture)

> **Note (v1.2.34)**: The Beast Mode grid now exposes **22 tools** (options 1–22) via `Multi_CLI_Grid.bat` / `Multi_CLI_Grid.sh`, matching the main manager. Preset Alpha has been updated to replace the deprecated Gemini CLI with Antigravity (`agy`). Deprecated entries (Gemini, iFlow) remain in the custom picker for backward compatibility but are labeled `(Dep)` and excluded from presets.

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
| `:CHECK_KIRO` | Logic for Kiro: Downloads and executes the official Kiro installation script (`install.ps1`) via PowerShell. |
| `:CHECK_ANTIGRAVITY` | Logic for Antigravity: Downloads and executes the official Google installation script (`install.ps1`) via PowerShell. |
| `:CHECK_CLI_EXEC` | **[v1.2.18]** Pre-launch guard. Uses `where` to verify a CLI command is in PATH before a terminal is spawned. Returns exit code 1 and shows a descriptive error if the command is missing. Called by every `:LAUNCH_*` label. |
| `:SHOW_VERSIONS` | Displays currently installed versions of all managed tools. **[v1.2.20]** All `npm list -g` calls use `--depth=0` and `findstr /C:"-- <pkg>@"` to anchor on the npm tree prefix, preventing substring matches against sub-dependencies. Mistral Vibe uses `findstr /B /C:"Version:"` to anchor on the first column. |
| `:ADD_CONTEXT_MENU` | Performs `reg add` operations to create the cascading "AI CLI Manager (Primary)" and "AI CLI Manager (Secondary)" menus. Splits the tools to bypass the Windows 16-item cascading menu limit. Uses `%SCRIPT_DIR%` for absolute launcher paths with double-double-quoting for space-safe registry values. |
| `:REMOVE_CONTEXT_MENU` | Performs `reg delete` to clean up registry entries for both Primary and Secondary menus. |
| `:BACKUP_REGISTRY` | Exports relevant registry keys to a `.reg` file for safety. **[v1.2.20]** Generates a fresh `wmic` timestamp at backup time so multiple backups in one session don't overwrite each other. |
| `:RESTART_EXPLORER` | Restarts the `explorer.exe` process. **[v1.2.20]** Polls `tasklist` with a 10-retry (≈10 s) cap before proceeding with a logged `[WARN]` to avoid infinite waits if explorer fails to terminate. |
| `:DEEP_REFRESH_ICONS` | Force-clears Windows Icon Cache by deleting `.db` files and restarting Explorer. Uses the same bounded poll-loop as `:RESTART_EXPLORER`. |
| `:LAUNCH_*` | Wrapper labels for launching specific tools (Gemini, Jules, Claude, Codex, Cline, Junie, Qoder, Antigravity, etc.) with directory context. Each calls `:CHECK_CLI_EXEC` before spawning a terminal. **[v1.2.20]** All launch labels route through `:LAUNCH_DONE` after spawning, which returns to `:MAIN_MENU` so multiple CLIs can be launched in one session. |
| `:LAUNCH_DONE` | **[v1.2.20]** Post-launch trampoline. Logs success and `goto MAIN_MENU` so the manager menu remains the foreground process. Previously every launch ended at `:EXIT_SCRIPT`, terminating the manager. |
| `:CHECK_NPM` / `:CHECK_NANOCODE` | **[v1.2.20]** `findstr` calls use `/C:"-- <pkg>@"` to anchor on the npm tree prefix (`+-- ` / `\`-- `), preventing false matches against sub-dependencies for generic names like `cline`. |


## 🧩 Core Functions (Linux/macOS Bash)

| Function | Description |
|----------|-------------|
| `check_dependencies()` | Verifies Node.js, Python 3. Curl is checked inline before Junie/Kiro installs. |
| `install_npm_cli()` | Checks for and installs/updates global NPM packages. Compares local vs. registry version. |
| `install_pip_cli()` | Checks for and installs/updates Python pip packages via PyPI JSON API. |
| `install_nanocode()` | Git-clone + `npm link` workflow for NanoCode. Verifies `git` is available first. |
| `launch_tool()` | **[v1.2.18]** Pre-launch guard using `command -v` before executing a CLI. **[v1.2.20]** Now delegates to `spawn_in_terminal` to open the CLI in a new terminal window, so the manager menu no longer blocks (previously `$cmd` ran inline, allowing Ctrl+C in the CLI to kill the manager). |
| `detect_terminal()` | **[v1.2.20]** Returns the name of the first available terminal emulator (`gnome-terminal`, `konsole`, `xfce4-terminal`, `tilix`, `alacritty`, `kitty`, `xterm`, `x-terminal-emulator`); returns `osascript-mac` on macOS. Empty result indicates no emulator is available. |
| `spawn_in_terminal()` | **[v1.2.20]** Cross-platform new-window launcher. Routes to the matching `--` / `-e` flag for each emulator, uses AppleScript on macOS, and falls back to running the command inline (with `pause`) if no terminal is detected. Backgrounds + disowns spawned processes so the manager menu remains responsive. |
| `create_script_file()` | **[v1.2.18]** Generates a Nautilus context menu script. Auto-detects the available terminal emulator in priority order: `gnome-terminal` → `xfce4-terminal` → `konsole` → `tilix` → `alacritty` → `xterm` → `x-terminal-emulator`. |
| `add_context_menu_linux()` | Generates Nautilus scripts for GNOME users by calling `create_script_file()` for each tool. |
| `remove_context_menu_linux()` | Removes the `AI CLI Tools` Nautilus scripts directory. |
| `restart_nautilus()` | Kills all Nautilus processes to refresh the context menu. |
| `show_versions()` | Displays installed versions for all managed tools. |

## 🤖 Standalone Per-CLI Launchers (Model Selectors)

A subset of the launcher scripts in `/Batch Files/` and `/Shell Files/` expose a tool's model lineup as a numbered menu so users can pick the variant per session without remembering the CLI flag syntax. They follow a shared pattern: PATH check → grouped menu → invoke the CLI with `--model <alias>` (or no flag for the account default).

| Launcher | Models exposed (passed via `--model`) |
|----------|---------------------------------------|
| `LaunchClaude.bat` / `LaunchClaude.sh` | **Opus**: `claude-opus-4-8`, `claude-opus-4-8[1m]`, `claude-opus-4-7`, `claude-opus-4-7[1m]`, `opusplan` · **Sonnet**: `sonnet`, `sonnet[1m]` · **Haiku**: `haiku` · **Other**: `best` (resolves to most capable, currently Opus), `default` (account-tier default — Opus 4.8 for Max/Team Premium, Sonnet 4.6 for Pro/Enterprise/API). **[v1.2.26]** Opus 4.8 (latest) and Opus 4.8 [1M] were added at the top of the Opus group; the 4.7 entries were repinned from the bare `opus`/`opus[1m]` aliases to the explicit model IDs `claude-opus-4-7`/`claude-opus-4-7[1m]` because the bare `opus` alias now rolls forward to 4.8 and would otherwise launch the wrong version. The `[1m]` suffix activates the 1M-token context window per Anthropic's [model-config docs](https://code.claude.com/docs/en/model-config). Bracketed aliases are kept inside quotes (`"%model%"` / `"$model"`) so the shell does not interpret them as glob/bracket expressions. |
| `LaunchOpenCode.bat` / `LaunchOpenCode.sh` | OpenCode model list (maintained by the `update_opencode_models` skill in `.agent/skills/`). |
| `LaunchAider.bat` / `LaunchAider.sh` | Aider CLI launcher — PATH check for `aider`, interactive prompt for directory, spawns via Windows Terminal or `cmd.exe` (Windows) / `spawn_in_terminal` (Linux/macOS). Installs via `pip install aider-chat` if missing. |
| `LaunchInterpreter.bat` / `LaunchInterpreter.sh` | Open Interpreter CLI launcher — PATH check for `interpreter`, interactive prompt for directory, spawns via Windows Terminal or `cmd.exe` (Windows) / `spawn_in_terminal` (Linux/macOS). Installs via `pip install open-interpreter` if missing. |

Menu labels include the explicit version number (e.g. *Claude Opus 4.8*, *Claude Opus 4.7*, *Claude Sonnet 4.6*, *Claude Haiku 4.5*) so users see at a glance which underlying model an alias resolves to today. Aliases such as `sonnet`/`haiku`/`best` auto-roll forward when Anthropic publishes a new generation, so only their menu strings need a bump; version-pinned entries that must stay on a specific generation (e.g. Opus 4.7) instead use the full `claude-opus-4-7` model ID so they do not drift when the bare alias advances.

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
- **npm (Node Package Manager)**: For `@google/gemini-cli`, `@google/jules`, `@iflow-ai/iflow-cli`, `@github/copilot`, `@openai/codex`, `cline`, `@qoder-ai/qodercli`, etc.

- **Git & npm link**: Specifically for `nanocode-agent` (cloned from GitHub).
- **Official One-liners**: For `Junie` (JetBrains), `Kiro`, `Claude` (Anthropic), and `Antigravity` (Google).
- **pip (Python Package Installer)**: For `mistral-vibe`.
- **Windows Registry**: For shell context menu integration.

## 🆕 Version 1.2.27 Updates
- **Deprecations**:
  - **Gemini CLI** and **iFlow CLI** are officially deprecated and execution has been commented out.
  - Launcher scripts renamed to `LaunchGemini_deprecated.bat` / `.sh` and `LaunchIFlow_deprecated.bat` / `.sh`. Custom warning screens redirect users to **Antigravity CLI** (`agy`) and **Qoder CLI** (`qodercli`).
  - Right-click Explorer context menu and Nautilus scripts updated to reflect `(Deprecated)` status and launch the warning wrappers.
- **Additions**:
  - Added **Aider CLI** (`aider-chat`) and **Open Interpreter CLI** (`open-interpreter`) to the manager.
  - Created standalone launchers: `LaunchAider` and `LaunchInterpreter` (.bat and .sh).
  - Wired into main loops: Added options 18 & 19, version validation, smart setup, and Explorer context menu integrations with cache-busted icons.
- **OpenCode Sync**:
  - Updated model lists in `LaunchOpenCode.bat` / `.sh` to include `minimax-m3-free`, `nemotron-3-ultra-free`, and `north-mini-code-free`.

## 🆕 Version 1.2.28 Updates
- **Additions**:
  - Added **MiMo Code CLI** (`@mimo-ai/cli` as command `mimo`) as option 20 in the manager.
  - Created batch and shell launcher scripts: `LaunchMiMo.bat` and `LaunchMiMo.sh`.
  - Added to smart installer checks (Option `I`), versions checks (Option `V`), context menu integrations (Option `A`), and grid layouts.
  - Converted the user's `mimo.png` to cache-busted `mimo_v2.ico` for desktop right-click menu items.

## 🆕 Version 1.2.34 Updates
- **Additions**:
  - Added **Freebuff CLI** (`freebuff`) as option 21 in the manager.
  - Added **Perch AI CLI** (`perchai-cli` as command `perch`) as option 22 in the manager.
  - Created batch and shell launcher scripts for Perch AI: `LaunchPerchAI.bat` and `LaunchPerchAI.sh`.
  - Updated main batch and shell manager menus, installer checks, version checks, cascading Windows registry right-click menu, and Nautilus scripts.
  - Generated and integrated a stylized `perch.png` and cache-busted `perch_v2.ico` for Windows Registry context menu item icons.
  - Wired into `Multi_CLI_Grid.bat` and `Multi_CLI_Grid.sh` custom quadrants selection to allow orchestrating Perch AI in Beast Mode.

