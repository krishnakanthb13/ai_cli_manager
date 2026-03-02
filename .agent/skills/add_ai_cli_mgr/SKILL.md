---
name: add_ai_cli_mgr
description: Localized skill to add a new AI CLI to the manager. Includes launcher creation, menu updates, and icon checks.
---

# Add AI CLI Manager

Use this skill when you need to add a new AI CLI tool (system-wide) to the `ai_cli_manager` project.

## Requirements
*   **CLI Name**: e.g., "DeepSeek"
*   **NPM/PIP Package**: e.g., "@deepseek/cli" or "deepseek-vibe"
*   **Command**: e.g., "deepseek"

## Workflow

### 1. Input Verification
Gather the CLI Name, Command, and Package Name. If any piece of information is missing, attempt to fetch the remaining details from online resources (e.g., npm registry, PyPI, or official documentation). If the information cannot be found automatically, prompt the user for the missing details.

### 2. Create Individual Launchers
*   **Batch Launcher**: Create `Batch Files/Launch[Name].bat` using the standard template below.
*   **Shell Launcher**: Create `Shell Files/Launch[Name].sh` using the standard template below.

### 3. Update AI_CLI_Manager.bat
Automatically update the following sections:
*   **Main Menu**: Add the next index (e.g., 13) and tool name.
*   **Choice Handling**: Add the `if "%choice%"=="X" goto LAUNCH_[NAME]` logic.
*   **Launch Sections**: Add the `:LAUNCH_[NAME]` block (synced with others).
*   **Versions Section**: Add the `npm list` or `pip show` check for the new package.
*   **Installation Section**: Add `call :CHECK_NPM` or `call :CHECK_PIP` for the new package.
*   **Context Menu Section**: Add the `reg add` lines for both Directory Background and Directory.

### 4. Update AI_CLI_Manager.sh
Automatically update the following sections:
*   **Main Menu**: Add the next index and tool name.
*   **Install All**: Add `install_npm_cli` or `install_pip_cli`.
*   **Show Versions**: Add the version check script.
*   **Add Context Menu**: Add the `create_script_file` line.
*   **Choice Case**: Add the corresponding number to the `case` block.

### 5. Icon Check
*   Check if `Icons/[name].png` exists (case-insensitive).
*   If missing, ask the user to provide it.
*   Remind the user that the system uses `[name]_v2.ico` (can be generated via `Icons/convert_icons.py`).

## Templates

### Batch Launcher Template
```batch
@echo off
setlocal enabledelayedexpansion
title [CLI_NAME] CLI
color 0B

:header
cls
echo ============================================================
echo           [CLI_NAME] CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : [CLI_NAME] CLI
echo  Install : npm install -g [PACKAGE]@latest
echo  Update  : npm update -g [PACKAGE]
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if [CLI_NAME] CLI is installed...
where [COMMAND] >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] [CLI_NAME] CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g [PACKAGE]@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] [CLI_NAME] CLI found!
echo.
echo ============================================================
echo  Starting [CLI_NAME] CLI...
echo ============================================================
echo.

:run
cmd /c [COMMAND]

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
```

### Shell Launcher Template
```bash
#!/bin/bash
# AI CLI Manager - Launch [CLI_NAME] CLI

CMD="[COMMAND]"
PKG="[PACKAGE]"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  npm install -g $PKG"
    echo "  (You might need sudo)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."
```
