@echo off
setlocal enabledelayedexpansion
title Junie CLI
color 0B

:header
cls
echo ============================================================
echo           JUNIE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Junie CLI (by JetBrains)
echo  Install : powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm 'https://junie.jetbrains.com/install.ps1')"
echo  Update  : (Re-run install command)
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Junie CLI is installed...
where junie >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Junie CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm 'https://junie.jetbrains.com/install.ps1')"
    echo.
    echo  Make sure you have PowerShell 5.1+ installed.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Junie CLI found!
echo.
echo ============================================================
echo  Starting Junie CLI...
echo ============================================================
echo.

:run
cmd /c junie

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
