@echo off
setlocal enabledelayedexpansion
title Pi CLI
color 0B

:header
cls
echo ============================================================
echo           PI CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Pi CLI
echo  Install : npm install -g @earendil-works/pi-coding-agent@latest
echo  Update  : npm update -g @earendil-works/pi-coding-agent
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Pi CLI is installed...
where pi >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Pi CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @earendil-works/pi-coding-agent
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Pi CLI found!
echo.
echo ============================================================
echo  Starting Pi CLI...
echo ============================================================
echo.

:run
cmd /c pi

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
