# AI CLI Manager - Code Functionality

## 🛠️ Technical Overview (v1.0.0)

This document describes the technical implementation of `AI_CLI_Manager.bat`.

## 🧩 Core Functions

### 1. Auto-Elevation (Lines 6-16)
```batch
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process wt/cmd -Verb RunAs"
    exit /b
)
```
- Checks for admin privileges using `net session`
- Auto-elevates using PowerShell `Start-Process -Verb RunAs`
- Prefers Windows Terminal, falls back to CMD

### 2. Logging System (Lines 18-36)
- **Location:** `Log Files` folder in script directory
- **Naming:** `AI_CLI_MG_YYYYMMDD_HHMMSS_mmm.log`
- **Timestamp:** Uses WMIC for consistent format regardless of locale
- **Content:** Session start, user inputs, operations, errors

### 3. Terminal Detection (Lines 38-51)
```batch
set "UseWT=0"
where wt >nul 2>&1
if %errorlevel% equ 0 set "UseWT=1"
```
- Detects if Windows Terminal is available
- Sets `UseWT` flag for use in launch commands
- Falls back to CMD if WT not found

### 4. Package Installation Logic (Lines 282-354)
**Smart Install-Only Approach:**
```batch
call npm list -g @package >nul 2>&1
if errorlevel 1 (
    echo Installing...
    call npm install -g @package
) else (
    echo [ALREADY INSTALLED]
)
```
- Uses `npm list -g` to check if package exists
- Uses `pip show` for Python packages
- Only installs if NOT already present
- Outputs: `[ALREADY INSTALLED]`, `[INSTALLED]`, or `[FAILED]`

### 5. Launch Wrappers (Lines 112-188)
```batch
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    start wt.exe -d "%LAUNCH_DIR%" cmd /k <cli>
) else (
    start cmd /k "cd /d "%LAUNCH_DIR%" && <cli>"
)
```
- Accepts path parameter (`%~1`) from context menu
- Falls back to `%USERPROFILE%` if no path provided
- Uses Windows Terminal if available, CMD otherwise
- Keeps window open with `cmd /k`

### 6. Context Menu Integration (Lines 394-500)
**Registry Structure:**
```
HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu
├── MUIVerb = "Open with AI CLI"
├── Icon = "cmd.exe"
├── SubCommands = ""
└── shell\
    ├── gemini\command = "cmd.exe /c start wt.exe -d \"%V\" cmd /k gemini"
    ├── vibe\command = ...
    └── [other CLIs]
```

**Key Technical Details:**
| Aspect | Implementation |
|--------|---------------|
| **Menu Label** | Uses `MUIVerb` for cascading support |
| **Submenus** | Empty `SubCommands` with nested `shell` structure |
| **Command Format** | `cmd.exe /c start wt.exe -d "%V" cmd /k <cli>` |
| **Dual Registration** | Both `Directory\Background` and `Directory\shell` |

**Command Breakdown:**
```
cmd.exe /c start wt.exe -d "%V" cmd /k gemini
│       │     │        │      │     │
│       │     │        │      │     └── Keep window open
│       │     │        │      └── Run cmd.exe inside WT
│       │     │        └── %V = Current directory path
│       │     └── Windows Terminal
│       └── Spawn new process and exit
└── Command interpreter
```

### 7. Safety Mechanisms

**Registry Backup (`:BACKUP_REGISTRY`):**
- Uses `reg export` to save current state
- Timestamped `.reg` file in `Log Files` folder

**Clean Removal (`:REMOVE_CONTEXT_MENU`):**
- Performs `reg delete` on `AI_CLI_Menu` keys only
- Confirmation required (Y/N)

**Safety Info Display:**
- Explains what registry changes will be made
- Describes safeguards (backup, removal options)
- Recommends creating backup first

### 8. Explorer Restart (Lines 539-560)
```batch
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
```
- Force-kills explorer process
- Waits 2 seconds
- Restarts explorer

## 📋 Dependency Map

| Tool | Type | Package | Command |
|------|------|---------|---------|
| **Gemini** | NPM | `@google/gemini-cli` | `gemini` |
| **Mistral Vibe** | PIP | `mistral-vibe` | `vibe` |
| **iFlow** | NPM | `@iflow-ai/iflow-cli` | `iflow` |
| **OpenCode** | NPM | `opencode-ai` | `opencode` |
| **Qwen Code** | NPM | `@qwen-code/qwen-code` | `qwen` |
| **KiloCode** | NPM | `@kilocode/cli` | `kilocode` |

## 📊 Flow Diagram

```
Start
  │
  ├── Check Admin → No → Elevate → Restart
  │                  │
  │                  ↓
  ├── Setup Logging
  │
  ├── Detect Windows Terminal
  │
  ↓
Main Menu Loop
  │
  ├── Option 1: Install All
  │     └── For each CLI: Check → Install if missing
  │
  ├── Option 2: Show Versions
  │     └── npm list / pip show for each
  │
  ├── Options 3-8: Launch CLI
  │     └── Use %~1 path or USERPROFILE
  │
  ├── Option 9: Add Context Menu
  │     └── Show safety info → Confirm → Add registry keys
  │
  ├── Option 10: Remove Context Menu
  │     └── Confirm → Delete registry keys
  │
  ├── Option 11: Backup Registry
  │     └── reg export to Log Files
  │
  ├── Option 12: Restart Explorer
  │     └── taskkill → start explorer
  │
  └── Option 0: Exit
        └── Log session end → exit /b
```
