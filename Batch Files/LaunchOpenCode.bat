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
echo    [2] DeepSeek V4 Flash Free
echo    [3] MiMo-V2.5 Free
echo    [4] Hy3 Free
echo    [5] Laguna S 2.1 Free
echo    [6] Nemotron 3 Ultra Free
echo    [7] Nemotron 3.5 Lightning Free
echo.
echo    [0] Exit
echo.
echo ============================================================
echo.

set "choice="
set /p choice="  Enter your choice (0-7): "

if "%choice%"=="0" goto exit
if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"
if "%choice%"=="2" set "model=opencode/deepseek-v4-flash-free" & set "modelname=DeepSeek V4 Flash Free"
if "%choice%"=="3" set "model=opencode/mimo-v2.5-free" & set "modelname=MiMo-V2.5 Free"
if "%choice%"=="4" set "model=opencode/hy3-free" & set "modelname=Hy3 Free"
if "%choice%"=="5" set "model=opencode/laguna-s-2.1-free" & set "modelname=Laguna S 2.1 Free"
if "%choice%"=="6" set "model=opencode/nemotron-3-ultra-free" & set "modelname=Nemotron 3 Ultra Free"
if "%choice%"=="7" set "model=opencode/nemotron-3.5-lightning-free" & set "modelname=Nemotron 3.5 Lightning Free"

if not defined model (
    echo.
    echo  [!] Invalid choice. Please enter a number between 0-7.
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
cmd /c opencode --model "%model%"

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