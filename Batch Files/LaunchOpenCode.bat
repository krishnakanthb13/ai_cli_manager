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
echo    [2] Jev 1.13 Free
echo    [3] DeepSeek V4 Flash Free [API]
echo    [4] Muse Spark 1.3 Contributor Free
echo    [5] Muse Spark 1.2 Contributor Free [API]
echo    [6] MiMo-V2.6-Flash Free
echo    [7] Space Bunny Free
echo    [8] LongCat 2.5 Preview Free
echo    [9] MiMo-V2.5 Free
echo    [10] Ling 3.0 Flash Fin Free
echo    [11] Nemotron 3 Ultra Free
echo    [12] Nemotron 3.5 Lightning Free
echo    [13] Fledge Alpha Free
echo    [14] Ling 3.1 Flash Free
echo.
echo    [0] Exit
echo.
echo ============================================================
echo.

set "choice="
set /p choice="  Enter your choice (0-14): "

if "%choice%"=="0" goto exit
if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"
if "%choice%"=="2" set "model=opencode/jev-1.13-free" & set "modelname=Jev 1.13 Free"
if "%choice%"=="3" set "model=opencode/deepseek-v4-flash-free" & set "modelname=DeepSeek V4 Flash Free [API]"
if "%choice%"=="4" set "model=opencode/muse-spark-1.3-contributor-free" & set "modelname=Muse Spark 1.3 Contributor Free"
if "%choice%"=="5" set "model=opencode/muse-spark-1.2-contributor-free" & set "modelname=Muse Spark 1.2 Contributor Free [API]"
if "%choice%"=="6" set "model=opencode/mimo-v2.6-flash-free" & set "modelname=MiMo-V2.6-Flash Free"
if "%choice%"=="7" set "model=opencode/space-bunny-free" & set "modelname=Space Bunny Free"
if "%choice%"=="8" set "model=opencode/longcat-2.5-preview-free" & set "modelname=LongCat 2.5 Preview Free"
if "%choice%"=="9" set "model=opencode/mimo-v2.5-free" & set "modelname=MiMo-V2.5 Free"
if "%choice%"=="10" set "model=opencode/ling-3.0-flash-fin-free" & set "modelname=Ling 3.0 Flash Fin Free"
if "%choice%"=="11" set "model=opencode/nemotron-3-ultra-free" & set "modelname=Nemotron 3 Ultra Free"
if "%choice%"=="12" set "model=opencode/nemotron-3.5-lightning-free" & set "modelname=Nemotron 3.5 Lightning Free"
if "%choice%"=="13" set "model=opencode/fledge-alpha-free" & set "modelname=Fledge Alpha Free"
if "%choice%"=="14" set "model=opencode/ling-3.1-flash-free" & set "modelname=Ling 3.1 Flash Free"

if not defined model (
    echo.
    echo  [!] Invalid choice. Please enter a number between 0-14.
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