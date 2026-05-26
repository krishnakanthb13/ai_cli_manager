@echo off
setlocal enabledelayedexpansion
title Kimi Code CLI
color 0B

:header
cls
echo ============================================================
echo            KIMI CODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Kimi Code CLI
echo  Install : pip install kimi-cli
echo  Update  : pip install --upgrade kimi-cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Kimi Code CLI is installed...
where kimi >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Kimi Code CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    pip install kimi-cli
    echo.
    echo  Make sure you have Python and pip installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Kimi Code CLI found!
echo.
echo ============================================================
echo  Starting Kimi Code CLI...
echo ============================================================
echo.

:run
cmd /c kimi

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
