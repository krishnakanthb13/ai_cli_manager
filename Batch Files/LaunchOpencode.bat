@echo off
setlocal enabledelayedexpansion
title OpenCode CLI - Model Selector
color 0A

:header
cls
echo ============================================================
echo              OPENCODE CLI - MODEL SELECTOR
echo ============================================================
echo.
echo  Tool    : OpenCode AI CLI
echo  Install : npm install -g opencode-ai
echo  Update  : npm update -g opencode-ai
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if OpenCode CLI is installed...
where opencode >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] OpenCode CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g opencode-ai
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] OpenCode CLI found!
echo.
timeout /t 1 >nul

:menu
cls
echo ============================================================
echo              OPENCODE CLI - MODEL SELECTOR
echo ============================================================
echo.
echo  Select a model to run:
echo.
echo    [1] Big Pickle
echo    [2] MiniMax M2.5 Free
echo    [3] Qwen3.6 Plus Free
echo    [4] MiMo V2 Pro Free
echo    [5] MiMo V2 Omni Free
echo    [6] MiMo V2 Flash Free
echo    [7] Trinity Large Preview Free
echo    [8] Nemotron 3 Super Free
echo.
echo    [0] Exit
echo.
echo ============================================================
echo.

set "choice="
set /p choice="  Enter your choice (0-8): "

if "%choice%"=="0" goto exit
if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"
if "%choice%"=="2" set "model=opencode/minimax-m2.5-free" & set "modelname=MiniMax M2.5 Free"
if "%choice%"=="3" set "model=opencode/qwen3.6-plus-free" & set "modelname=Qwen3.6 Plus Free"
if "%choice%"=="4" set "model=opencode/mimo-v2-pro-free" & set "modelname=MiMo V2 Pro Free"
if "%choice%"=="5" set "model=opencode/mimo-v2-omni-free" & set "modelname=MiMo V2 Omni Free"
if "%choice%"=="6" set "model=opencode/mimo-v2-flash-free" & set "modelname=MiMo V2 Flash Free"
if "%choice%"=="7" set "model=opencode/trinity-large-preview-free" & set "modelname=Trinity Large Preview Free"
if "%choice%"=="8" set "model=opencode/nemotron-3-super-free" & set "modelname=Nemotron 3 Super Free"

if not defined model (
    echo.
    echo  [!] Invalid choice. Please enter a number between 0-8.
    timeout /t 2 >nul
    goto menu
)

echo.
echo ============================================================
echo  Starting: %modelname%
echo  Model ID: %model%
echo ============================================================
echo.

:run
REM cls
cmd /c opencode --model %model%

echo.
echo ============================================================
echo  Model execution completed!
echo ============================================================
echo.
pause

set "model="
set "modelname="
goto menu

:exit
echo.
echo ============================================================
echo  Exiting OpenCode CLI... Goodbye!
echo ============================================================
timeout /t 1 >nul
exit /b 0