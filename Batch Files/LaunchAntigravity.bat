@echo off
setlocal enabledelayedexpansion
title Antigravity CLI
color 0B

:header
cls
echo ============================================================
echo           Antigravity CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Antigravity CLI
echo  Install : powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm 'https://antigravity.google/cli/install.ps1')"
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Antigravity CLI is installed...
where agy >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Antigravity CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm 'https://antigravity.google/cli/install.ps1')"
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Antigravity CLI found!
echo.
echo ============================================================
echo  Starting Antigravity CLI...
echo ============================================================
echo.

:run
cmd /c agy

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
