@echo off
setlocal enabledelayedexpansion
title OpenAI Codex CLI
color 0F

:header
cls
echo ============================================================
echo           OPENAI CODEX CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : OpenAI Codex CLI
echo  Install : npm install -g @openai/codex
echo  Update  : npm update -g @openai/codex
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if OpenAI Codex CLI is installed...
where codex >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] OpenAI Codex CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @openai/codex
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] OpenAI Codex CLI found!
echo.
echo ============================================================
echo  Starting OpenAI Codex CLI...
echo ============================================================
echo.

:run
cmd /c codex

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
