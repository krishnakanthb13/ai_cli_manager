@echo off
setlocal enabledelayedexpansion
title Qoder CLI
color 0B

:header
cls
echo ============================================================
echo           QODER CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Qoder CLI
echo  Install : npm install -g @qoder-ai/qodercli@latest
echo  Update  : npm update -g @qoder-ai/qodercli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Qoder CLI is installed...
where qodercli >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Qoder CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @qoder-ai/qodercli@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Qoder CLI found!
echo.
echo ============================================================
echo  Starting Qoder CLI...
echo ============================================================
echo.

:run
cmd /c qodercli

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
