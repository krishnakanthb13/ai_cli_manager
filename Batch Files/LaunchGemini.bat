@echo off
setlocal enabledelayedexpansion
title Google Gemini CLI
color 0B

:header
cls
echo ============================================================
echo           GOOGLE GEMINI CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Google Gemini CLI
echo  Install : npm install -g @google/gemini-cli@latest
echo  Update  : npm update -g @google/gemini-cli
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Gemini CLI is installed...
where gemini >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Gemini CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @google/gemini-cli@latest
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Gemini CLI found!
echo.
echo ============================================================
echo  Starting Gemini CLI...
echo ============================================================
echo.

:run
REM cls
cmd /c gemini

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0