@echo off
setlocal enabledelayedexpansion
title CommandCode CLI
color 0B

:header
cls
echo ============================================================
echo           COMMANDCODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : CommandCode CLI
echo  Install : npm install -g command-code@latest
echo  Update  : npm update -g command-code
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if CommandCode CLI is installed...
where commandcode >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] CommandCode CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g command-code@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] CommandCode CLI found!
echo.
echo ============================================================
echo  Starting CommandCode CLI...
echo ============================================================
echo.

:run
cmd /c commandcode

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
