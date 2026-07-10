@echo off
setlocal enabledelayedexpansion
title Cursor CLI
color 0B

:header
cls
echo ============================================================
echo           CURSOR CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Cursor CLI
echo  Install : irm 'https://cursor.com/install?win32=true' ^| iex
echo  Update  : Re-run the install command above
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Cursor CLI is installed...
where agent >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Cursor CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run in PowerShell:
    echo    irm 'https://cursor.com/install?win32=true' ^| iex
    echo.
    echo  Make sure you have PowerShell installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Cursor CLI found!
echo.
echo ============================================================
echo  Starting Cursor CLI...
echo ============================================================
echo.

:run
cmd /c agent

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0