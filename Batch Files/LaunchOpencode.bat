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
echo    [2] GPT 5 Nano
echo    [3] GLM 4.7 Free
echo    [4] MiniMax M2.1 Free
echo    [5] Kimi K2.5 Free
echo    [6] Trinity Large Preview Free
echo.
echo    [0] Exit
echo.
echo ============================================================
echo.

set "choice="
set /p choice="  Enter your choice (0-6): "

if "%choice%"=="0" goto exit
if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"
if "%choice%"=="2" set "model=opencode/gpt-5-nano" & set "modelname=GPT 5 Nano"
if "%choice%"=="3" set "model=opencode/glm-4.7-free" & set "modelname=GLM 4.7 Free"
if "%choice%"=="4" set "model=opencode/minimax-m2.1-free" & set "modelname=MiniMax M2.1 Free"
if "%choice%"=="5" set "model=opencode/kimi-k2.5-free" & set "modelname=Kimi K2.5 Free"
if "%choice%"=="6" set "model=opencode/trinity-large-preview-free" & set "modelname=Trinity Large Preview Free"

if not defined model (
    echo.
    echo  [!] Invalid choice. Please enter a number between 0-6.
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