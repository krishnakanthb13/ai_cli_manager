@echo off
setlocal enabledelayedexpansion
color 0A
title AI CLI Beast Mode - Grid Launcher

REM ============================================================
REM  AI CLI Beast Mode - Multi-CLI Grid Launcher (Windows)
REM  Requires: Windows Terminal (wt.exe)
REM  Opens 4 AI CLIs in a 2x2 grid layout.
REM ============================================================

REM ========================================
REM 1. CHECK WINDOWS TERMINAL
REM ========================================
where wt >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Windows Terminal [wt.exe] is required for Beast Mode.
    echo  Please install it from the Microsoft Store or:
    echo  https://github.com/microsoft/terminal/releases
    echo.
    pause
    exit /b 1
)

REM ========================================
REM 2. MAIN MENU LOOP
REM ========================================
:MAIN_MENU
cls
echo.
echo  =====================================================
echo       AI CLI BEAST MODE  ^|  Grid Launcher
echo  =====================================================
echo.
echo   Launch 4 CLIs in a 2x2 Windows Terminal grid.
echo.
echo   --- Presets ---
echo.
echo     1. Preset Alpha   [Gemini ^| Copilot ^| Codex ^| Qoder]
echo     2. Preset Beta    [KiloCode ^| Vibe ^| OpenCode ^| Qwen]
echo.
echo   --- Custom ---
echo.
echo     3. Custom Pick    (Choose any 4 CLIs)
echo.
echo     0. Exit
echo.
echo  =====================================================
set /p "choice=  Enter your choice: "

if "!choice!"=="1" goto PRESET_ALPHA
if "!choice!"=="2" goto PRESET_BETA
if "!choice!"=="3" goto CUSTOM_PICK
if "!choice!"=="0" goto EXIT_SCRIPT
echo.
echo  Invalid choice. Try again.
timeout /t 2 >nul
goto MAIN_MENU

REM ========================================
REM PRESET ALPHA: Gemini / Copilot / Codex / Qoder
REM ========================================
:PRESET_ALPHA
set "CLI_TL=gemini"
set "CLI_TR=copilot"
set "CLI_BL=codex"
set "CLI_BR=qodercli"
goto ASK_FOLDER

REM ========================================
REM PRESET BETA: Kilocode / Mistral / Opencode / Qwen
REM ========================================
:PRESET_BETA
set "CLI_TL=kilocode"
set "CLI_TR=vibe"
set "CLI_BL=opencode"
set "CLI_BR=qwen"
goto ASK_FOLDER

REM ========================================
REM CUSTOM PICK
REM ========================================
:CUSTOM_PICK
cls
echo.
echo  =====================================================
echo       Custom Grid Picker
echo  =====================================================
echo.
echo   Available CLIs:
echo.
echo     1.  gemini        9.  nanocode
echo     2.  jules         10. claude
echo     3.  vibe          11. codex
echo     4.  iflow         12. cline
echo     5.  opencode      13. junie
echo     6.  qwen          14. kiro-cli
echo     7.  kilocode      15. qodercli
echo     8.  copilot
echo.
echo  =====================================================
echo.
echo   Assign a number to each quadrant:
echo   (Layout: [TL^|TR] / [BL^|BR])
echo.

call :PICK_CLI "Top-Left    " CLI_TL
call :PICK_CLI "Top-Right   " CLI_TR
call :PICK_CLI "Bottom-Left " CLI_BL
call :PICK_CLI "Bottom-Right" CLI_BR
goto ASK_FOLDER

REM ========================================
REM Subroutine: prompts user to pick a CLI
REM ========================================
:PICK_CLI
set "_prompt=%~1"
set "_var=%~2"
set "_mapped="
:_PICK_RETRY
set "_num="
set /p "_num=  %_prompt% (1-15): "
if "!_num!"=="" goto _PICK_RETRY
call :MAP_NUM !_num!
if "!_mapped!"=="" (
    echo   [!] Invalid. Enter a number from 1 to 15.
    goto _PICK_RETRY
)
set "!_var!=!_mapped!"
exit /b

REM ========================================
REM Map number to CLI command
REM Sets _mapped variable directly.
REM ========================================
:MAP_NUM
set "_mapped="
if "%~1"=="1"  set "_mapped=gemini"    & exit /b
if "%~1"=="2"  set "_mapped=jules"     & exit /b
if "%~1"=="3"  set "_mapped=vibe"      & exit /b
if "%~1"=="4"  set "_mapped=iflow"     & exit /b
if "%~1"=="5"  set "_mapped=opencode"  & exit /b
if "%~1"=="6"  set "_mapped=qwen"      & exit /b
if "%~1"=="7"  set "_mapped=kilocode"  & exit /b
if "%~1"=="8"  set "_mapped=copilot"   & exit /b
if "%~1"=="9"  set "_mapped=nanocode"  & exit /b
if "%~1"=="10" set "_mapped=claude"    & exit /b
if "%~1"=="11" set "_mapped=codex"     & exit /b
if "%~1"=="12" set "_mapped=cline"     & exit /b
if "%~1"=="13" set "_mapped=junie"     & exit /b
if "%~1"=="14" set "_mapped=kiro-cli"  & exit /b
if "%~1"=="15" set "_mapped=qodercli"  & exit /b
exit /b

REM ========================================
REM ASK FOR WORKING FOLDER
REM ========================================
:ASK_FOLDER
echo.
echo  =====================================================
echo   Select working directory for all CLIs
echo  =====================================================
echo.
echo   Press Enter to use default: %USERPROFILE%
echo.
set "LAUNCH_DIR="
set /p "LAUNCH_DIR=  Folder path: "
if "!LAUNCH_DIR!"=="" set "LAUNCH_DIR=%USERPROFILE%"

REM Remove trailing backslash if present
if "!LAUNCH_DIR:~-1!"=="\" set "LAUNCH_DIR=!LAUNCH_DIR:~0,-1!"

REM Validate folder exists
if not exist "!LAUNCH_DIR!\*" (
    echo.
    echo  [ERROR] Folder not found: !LAUNCH_DIR!
    echo  Please enter a valid folder path.
    timeout /t 2 >nul
    goto ASK_FOLDER
)

echo.
echo  [OK] Using folder: !LAUNCH_DIR!
goto LAUNCH_GRID

REM ========================================
REM LAUNCH THE GRID (2x2)
REM ========================================
:LAUNCH_GRID
echo.
echo  =====================================================
echo       Launching Beast Mode Grid...
echo  =====================================================
echo.
echo   [!CLI_TL!]   ^|   [!CLI_TR!]
echo   --------------------
echo   [!CLI_BL!]   ^|   [!CLI_BR!]
echo.
echo   Directory: !LAUNCH_DIR!
echo.

REM Layout construction (wt.exe returns immediately, no "start" needed):
REM  Step 1: new-tab         -> pane 0 = TL (active)
REM  Step 2: split-pane -V   -> pane 1 = TR (right of TL, active)
REM  Step 3: split-pane -H   -> pane 3 = BR (below TR, active)
REM  Step 4: move-focus left -> focus back to pane 0 = TL
REM  Step 5: split-pane -H   -> pane 2 = BL (below TL, active)

REM NOTE: wt.exe is called directly (NOT via "start"). It spawns a new
REM window and returns immediately. The semicolons (;) are wt subcommand
REM delimiters and are passed through correctly when calling wt directly.

wt.exe new-tab -d "!LAUNCH_DIR!" cmd /k !CLI_TL! ; split-pane -V -d "!LAUNCH_DIR!" cmd /k !CLI_TR! ; split-pane -H -d "!LAUNCH_DIR!" cmd /k !CLI_BR! ; move-focus left ; split-pane -H -d "!LAUNCH_DIR!" cmd /k !CLI_BL!

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Failed to launch Windows Terminal grid.
    echo  Error code: %errorlevel%
    echo.
    pause
    goto MAIN_MENU
)

echo  [OK] Grid launched successfully!
echo.
timeout /t 3 >nul
goto MAIN_MENU

REM ========================================
REM EXIT
REM ========================================
:EXIT_SCRIPT
cls
echo.
echo  Goodbye!
echo.
timeout /t 1 >nul
endlocal
exit /b 0
