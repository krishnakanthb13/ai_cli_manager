@echo off
setlocal enabledelayedexpansion
title Kilo Code CLI
color 0F

:header
cls
echo ============================================================
echo              KILO CODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Kilo Code CLI
echo  Install : npm install -g @kilocode/cli
echo  Update  : npm update -g @kilocode/cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Kilo Code CLI is installed...
where kilocode >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Kilo Code CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @kilocode/cli
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Kilo Code CLI found!
echo.
echo ============================================================
echo  Starting Kilo Code CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c kilocode

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0