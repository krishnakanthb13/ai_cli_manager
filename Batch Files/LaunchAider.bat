@echo off
setlocal enabledelayedexpansion
title Aider CLI
color 0B

:header
cls
echo ============================================================
echo           Aider CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Aider CLI
echo  Install : pip install aider-chat
echo  Update  : pip install --upgrade aider-chat
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Aider CLI is installed...
where aider >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Aider CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    pip install aider-chat
    echo.
    echo  Make sure you have Python and pip installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Aider CLI found!
echo.
echo ============================================================
echo  Starting Aider CLI...
echo ============================================================
echo.

:run
cmd /c aider

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
