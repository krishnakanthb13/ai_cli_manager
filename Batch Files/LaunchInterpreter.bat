@echo off
setlocal enabledelayedexpansion
title Open Interpreter CLI
color 0B

:header
cls
echo ============================================================
echo           Open Interpreter CLI LAUNCHER
echo ============================================================
echo.
echo  Tool    : Open Interpreter CLI
echo  Install : pip install open-interpreter
echo  Update  : pip install --upgrade open-interpreter
echo.
echo ============================================================
echo.

:check_command
echo [*] Checking if Open Interpreter CLI is installed...
where interpreter >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ============================================================
    echo  [ERROR] Open Interpreter CLI is not installed!
    echo ============================================================
    echo.
    echo  To install, run:
    echo    pip install open-interpreter
    echo.
    echo  Make sure you have Python and pip installed first.
    echo.
    echo ============================================================
    echo.
    pause
    exit /b 1
)

echo [OK] Open Interpreter CLI found!
echo.
echo ============================================================
echo  Starting Open Interpreter CLI...
echo ============================================================
echo.

:run
cmd /c interpreter

echo.
echo ============================================================
echo  Session ended. Press any key to exit...
echo ============================================================
pause >nul
exit /b 0
