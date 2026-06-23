@echo off
setlocal enabledelayedexpansion
title MiMo Code CLI
color 0B

:header
cls
echo ============================================================
echo           MIMO CODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : MiMo Code CLI
echo  Install : npm install -g @mimo-ai/cli@latest
echo  Update  : npm update -g @mimo-ai/cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if MiMo Code CLI is installed...
where mimo >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] MiMo Code CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @mimo-ai/cli@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] MiMo Code CLI found!
echo.
echo ============================================================
echo  Starting MiMo Code CLI...
echo ============================================================
echo.

:run
cmd /c mimo

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
