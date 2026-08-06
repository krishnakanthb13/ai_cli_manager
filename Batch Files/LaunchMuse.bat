@echo off
setlocal enabledelayedexpansion
title Meta Muse Code CLI
color 0B

:header
cls
echo ============================================================
echo           META MUSE CODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Meta Muse Code CLI
echo  Install : curl -fsSL https://dev.meta.ai/install.sh | bash
echo  Update  : muse update
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Meta Muse Code CLI is installed...
where muse >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Meta Muse Code CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    curl -fsSL https://dev.meta.ai/install.sh | bash
    echo.
    echo  Visit https://developer.meta.com/ai/products/muse-code/ for details.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Meta Muse Code CLI found!
echo.
echo ============================================================
echo  Starting Meta Muse Code CLI...
echo ============================================================
echo.

:run
cmd /c muse

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
