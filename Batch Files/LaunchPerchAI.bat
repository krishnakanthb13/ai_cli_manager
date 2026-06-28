@echo off
setlocal enabledelayedexpansion
title Perch AI CLI
color 0B

:header
cls
echo ============================================================
echo           PERCH AI CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Perch AI CLI
echo  Install : npm install -g perchai-cli@latest
echo  Update  : npm update -g perchai-cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Perch AI CLI is installed...
where perch >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Perch AI CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g perchai-cli@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Perch AI CLI found!
echo.
echo ============================================================
echo  Starting Perch AI CLI...
echo ============================================================
echo.

:run
cmd /c perch

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
