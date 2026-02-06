@echo off
setlocal enabledelayedexpansion
title NanoCode CLI
color 0B

:header
cls
echo ============================================================
echo           NANOCODE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : NanoCode CLI
echo  Install : git clone https://github.com/krishnakanthb13/nanocode-2
echo  Update  : git pull in nanocode-2 folder
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if NanoCode CLI is installed...
where nanocode >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] NanoCode CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, follow the project instructions to link
    echo  the nanocode-2 package.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] NanoCode CLI found!
echo.
echo ============================================================
echo  Starting NanoCode CLI...
echo ============================================================
echo.

:run
cmd /c nanocode

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
