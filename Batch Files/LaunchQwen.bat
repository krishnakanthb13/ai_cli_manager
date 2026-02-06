@echo off
setlocal enabledelayedexpansion
title Qwen Code CLI
color 0D

:header
cls
echo ============================================================
echo              QWEN CODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Qwen Code CLI
echo  Install : npm install -g @qwen-code/qwen-code@latest
echo  Update  : npm update -g @qwen-code/qwen-code
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Qwen CLI is installed...
where qwen >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Qwen CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @qwen-code/qwen-code@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Qwen CLI found!
echo.
echo ============================================================
echo  Starting Qwen CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c qwen

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0