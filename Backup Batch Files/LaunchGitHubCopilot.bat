@echo off
setlocal enabledelayedexpansion
title GitHub Copilot CLI
color 09

:header
cls
echo ============================================================
echo             GITHUB COPILOT CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : GitHub Copilot CLI
echo  Install : npm install -g @github/copilot
echo  Update  : npm update -g @github/copilot
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if GitHub Copilot CLI is installed...
where copilot >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] GitHub Copilot CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @github/copilot
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] GitHub Copilot CLI found!
echo.
echo ============================================================
echo  Starting GitHub Copilot CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c copilot

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
