@echo off
setlocal enabledelayedexpansion
title Freebuff CLI
color 0B

:header
cls
echo ============================================================
echo           FREEBUFF CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Freebuff CLI
echo  Install : npm install -g freebuff@latest
echo  Update  : npm update -g freebuff
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Freebuff CLI is installed...
where freebuff >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Freebuff CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g freebuff@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Freebuff CLI found!
echo.
echo ============================================================
echo  Starting Freebuff CLI...
echo ============================================================
echo.

:run
cmd /c freebuff

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
