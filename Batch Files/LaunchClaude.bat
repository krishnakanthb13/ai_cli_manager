@echo off
setlocal enabledelayedexpansion
title Anthropic Claude CLI
color 0B

:header
cls
echo ============================================================
echo           ANTHROPIC CLAUDE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Claude CLI (Claude Code)
echo  Install : powershell "iex (irm https://claude.ai/install.ps1)"
echo  Update  : claude install
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Claude CLI is installed...
where claude >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Claude CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    powershell "iex (irm https://claude.ai/install.ps1)"
    echo.
    echo  Make sure you run PowerShell with internet access.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Claude CLI found!
echo.
timeout /t 1 >nul

:menu
cls
echo ============================================================
echo           ANTHROPIC CLAUDE CLI - MODEL SELECTOR
echo ============================================================
echo.
echo  Select a model option to run:
echo.
echo  --- OPUS (Complex Reasoning / Planning) ---
echo    [1] Claude Opus 4.8 (Latest - Most Capable)
echo    [2] Claude Opus 4.8 [1M] (1M Token Context Window)
echo    [3] Claude Opus 4.7
echo    [4] Claude Opus 4.7 [1M] (1M Token Context Window)
echo    [5] Claude Opus Plan (Hybrid: Opus plans, Sonnet executes)
echo.
echo  --- SONNET (Latest / Daily Coding) ---
echo    [6] Claude Sonnet 4.6
echo    [7] Claude Sonnet 4.6 [1M] (1M Token Context Window)
echo.
echo  --- HAIKU (Fast ^& Efficient Tasks) ---
echo    [8] Claude Haiku 4.5
echo.
echo  --- OTHER ---
echo    [9] Claude Best (Most Capable - resolves to Opus)
echo    [10] Claude Default (Account Tier Default Model)
echo.
echo    [0] Exit
echo.
echo ============================================================
echo.

set "choice="
set /p choice="  Enter your choice (0-10): "

if "%choice%"=="0" goto exit
if "%choice%"=="1" set "model=claude-opus-4-8" & set "modelname=Claude Opus 4.8"
if "%choice%"=="2" set "model=claude-opus-4-8[1m]" & set "modelname=Claude Opus 4.8 [1M]"
if "%choice%"=="3" set "model=claude-opus-4-7" & set "modelname=Claude Opus 4.7"
if "%choice%"=="4" set "model=claude-opus-4-7[1m]" & set "modelname=Claude Opus 4.7 [1M]"
if "%choice%"=="5" set "model=opusplan" & set "modelname=Claude Opus Plan"
if "%choice%"=="6" set "model=sonnet" & set "modelname=Claude Sonnet 4.6"
if "%choice%"=="7" set "model=sonnet[1m]" & set "modelname=Claude Sonnet 4.6 [1M]"
if "%choice%"=="8" set "model=haiku" & set "modelname=Claude Haiku 4.5"
if "%choice%"=="9" set "model=best" & set "modelname=Claude Best"
if "%choice%"=="10" set "model=default" & set "modelname=Claude Default"

if not defined model (
    echo.
    echo  [!] Invalid choice. Please enter a number between 0-10.
    timeout /t 2 >nul
    goto menu
)

echo.
echo ============================================================
echo  Starting: %modelname%
if not "%model%"=="default" (
    echo  Model Alias: %model%
) else (
    echo  Model Alias: [Default Settings]
)
echo ============================================================
echo.

:run
if "%model%"=="default" (
    cmd /c claude
) else (
    cmd /c claude --model "%model%"
)

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
echo  Exiting Claude CLI... Goodbye!
echo ============================================================
timeout /t 1 >nul
exit /b 0
