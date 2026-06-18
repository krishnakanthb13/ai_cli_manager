# AI CLI Manager - Release Notes

## [v1.2.27] - 2026-06-18

### 🚀 New Features & Additions
- **Aider CLI Support**: Integrated Aider CLI (`aider-chat` on PyPI). Added options `18. Launch Aider CLI` to the main menus, programmed automated version checks (`pip show aider-chat`) and install routines (`pip install aider-chat`), created standalone launchers (`LaunchAider.bat` and `LaunchAider.sh`), and added Windows/Nautilus context menu options complete with its new icon.
- **Open Interpreter CLI Support**: Integrated Open Interpreter CLI (`open-interpreter` on PyPI). Added options `19. Launch Open Interpreter CLI` to the main menus, version validation, automatic setup, and Explorer context menu integrations utilizing a new cache-busted custom icon. Created `LaunchInterpreter.bat` and `LaunchInterpreter.sh` launchers.
- **Icon Assets**: Added custom icon assets for both new CLIs: `aider_v2.ico` and `interpreter_v2.ico`.

### 🔴 Deprecations
- **Gemini & iFlow CLIs Sunsetted**: 
  - Gemini CLI (`gemini`) and iFlow CLI (`iflow`) have been deprecated and their execution logic commented out.
  - Launcher scripts renamed to `LaunchGemini_deprecated.bat` / `.sh` and `LaunchIFlow_deprecated.bat` / `.sh`. Custom warning screens redirect users to **Antigravity CLI** (`agy`) and **Qoder CLI** (`qodercli`) respectively.
  - Explorer right-click context menu registry entries and Nautilus scripts updated to append `(Deprecated)` to their titles and point directly to the deprecated warning launchers.
  - Main menu listings updated to display `(Deprecated)`.

### 🔄 OpenCode Sync
- **OpenCode Model Sync**: Updated model lists in `LaunchOpenCode.bat` / `LaunchOpenCode.sh` to include `minimax-m3-free`, `nemotron-3-ultra-free`, and `north-mini-code-free` (updating older Minimax and Nemotron versions).

### 🧹 Housekeeping
- **Version Sync**: Bumped header banners in `AI_CLI_Manager.bat`, `AI_CLI_Manager.sh`, and `README.md` to `v1.2.27`.

## [v1.2.26] - 2026-05-29

### 🚀 New Features
- **Claude Opus 4.8 in the model selector**: Added Anthropic's latest flagship to `Batch Files/LaunchClaude.bat` and `Shell Files/LaunchClaude.sh`. The **Opus** group now leads with `[1] Claude Opus 4.8 (Latest - Most Capable)` and `[2] Claude Opus 4.8 [1M]` (1M-token context window), with the previous `[3] Claude Opus 4.7` / `[4] Claude Opus 4.7 [1M]` retained as legacy options and `[5] Claude Opus Plan` rounding out the group. Sonnet, Haiku, and the Other section shifted down to `[6]`–`[10]`, and the input prompt / invalid-choice guard now accept `0-10`.
- **Version-pinned Opus aliases**: The 4.8 entries invoke the explicit model IDs `claude-opus-4-8` / `claude-opus-4-8[1m]`, and the 4.7 entries were repinned from the bare `opus` / `opus[1m]` aliases to `claude-opus-4-7` / `claude-opus-4-7[1m]`. Because the bare `opus` alias auto-rolls forward to the newest generation (now 4.8), the previous "4.7" menu items would have silently launched 4.8 — the explicit IDs keep each labeled option on its stated version.

### 📚 Documentation Sync
- **`CODE_DOCUMENTATION.md`**: Updated the *Standalone Per-CLI Launchers* table to list the new Opus 4.8 IDs and the repinned 4.7 IDs, noted that account-tier `default` now resolves to Opus 4.8 for Max/Team Premium, and refined the menu-label note to explain when an entry uses an auto-rolling alias vs. a version-pinned model ID.

### 🧹 Housekeeping
- **Version sync**: Bumped header banners in `AI_CLI_Manager.bat`, `AI_CLI_Manager.sh`, and the `README.md` overview line to `v1.2.26` (catching the manager scripts up from `v1.2.24` after the `v1.2.25` OpenCode-models release left them un-synced). The `README.md` release-banner image still references `assets/release_banner-v1.2.24.png`, as no newer banner asset has been generated.

---

## [v1.2.24] - 2026-05-26

### 🚀 New Features
- **Kimi Code CLI Support**: Added MoonshotAI's `kimi-cli` (PyPI) as the 17th managed CLI. Includes `Batch Files/LaunchKimi.bat` and `Shell Files/LaunchKimi.sh` standalone launchers (mirroring the pip-based pattern used by Mistral Vibe), with `pip install kimi-cli` install/update hints and a PATH probe for the `kimi` executable.
- **Manager Integration**: `AI_CLI_Manager.bat` and `AI_CLI_Manager.sh` now expose `17. Launch Kimi Code CLI` on the main menu, route the choice into a new `:LAUNCH_KIMI` block (Windows) / `launch_tool "kimi"` case (Linux/macOS), bundle `kimi-cli` into the Python branch of the `Install All` flow via `:CHECK_PIP` / `install_pip_cli`, and surface its version under both `:SHOW_VERSIONS` and `show_versions` using `pip show kimi-cli` / `pip3 show kimi-cli`.
- **Context Menu Integration**: Added `Open with Kimi Code CLI` entries to both Windows registry submenus (`HKCR\Directory\Background\shell\AI_CLI_Menu` and `HKCR\Directory\shell\AI_CLI_Menu`) and the Linux Nautilus scripts folder, each pointing at the `kimi` executable.
- **Visual Identity**: Added `Icons/kimi.png` and generated `Icons/kimi_v2.ico` via `Icons/convert_icons.py` (multi-size 16/32/48/64/128/256 ICO) so the new context-menu entry renders with a proper cascading-menu icon.

### 🧹 Housekeeping
- **Version sync**: Bumped header banners in `AI_CLI_Manager.bat`, `AI_CLI_Manager.sh`, and the `README.md` overview line from `v1.2.23` to `v1.2.24`.
- **Icon re-encode noise (17 files)**: All previously committed `Icons/*_v2.ico` files appear as modified in this commit even though no source PNG changed. `Icons/convert_icons.py` is non-incremental — it globs every `*.png` in the folder and unconditionally overwrites `<name>_v2.ico` on each run. Earlier re-runs produced byte-identical output and so showed no git diff; this run was performed against **Pillow 12.2.0 / Python 3.12.10**, and Pillow's ICO encoder has shifted slightly across versions in how it writes the embedded 256×256 PNG sub-image (different zlib metadata / chunk ordering). A binary diff confirmed that for every affected ICO the header and the 16/32/48/64/128 sub-images are byte-identical; only the 256×256 frame differs by ~12 bytes. There is no visual or functional change to any icon — the diff is purely encoder-level. Committed as-is so future re-runs against this same Pillow baseline will once again show no diff.

---

## [v1.2.23] - 2026-05-24

### 🚀 New Features
- **Claude CLI Model Selector Menu**: Expanded `Batch Files/LaunchClaude.bat` and `Shell Files/LaunchClaude.sh` to expose Anthropic's full alias lineup as a grouped, numbered picker. Sections are split by model family — **Opus** (`opus`, `opus[1m]`, `opusplan`), **Sonnet** (`sonnet`, `sonnet[1m]`), **Haiku** (`haiku`) — followed by an **Other** section for `best` (most capable, currently Opus) and `default` (account-tier default). Menu labels now show the current resolved version (Opus 4.7, Sonnet 4.6, Haiku 4.5) so users can see what an alias actually maps to.
- **1M-token context aliases surfaced**: Options `[2]` and `[5]` invoke `claude --model "opus[1m]"` / `claude --model "sonnet[1m]"`, activating Anthropic's 1M-token context window per the [model-config spec](https://code.claude.com/docs/en/model-config). The bracket suffix is kept inside double quotes so neither bash globbing nor `cmd.exe` parsing mangles it; lowercase `[1m]` and no space before the bracket match Anthropic's documented format.
- **`opusplan` hybrid alias**: Surfaced as option `[3]`. Uses Opus during plan mode and auto-switches to Sonnet for execution, giving the best of both reasoning and throughput in a single session.

### 📚 Documentation Sync
- **`CODE_DOCUMENTATION.md`**: Added a new **Standalone Per-CLI Launchers (Model Selectors)** subsection documenting the shared launcher pattern (PATH check → grouped menu → `--model <alias>` invocation) and tabulating which aliases each launcher exposes. Notes the quoting requirement for bracketed aliases and links to Anthropic's model-config docs.
- **`LINUX_MAC_README.md`**: Added a blockquote callout under the *Launch Tools* section describing the Claude launcher's grouped model picker, the current resolved versions, and the bracket-attached `[1m]` format.

### 🧹 Housekeeping
- **Version sync**: Bumped header banners in `AI_CLI_Manager.bat`, `AI_CLI_Manager.sh`, and the `README.md` overview line from `v1.2.21` to `v1.2.23`, catching the manager scripts up after the `v1.2.22` OpenCode-launcher release left them un-synced.

---

## [v1.2.21] - 2026-05-20

### 🚀 New Features
- **Google Antigravity CLI Support**: Added support for Google's agentic coding assistant CLI. Included installation routines (`CHECK_ANTIGRAVITY` using Google's official install script via PowerShell), menu launching logic, and Windows Terminal/cmd launch parameters.
- **Nautilus and Registry Context Menu Integration**: Integrated Antigravity CLI into right-click context menus (`Open with Antigravity CLI` in Windows Explorer registry additions and Linux Nautilus scripts).
- **Beast Mode Custom Grid Picker**: Added option `16. agy` to Custom Grid Picker in `Multi_CLI_Grid.bat` and `Multi_CLI_Grid.sh` allowing users to include Antigravity in their quad-pane workspace.
- **Cache-Busted Visual Identity**: Generated and added high-quality `antigravity_v2.ico` for seamless system cascading menu integration.

### 📚 Documentation Sync
- **Technical & Design Guides**: Synced `README.md`, `CODE_DOCUMENTATION.md`, and `DESIGN_PHILOSOPHY.md` to document the 16th CLI tool addition.

---

## [v1.2.20] - 2026-05-18

### 🐛 Bug Fixes
- **Windows manager no longer exits after launching a CLI**: All 14 `:LAUNCH_*` labels in `AI_CLI_Manager.bat` previously ended with `goto EXIT_SCRIPT`, forcing the user to relaunch the manager between CLIs. They now route through a new `:LAUNCH_DONE` label that returns to `:MAIN_MENU`, matching the Linux/macOS behavior.
- **Linux/macOS launcher no longer blocks the menu**: `launch_tool` in `AI_CLI_Manager.sh` previously ran `$cmd` inline, which made the CLI hijack the manager process (Ctrl+C in the CLI would kill the menu). It now spawns the CLI in a new terminal window via the new `spawn_in_terminal` helper, with `detect_terminal` covering gnome-terminal, konsole, xfce4-terminal, tilix, alacritty, kitty, xterm, x-terminal-emulator, and macOS Terminal.app via `osascript`. Falls back to inline run if no emulator is available.
- **Piped install exit-code check fixed (Linux/macOS)**: Claude, Junie, and Kiro installers piped `curl ... | bash` and only checked `${PIPESTATUS[0]}` (curl). A failing install script was reported as `[INSTALLED]`. Now requires both `PIPESTATUS[0]` (curl) and `PIPESTATUS[1]` (bash) to be zero.
- **Empty folders no longer rejected in Beast Mode (Windows)**: `Multi_CLI_Grid.bat` validated the user-supplied directory with `if not exist "!LAUNCH_DIR!\*"`, which is false for valid but empty folders. Switched to `if not exist "!LAUNCH_DIR!\"` (trailing-backslash form).
- **Beast Mode folder retry no longer recurses (Linux/macOS)**: `ask_folder` in `Multi_CLI_Grid.sh` recursively self-called on invalid input, growing the stack on each retry. Replaced with a `while true; do … done` loop.
- **npm version parsing tightened**: `:CHECK_NPM`, `:CHECK_NANOCODE`, and `:SHOW_VERSIONS` previously used `findstr "<pkg>"`, which could substring-match unrelated sub-dependency lines (a real risk for short package names like `cline`). All `findstr` calls now use `/C:"-- <pkg>@"` to anchor on the npm tree marker, plus `--depth=0` on every `npm list -g` call for the version listing.
- **Mistral Vibe version parser anchored**: `pip show mistral-vibe | findstr "Version"` could match `Requires-Version:` or similar fields. Now uses `findstr /B /C:"Version:"` to only match the line that starts with `Version:`.
- **Backups no longer overwrite each other**: `:BACKUP_REGISTRY` reused the session-start `%TIMESTAMP%`, so multiple backups in a single session clobbered the previous file. It now computes a fresh timestamp via `wmic` at backup time.
- **Explorer-restart polling now has a timeout**: `:WAIT_EXPLORER_RESTART` and `:WAIT_EXPLORER_DEEP` polled `tasklist` indefinitely if `explorer.exe` failed to terminate. Capped at 10 retries (≈10 s) and proceeds with a logged `[WARN]` afterwards.
- **Quoted `%model%` in OpenCode launcher**: `Batch Files/LaunchOpenCode.bat` invoked `cmd /c opencode --model %model%` with an unquoted variable. Wrapped in `"…"` so a future model ID containing spaces is passed as a single argument.
- **Quoted `$CMD` expansions in Mistral launcher**: `Shell Files/LaunchMistral.sh` used unquoted `command -v $CMD` and `$CMD`. Switched to `"$CMD"` in both spots to avoid word-splitting/globbing if the variable is ever changed.
- **Root path "/" preserved in Beast Mode folder picker**: `Multi_CLI_Grid.sh` stripped trailing slashes via `${LAUNCH_DIR%/}`, which collapsed `/` to an empty string and broke the subsequent `-d` validation. Guarded so `/` is preserved while other paths still get their trailing slash trimmed.

### 🧹 Housekeeping
- **Cross-platform launcher filename parity**: Renamed `Batch Files/LaunchOpencode.bat` → `LaunchOpenCode.bat` and `Shell Files/LaunchMistralVibe.sh` → `LaunchMistral.sh` so the same name works on case-sensitive Linux/macOS file systems. Updated all references in `.agent/skills/update_opencode_models/SKILL.md`, `.agent/workflows/update_opencode_models.md`, and `Log Files/0_CLI_README.md`.
- **Legacy launcher archived**: Moved the stale `Batch Files/AI_CLI_Manager_0.bat` (v1.1-era, 510 lines) to `Batch Files/archive/` so it's not mistaken for the current entry point.

### 📚 Version Sync
- Version strings updated from `v1.2.19` to `v1.2.20` across `AI_CLI_Manager.bat`, `AI_CLI_Manager.sh`, and `README.md`.

---

## [v1.2.19] - 2026-05-18

### ⚡ Improvements
- **Comprehensive Documentation Sync**: Formalized pre-launch guards and terminal detection lists in `CODE_DOCUMENTATION.md` and `DESIGN_PHILOSOPHY.md`.
- **Linux/macOS Dependency Guidelines**: Added curl and installer details for Kiro CLI to `LINUX_MAC_README.md`.
- **Active Version Sync**: Updated version references across all launchers and docs to `v1.2.19` to establish a new stable release point.

---

## [v1.2.18] - 2026-05-18

### 🚀 New Features
- **Pre-Launch CLI Validation**: Integrated robust PATH verification (`where` / `command -v`) across all 14 CLI launchers. If a tool is missing, it logs a clean error message and advises running Option `I` (install) instead of silently crashing or spawning a broken terminal.
- **Intelligent Linux Terminal Auto-detection**: Refactored the context menu generation for Nautilus (GNOME). Instead of hardcoding `gnome-terminal`, the installer auto-detects the active emulator in order of priority: `gnome-terminal` → `xfce4-terminal` → `konsole` → `tilix` → `alacritty` → `xterm` → falling back to `x-terminal-emulator`.
- **Self-Healing Explorer Restart (Polling Lock)**: Fixed a race condition during Windows Explorer restarts for Icon Cache refreshes. A recursive poll loop (`tasklist` check) ensures `explorer.exe` is completely stopped before any cache files are deleted, avoiding locked-file conflicts.
- **Enhanced Icon Processing Engine (`convert_icons.py`)**:
  - Added a clean `ImportError` guard for missing `Pillow` with a friendly hint to run `pip install Pillow`.
  - Integrated image dimension limit (maximum 4096px) to protect system memory.
  - Upgraded to typed exceptions (`OSError`, `SyntaxError`) to catch corrupt image files specifically.
  - Improved summary counts (tracks converted, skipped, and failed icons).

---

## [v1.2.17] - 2026-05-18

### 🐛 Bug Fixes
- **Silent launch failure fixed**: All 14 `LAUNCH_*` sections now verify the CLI exists in PATH via `where`/`command -v` before spawning a terminal. A clear error message and install instructions are shown instead of a silent no-op.
- **Kiro registry path corrected**: Context menu entries for Kiro CLI were using `%%~dp0` — a batch-script-only variable that does not expand in registry command execution context. Fixed to use the absolute `%SCRIPT_DIR%` path with proper double-quoting for paths that contain spaces.
- **Icon cache race condition resolved**: `taskkill /f /im explorer.exe` followed by a fixed 2-second sleep could leave cache files locked on slower systems. Replaced with a poll loop that waits until `explorer.exe` is fully terminated before deleting cache files.
- **Script-relative log directory (Linux/macOS)**: `LOG_DIR` was set to `./Log Files` (relative to CWD). It is now anchored to the script's own directory via `SCRIPT_DIR`, so logs are always written to the correct location regardless of where the script is called from.
- **curl dependency check added (Linux/macOS)**: Junie and Kiro installs now verify `curl` is available before attempting to pipe a remote script. A clear `[FAILED] curl not found` message is shown if it is missing.

### ⚡ Improvements
- **Junie installer transparency**: Output is no longer suppressed (`>nul 2>&1` removed on Windows). The download URL is logged visibly so users can see exactly what script is being fetched before it runs.
- **Terminal detection for context menu (Linux)**: `create_script_file` now auto-detects the available terminal emulator (`gnome-terminal`, `xfce4-terminal`, `konsole`, `tilix`, `alacritty`, `xterm`) instead of hard-coding `gnome-terminal`. Falls back to `x-terminal-emulator`.
- **Install feedback for Junie/Kiro (Linux/macOS)**: Success and failure are now logged and shown via `${PIPESTATUS[0]}` check.

### 🛠️ Utility / `convert_icons.py`
- **Missing Pillow guard**: An `ImportError` on missing Pillow now prints a helpful `pip install Pillow` hint instead of a raw traceback.
- **Image size validation**: Images larger than 4096 px are skipped with an informative message to prevent memory errors on oversized inputs.
- **Typed exceptions**: `OSError`/`SyntaxError` are caught specifically for file-read failures; a bare `except Exception` handles remaining unexpected errors.
- **Typo fixed**: "converting..." → "Converting..." in the progress output.
- **Better summary**: Output now reports both converted count and failed/skipped count.

### 📚 Version Sync
- Version strings in `AI_CLI_Manager.bat` and `AI_CLI_Manager.sh` updated from `v1.2.13` to `v1.2.17` to match the actual release.

---

## [v1.2.16] - 2026-05-10

### 🚀 New Features
- **OpenCode Model Selector**: Cross-platform launch scripts now include an interactive model selector for OpenCode CLI, allowing users to choose from the latest available models before launching.

---

## [v1.2.15] - 2026-05-04

### 🚀 New Features
- **GPT-5 Nano model support**: Added GPT-5 Nano to the OpenCode model list.
- **Model update automation skill**: Added `update_opencode_models` skill to automate keeping the model list current.

---

## [v1.2.14] - 2026-04-28

### ⚡ Improvements
- **Model selector in shell launcher**: `LaunchOpenCode.sh` now presents an interactive model selection menu before starting OpenCode.
- **Expanded model list**: Updated available models across launcher scripts.

---

## [v1.2.13] - 2026-03-24

### 🚀 New Features
- **CLI Beast Mode (Grid View)**: Introducing a high-octane multitasking interface. Run up to 4 AI agents side-by-side in a single terminal session.
- **Quadrant Presets**: Instant 2x2 layouts for top-tier agents:
    - **Alpha**: Gemini, Copilot, Codex, Qoder
    - **Beta**: KiloCode, Vibe, OpenCode, Qwen
- **Custom Grid Picker**: Fully interactive menu to map any combination of 15+ CLIs to your choice of quadrants (TL, TR, BL, BR).
- **Smart Folder Select**: Multi-directory workflow support. Choose your working folder before launching the grid, with real-time validation and Linux tilde (~) expansion.

### ⚡ Improvements
- **Refined Grid Orchestration**:
    - **Windows**: Chained `wt.exe` subcommands for native Windows Terminal performance.
    - **Unix**: Automated `tmux` session/pane management with background persistence.
- **Code Robustness**: Switched to delayed expansion (`!errorlevel!`) in batch scripts for accurate post-launch status checks.
- **Input Safety**: Quote-wrapped CLI commands to handle special characters and spaces in tool names.

---

## [v1.2.10] - 2026-03-21

### 🚀 New Features
- **Qoder CLI Support**: Full integration for `qodercli` via `@qoder-ai/qodercli` NPM package. Install, update, and launch the Qoder AI coding assistant directly from the manager and context menu.
- **Kiro CLI Support**: Added `kiro-cli` integration. Automates installation via official curl scripts and provides quick-launch access.
- **Dedicated Standalone Launchers**: Added `LaunchQoder.bat/sh` and `LaunchKiro.bat/sh` to the suite of standalone entry points.

### ⚡ Improvements
- **Context Menu Expansion**: Integrated both Qoder and Kiro into the "Open with AI CLI" cascading context menu for Windows Explorer (Registry) and Linux (Nautilus).
- **Core Script Refactoring**: Optimized version detection and installation checks for multiple tool types (NPM, Bash scripts, etc.) for smoother performance.
- **Modern AI Branding**: Added high-quality PNG icons and cache-busted `_v2.ico` files for both new tools to ensure visual clarity.

### 📚 Documentation
- **Unified Sync**: Comprehensive updates across `README.md`, `CODE_DOCUMENTATION.md`, `LINUX_MAC_README.md`, and `DESIGN_PHILOSOPHY.md` to document the 15+ managed AI agents now available.

---

## [v1.2.5] - 2026-03-10

### 🚀 New Features
- **JetBrains Junie CLI Support**: Full integration for `junie`. Install and launch the official JetBrains coding agent directly from the manager using official PowerShell (Windows) and Curl (Unix) scripts.
- **Dedicated Standalone Launchers**: Added `LaunchJunie.bat` and `LaunchJunie.sh` to the suite of standalone entry points.

### ⚡ Improvements
- **Binary-Based Version Checking**: Enhanced the version detection logic to support tools installed via direct official scripts (like Junie), going beyond standard NPM/PIP management.
- **Context Menu Expansion**: Integrated Junie into the "Open with AI CLI" cascading context menu for both Windows Explorer and Linux (Nautilus).
- **Cache-Busted Visuals**: Generated and synced high-quality `junie_v2.ico` for seamless system integration and better cache-busting.

### 📚 Documentation
- **Technical Sync**: Updated `README.md`, `CODE_DOCUMENTATION.md`, and `DESIGN_PHILOSOPHY.md` to document the new script-based installation philosophy and Junie support.

---

## [v1.2.2] - 2026-03-02

### 🚀 New Features
- **Localized Developer Skill (`/add_ai_cli_mgr`)**: Introducing a dedicated, repo-specific AI skill to automate the expansion of the manager. It handles batch/shell launcher creation, menu updates, and context menu registry syncing for any new CLI tool.
- **Repository Visualization**: Added a new architectural infographic in `assets/` to visually represent the tool's "AI Hub" design.
- **GitHub Funding**: Added project sustainability support via `FUNDING.yml`.

### ⚡ Improvements
- **Major README Overhaul**: Completely revamped `README.md` with a modern, structured layout, improved hierarchy, and better navigation.
- **Technical Precision**: Verified and synced all CLI package names (e.g., `nanocode-agent`), installation paths (`/Tools`), and terminal logic across all documentation.
- **Developer Experience**: Enhanced the guide for testing Linux/macOS scripts on Windows via WSL and Git Bash.

### 📚 Documentation
- **Visual Hierarchy**: Improved the documentation structure in `README.md` to prioritize key features and quick-start guides.
- **Sync**: Ensured `Jules CLI` and other technical details are accurately reflected in the supported tools table.

---

## [v1.1.11] - 2026-02-15

### 🚀 New Features
- **Cline CLI Support**: Full integration for `cline`. Install and launch this autonomous coding agent directly from the manager.
- **Dedicated Launchers**: Added `LaunchCline.bat` and `LaunchCline.sh` for standalone execution.

### ⚡ Improvements
- **Context Menu**: Added Cline to the "Open with AI CLI" cascading context menu (Windows & Linux).
- **Unified Versioning**: Synced version strings across all scripts and documentation.

### 📚 Documentation
- **Updated Guides**: Verified Cline is listed in `README.md` and `LINUX_MAC_README.md`.
- **Technical Specs**: Updated `CODE_DOCUMENTATION.md` and `DESIGN_PHILOSOPHY.md` to reflect the new tool addition.

---

## [v1.1.10] - 2026-02-06

### 🚀 New Features
- **OpenAI Codex CLI Support**: Complete integration for local Codex models via `@openai/codex` CLI (Option 11).
- **Dedicated Launcher**: Added `LaunchOpenAICodex.bat` for standardized standalone execution.
- **Shell Files**: Introduced a `/Shell Files` directory containing standalone `.sh` scripts for all supported tools, ensuring Linux/macOS users have parity with the Windows batch ecosystem.
- **Cross-Platform Parity**: Full support added to both Windows (Batch) and Linux/macOS (Bash) scripts.

### 📚 Documentation
- **Updated Guides**: Added Codex to the supported tools list in `README.md` and `LINUX_MAC_README.md`.
- **Integration Specs**: Updated `CODE_DOCUMENTATION.md` to include `@openai/codex` as a core dependency.

### 🏗️ Infrastructure
- Synced context menu generation logic across platforms to include the new Codex option.

---

## [v1.1.8] - 2026-02-06

### 🚀 New Features
- **Claude CLI Support**: Full integration for `@anthropic-ai/claude-code`. Install, update, and launch Anthropic's new agentic coder directly from the manager and context menu.
- **Dedicated Batch File System**: Reorganized the internal structure by moving all standalone launchers to a dedicated `/Batch Files` directory for better project hygiene.
- **Native NanoCode Launcher**: Added a dedicated `LaunchNanoCode.bat` to the batch collection, ensuring every CLI option has a corresponding standalone entry point.

### ⚡ Improvements
- **Standardized Nomenclature**: Renamed all "GitHub Copilot" references to "**GitHub Copilot CLI**" to match current branding and internal package naming.
- **Enhanced Internal Logic**: Optimized the main loop and launch labels for smoother transitions and more robust error handling during terminal handoffs.
- **Context Menu Expansion**: Updated the registry integration to include Claude CLI and the renamed Copilot CLI entries.

### 📚 Documentation
- **Technical Deep-Dive**: Updated `CODE_DOCUMENTATION.md` to reflect the new directory structure and Claude integration logic.
- **Refined README**: Updated the supported tools table and installation guides for v1.1.8.

### 🏗️ Infrastructure & Maintenance
- Renamed internal backup folders to functional `Batch Files` directory.
- Verified all standalone launchers match the main script's core functionality.

## [v1.1.4] - 2026-01-29

### 🚀 New Features
- **NanoCode CLI Support**: Complete integration of NanoCode CLI across Windows, Linux, and macOS. Uses a new "Hybrid Distribution" model allowing Git-cloned tools to be linked globally.
- **Deep Refresh Icons (Clear Cache)**: A powerful new utility (Option E) to force Windows to clear its internal icon cache and reload the latest AI CLI icons.
- **Alphanumeric Navigation**: Redesigned main menu system with clear categorization:
    - `I/V`: CLI Management
    - `1-9`: Launch Launchers
    - `A/B/C`: Context Menu Tools
    - `D/E`: System Utilities

### ⚡ Improvements
- **Registry Backup Engine**: Option C now exports a full registry backup of current shell extensions before making changes, ensuring 100% safety.
- **Smart Installer**: Enhanced detection for Node.js, Python, and now **Git**.
- **Automated Directory Management**: Git-based tools are now neatly organized into a dedicated `/Tools` directory.
- **Session Logging**: Precision timestamps and improved error reporting in session logs.

### 📚 Documentation
- **Technical Architecture Overhaul**: Updated `CODE_DOCUMENTATION.md` with details on the hybrid distribution logic and registry hooks.
- **Design Philosophy**: Documented the "Self-Healing" and "Hybrid Distribution" principles in `DESIGN_PHILOSOPHY.md`.
- **User Guide**: Refreshed `README.md` with the new alphanumeric navigation map.

### 🏗️ Infrastructure & Maintenance
- Updated icon naming convention to `_v2` for better cache-busting.
- Refactored `AI_CLI_Manager.bat` for better readability and modular label handling.

---

## [v1.1.3] - 2026-01-27
### ⚡ UI Transformation
- **Alphanumeric Logic**: Transitioned from a simple list to the new categorized navigation system (`I/V`, `1-9`, `A-E`).
- **Clean Layout**: Optimized vertical spacing and title headers for better readability in high-resolution terminals.

## [v1.1.2] - 2026-01-27
### 🚀 The NanoCode Prototype
- **Hybrid Support**: First implementation of the `git clone` + `npm link` workflow inside the script.
- **Tools Sandbox**: Created the `/Tools` subdirectory to prevent Git-based clones from cluttering the root project directory.
- **Cross-Platform Parity**: Ensured NanoCode could be launched via `AI_CLI_Manager.sh` on Linux as well.

## [v1.1.1] - 2026-01-26
### 🛠️ Icon Infrastructure
- **Cache Busting**: Resolved the "sticky icon" bug by appending `_v2` to all icon names, forcing Windows Registry to recognize updates.
- **Deep Refresh Beta**: Introduced the manual icon cache clearing logic that eventually became the polished Option E in v1.1.4.

## [v1.1.0] - 2026-01-25
### 🏁 Major Release
- Feature: Initial GitHub Copilot CLI support.
- Feature: Custom icon set for the context menu.
- Infrastructure: Added standardized logging and registry backup functionality.
