@echo off
setlocal enabledelayedexpansion
title Kiro CLI (Unsupported)
color 0C

:header
cls
echo ============================================================
echo           KIRO CLI LAUNCHER (WINDOWS)
echo ============================================================
echo.
echo  [IMPORTANT] Kiro CLI does not have a native Windows version.
echo.
echo  To use Kiro CLI on Windows, it is recommended to use:
echo    1. Windows Subsystem for Linux (WSL)
echo    2. Git Bash (with curl and bash installed)
echo.
echo  Installation (Unix-based):
echo    curl -fsSL https://cli.kiro.dev/install | bash
echo.
echo ============================================================
echo.
echo Closing in 10 seconds...
timeout /t 10 >nul
exit /b 0
