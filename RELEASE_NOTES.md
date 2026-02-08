# AI CLI Manager - Release Notes

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
