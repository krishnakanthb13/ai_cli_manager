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
echo  Install : curl.exe -fsSL https://cli.kiro.dev/install.ps1 -o "%TEMP%\kiro_install.ps1" && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\kiro_install.ps1"
echo  Update  : (Re-run install command)
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
    echo  To install, run this in Command Prompt or PowerShell:
    echo    curl.exe -fsSL https://cli.kiro.dev/install.ps1 -o "%TEMP%\kiro_install.ps1" && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\kiro_install.ps1"
    echo.
    echo  This handles SSL/TLS secure channel creation automatically.
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
