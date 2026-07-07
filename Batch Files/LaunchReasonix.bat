@echo off
setlocal enabledelayedexpansion
title Reasonix CLI
color 0B

:header
cls
echo ============================================================
echo           REASONIX CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Reasonix CLI
echo  Install : npm install -g reasonix@next
echo  Update  : npm update -g reasonix@next
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Reasonix CLI is installed...
where reasonix >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Reasonix CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g reasonix@next
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Reasonix CLI found!
echo.
echo ============================================================
echo  Starting Reasonix CLI...
echo ============================================================
echo.

:run
cmd /c reasonix

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
