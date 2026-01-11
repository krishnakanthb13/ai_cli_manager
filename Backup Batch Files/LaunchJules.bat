@echo off
setlocal enabledelayedexpansion
title Google Jules CLI
color 0B

:header
cls
echo ============================================================
echo           GOOGLE JULES CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Google Jules CLI
echo  Install : npm install -g @google/jules
echo  Update  : npm update -g @google/jules
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Jules CLI is installed...
where jules >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Jules CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @google/jules
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Jules CLI found!
echo.
echo ============================================================
echo  Starting Jules CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c jules

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
