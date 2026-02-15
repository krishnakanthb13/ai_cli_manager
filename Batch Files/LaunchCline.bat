@echo off
setlocal enabledelayedexpansion
title Cline CLI
color 0B

:header
cls
echo ============================================================
echo           CLINE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Cline CLI
echo  Install : npm install -g cline
echo  Update  : npm update -g cline
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Cline CLI is installed...
where cline >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Cline CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g cline
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Cline CLI found!
echo.
echo ============================================================
echo  Starting Cline CLI...
echo ============================================================
echo.

:run
cmd /c cline

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
