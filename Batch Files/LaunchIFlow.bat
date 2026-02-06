@echo off
setlocal enabledelayedexpansion
title IFlow AI CLI
color 0C

:header
cls
echo ============================================================
echo               IFLOW AI CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : IFlow AI CLI
echo  Install : npm install -g @iflow-ai/iflow-cli
echo  Update  : npm update -g @iflow-ai/iflow-cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if IFlow CLI is installed...
where iflow >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] IFlow CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @iflow-ai/iflow-cli
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] IFlow CLI found!
echo.
echo ============================================================
echo  Starting IFlow CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c iflow

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0