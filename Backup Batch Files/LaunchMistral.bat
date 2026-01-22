@echo off
setlocal enabledelayedexpansion
title Mistral Vibe CLI
color 0E

:header
cls
echo ============================================================
echo             MISTRAL VIBE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Mistral Vibe CLI
echo  Install : pip install mistral-vibe
echo  Update  : pip install --upgrade mistral-vibe
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Mistral Vibe CLI is installed...
where vibe >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Mistral Vibe CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    pip install mistral-vibe
    echo.
    echo  Make sure you have Python and pip installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Mistral Vibe CLI found!
echo.
echo ============================================================
echo  Starting Mistral Vibe CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c vibe

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0