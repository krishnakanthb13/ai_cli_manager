@echo off
setlocal enabledelayedexpansion
title Anthropic Claude CLI
color 0B

:header
cls
echo ============================================================
echo           ANTHROPIC CLAUDE CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Claude CLI (Claude Code)
echo  Install : npm install -g @anthropic-ai/claude-code
echo  Update  : claude install
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Claude CLI is installed...
where claude >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Claude CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    npm install -g @anthropic-ai/claude-code
    echo.
    echo  Make sure you have Node.js and npm installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Claude CLI found!
echo.
echo ============================================================
echo  Starting Claude CLI...
echo ============================================================
echo.

:run
cmd /c claude

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
