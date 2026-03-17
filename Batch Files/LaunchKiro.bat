@echo off
setlocal enabledelayedexpansion
title Kiro CLI
color 0B

:header
cls
echo ============================================================
echo           KIRO CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Kiro CLI
echo  Install : curl -fsSL https://cli.kiro.dev/install | bash
echo  Update  : curl -fsSL https://cli.kiro.dev/install | bash
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Kiro CLI is installed...
where kiro-cli >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Kiro CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    curl -fsSL https://cli.kiro.dev/install | bash
    echo.
    echo  Note: On Windows, this typically requires Git Bash or WSL.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Kiro CLI found!
echo.
echo ============================================================
echo  Starting Kiro CLI...
echo ============================================================
echo.

:run
cmd /c kiro-cli

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
