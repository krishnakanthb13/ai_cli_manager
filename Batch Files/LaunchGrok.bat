@echo off
setlocal enabledelayedexpansion
title Grok CLI
color 0B

:header
cls
echo ============================================================
echo           GROK CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Grok CLI (xAI)
echo  Install : powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm https://x.ai/cli/install.ps1')"
echo  Update  : grok update
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Grok CLI is installed...
where grok >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Grok CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm https://x.ai/cli/install.ps1')"
    echo.
    echo  Make sure you run PowerShell with internet access.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Grok CLI found!
echo.
echo ============================================================
echo  Starting Grok CLI...
echo ============================================================
echo.

:run
cmd /c grok

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
