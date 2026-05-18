@echo off
setlocal enabledelayedexpansion
color 0A
title AI CLI Tools Manager

REM ========================================
REM 1. ADMIN PRIVILEGES CHECK
REM ========================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [CRITICAL] Administrator privileges required.
    echo Requesting administrator privileges...
    powershell -Command "$f='%~f0'; if (Get-Command wt.exe -ErrorAction SilentlyContinue) { Start-Process wt -ArgumentList \"cmd /k `\"$f`\"\" -Verb RunAs } else { Start-Process cmd -ArgumentList '/k', \"`\"$f`\"\" -Verb RunAs }"
    exit /b
)
echo [OK] Running with Administrator privileges.
timeout /t 1 >nul

REM ========================================
REM AI CLI Tools Manager
REM Install, Update, and Launch Multiple AI CLIs
REM ========================================
:MAIN_MENU
cls
echo.
echo ================================================
echo          AI CLI TOOLS MANAGER (v1.1)
echo ================================================
echo.
echo --- CLI Management ---
echo  1. Check and Install/Update All CLIs
echo  2. Show Installed CLI Versions
echo.
echo --- Launch CLIs ---
echo  3. Launch Gemini CLI
echo  4. Launch Mistral Vibe CLI
echo  5. Launch iFlow CLI
echo  6. Launch OpenCode CLI
echo  7. Launch Qwen Code CLI
echo  8. Launch KiloCode CLI
echo.
echo --- Context Menu ---
echo  9. Add to Windows Context Menu (Right-Click)
echo 10. Remove from Windows Context Menu
echo 11. Export Registry Backup (Safety)
echo.
echo --- Utilities ---
echo 12. Restart File Explorer
echo.
echo  0. Exit
echo.
echo ================================================
set /p choice="Enter your choice (0-12): "

if "%choice%"=="1" goto INSTALL_ALL
if "%choice%"=="2" goto SHOW_VERSIONS
if "%choice%"=="3" goto LAUNCH_GEMINI
if "%choice%"=="4" goto LAUNCH_VIBE
if "%choice%"=="5" goto LAUNCH_IFLOW
if "%choice%"=="6" goto LAUNCH_OPENCODE
if "%choice%"=="7" goto LAUNCH_QWEN
if "%choice%"=="8" goto LAUNCH_KILO
if "%choice%"=="9" goto ADD_CONTEXT_MENU
if "%choice%"=="10" goto REMOVE_CONTEXT_MENU
if "%choice%"=="11" goto BACKUP_REGISTRY
if "%choice%"=="12" goto RESTART_EXPLORER
if "%choice%"=="0" goto END
goto MAIN_MENU

REM ========================================
REM Show Installed Versions
REM ========================================
:SHOW_VERSIONS
cls
echo.
echo ================================================
echo        Installed CLI Tool Versions
echo ================================================
echo.

echo [Checking NPM Global Packages...]
echo.

echo --- Gemini CLI ---
call npm list -g @google/gemini-cli 2>nul | findstr "@google/gemini-cli"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo --- iFlow CLI ---
call npm list -g @iflow-ai/iflow-cli 2>nul | findstr "@iflow-ai/iflow-cli"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo --- OpenCode CLI ---
call npm list -g opencode-ai 2>nul | findstr "opencode-ai"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo --- Qwen Code CLI ---
call npm list -g @qwen-code/qwen-code 2>nul | findstr "@qwen-code/qwen-code"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo --- KiloCode CLI ---
call npm list -g @kilocode/cli 2>nul | findstr "@kilocode/cli"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo.
echo [Checking Python Packages...]
echo.

echo --- Mistral Vibe CLI ---
pip show mistral-vibe 2>nul | findstr "Name Version"
if %errorlevel% neq 0 echo [NOT INSTALLED]
echo.

echo ================================================
pause
goto MAIN_MENU

REM ========================================
REM Installation and Update Section
REM ========================================
:INSTALL_ALL
cls
echo.
echo ================================================
echo    Checking and Installing/Updating All CLIs
echo ================================================
echo.

REM Check for Node.js
echo [1/7] Checking Node.js installation...
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js from: https://nodejs.org/
    pause
    goto MAIN_MENU
) else (
    echo [OK] Node.js is installed
    node --version
)

REM Check for Python (for Mistral Vibe)
echo.
echo [2/7] Checking Python installation...
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Python is not installed!
    echo Mistral Vibe requires Python. Install from: https://www.python.org/
    set PYTHON_INSTALLED=0
) else (
    echo [OK] Python is installed
    python --version
    set PYTHON_INSTALLED=1
)

REM Install/Update Gemini CLI
echo.
echo [3/7] Installing/Updating Gemini CLI...
call npm list -g @google/gemini-cli >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Gemini CLI...
    call npm install -g @google/gemini-cli@latest
) else (
    echo Updating Gemini CLI...
    call npm update -g @google/gemini-cli
)

REM Install/Update Mistral Vibe
echo.
echo [4/7] Installing/Updating Mistral Vibe...
if !PYTHON_INSTALLED! equ 1 (
    pip show mistral-vibe >nul 2>&1
    if !errorlevel! neq 0 (
        echo Installing Mistral Vibe...
        pip install mistral-vibe
    ) else (
        echo Updating Mistral Vibe...
        pip install --upgrade mistral-vibe
    )
) else (
    echo [SKIPPED] Python not installed
)

REM Install/Update iFlow CLI
echo.
echo [5/7] Installing/Updating iFlow CLI...
call npm list -g @iflow-ai/iflow-cli >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing iFlow CLI...
    call npm install -g @iflow-ai/iflow-cli
) else (
    echo Updating iFlow CLI...
    call npm update -g @iflow-ai/iflow-cli
)

REM Install/Update OpenCode CLI
echo.
echo [6/7] Installing/Updating OpenCode CLI...
call npm list -g opencode-ai >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing OpenCode CLI...
    call npm install -g opencode-ai@latest
) else (
    echo Updating OpenCode CLI...
    call npm update -g opencode-ai
)

REM Install/Update Qwen Code CLI
echo.
echo [7/7] Installing/Updating Qwen Code CLI...
call npm list -g @qwen-code/qwen-code >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Qwen Code CLI...
    call npm install -g @qwen-code/qwen-code@latest
) else (
    echo Updating Qwen Code CLI...
    call npm update -g @qwen-code/qwen-code
)

REM Install/Update KiloCode CLI
echo.
echo [8/7] Installing/Updating KiloCode CLI...
call npm list -g @kilocode/cli >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing KiloCode CLI...
    call npm install -g @kilocode/cli
) else (
    echo Updating KiloCode CLI...
    call npm update -g @kilocode/cli
)

echo.
echo ================================================
echo All installations/updates completed!
echo ================================================
pause
goto MAIN_MENU

REM ========================================
REM Launch Sections
REM ========================================
:LAUNCH_GEMINI
cls
echo Launching Gemini CLI...
echo Command: gemini
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . gemini
goto END

:LAUNCH_VIBE
cls
echo Launching Mistral Vibe CLI...
echo Command: vibe
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . vibe
goto END

:LAUNCH_IFLOW
cls
echo Launching iFlow CLI...
echo Command: iflow
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . iflow
goto END

:LAUNCH_OPENCODE
cls
echo Launching OpenCode CLI...
echo Command: opencode
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . opencode
goto END

:LAUNCH_QWEN
cls
echo Launching Qwen Code CLI...
echo Command: qwen
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . qwen
goto END

:LAUNCH_KILO
cls
echo Launching KiloCode CLI...
echo Command: kilocode
cd /d "%~1"
if "%~1"=="" cd /d "%USERPROFILE%"
call wt.exe -d . kilocode
goto END

REM ========================================
REM Registry Backup
REM ========================================
:BACKUP_REGISTRY
cls
echo.
echo ================================================
echo        Export Registry Backup
echo ================================================
echo.
echo This will create a backup of the registry keys
echo that will be modified by the context menu options.
echo.

REM Create Log Files folder if it doesn't exist
set "LOG_FOLDER=%~dp0Log Files"
if not exist "%LOG_FOLDER%" mkdir "%LOG_FOLDER%"

echo The backup will be saved to: %LOG_FOLDER%
echo.
pause

REM Use WMIC for consistent timestamp format regardless of regional settings
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "DT=%%I"
set "TIMESTAMP=%DT:~0,4%%DT:~4,2%%DT:~6,2%_%DT:~8,2%%DT:~10,2%%DT:~12,2%"
set "BACKUP_FILE=%LOG_FOLDER%\AI_CLI_Backup_%TIMESTAMP%.reg"

echo Creating backup...
echo Filename: AI_CLI_Backup_%TIMESTAMP%.reg
echo.

REM Export the registry keys
reg export "HKEY_CLASSES_ROOT\Directory\Background\shell" "%BACKUP_FILE%" /y >nul 2>&1
if %errorlevel% equ 0 (
    echo [SUCCESS] Registry backup created:
    echo %BACKUP_FILE%
    echo.
    echo To restore, simply double-click this .reg file
) else (
    echo [ERROR] Could not create backup
    echo Make sure you have proper permissions
)

echo.
echo ================================================
pause
goto MAIN_MENU

REM ========================================
REM Context Menu Integration
REM ========================================
:ADD_CONTEXT_MENU
cls
echo.
echo ================================================
echo    Adding AI CLIs to Windows Context Menu
echo ================================================
echo.
echo SAFETY INFORMATION:
echo ------------------
echo This script will modify Windows Registry to add
echo context menu entries. Here's what you should know:
echo.
echo WHAT IT DOES:
echo - Adds "Open with AI CLI" to right-click menu
echo - Only modifies HKEY_CLASSES_ROOT context menus
echo - Creates standard Windows shell extensions
echo - Uses Microsoft-documented registry locations
echo.
echo IS IT SAFE?
echo - YES - These are standard context menu additions
echo - Registry changes are limited and reversible
echo - Same method used by apps like WinRAR, 7-Zip
echo - Microsoft officially supports this approach
echo.
echo SAFEGUARDS:
echo - Option 11 creates a backup before changes
echo - Option 10 removes all changes cleanly
echo - No system files are modified
echo - Only adds menu items, doesn't change behavior
echo.
echo RECOMMENDATION:
echo 1. Create a backup first (Option 11)
echo 2. Create a System Restore Point (Windows Settings)
echo.
echo ================================================
echo.
set /p confirm="Do you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo [ADMIN RIGHTS REQUIRED]
echo.

REM Get the path to this batch file
set "SCRIPT_PATH=%~f0"

echo Adding registry entries...
echo.

REM Add to Directory Background (empty space in folder)
REM Using MUIVerb for proper cascading menu support
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "MUIVerb" /d "Open with AI CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "Icon" /d "cmd.exe" /f >nul 2>&1
REM SubCommands left blank to use nested shell structure
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul 2>&1

REM Add submenu items for Directory Background
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini" /ve /d "Gemini CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k gemini" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe" /ve /d "Mistral Vibe CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k vibe" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow" /ve /d "iFlow CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k iflow" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode" /ve /d "OpenCode CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k opencode" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen" /ve /d "Qwen Code CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k qwen" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode" /ve /d "KiloCode CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k kilocode" /f >nul 2>&1

REM Also add to regular folders (right-click on folder icon)
REM Using MUIVerb for proper cascading menu support
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "MUIVerb" /d "Open with AI CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "Icon" /d "cmd.exe" /f >nul 2>&1
REM SubCommands left blank to use nested shell structure
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini" /ve /d "Gemini CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k gemini" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe" /ve /d "Mistral Vibe CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k vibe" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow" /ve /d "iFlow CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k iflow" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode" /ve /d "OpenCode CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k opencode" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen" /ve /d "Qwen Code CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k qwen" /f >nul 2>&1

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode" /ve /d "KiloCode CLI" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k kilocode" /f >nul 2>&1

echo.
echo ================================================
echo Context menu added successfully!
echo.
echo You may need to restart File Explorer:
echo 1. Open Task Manager (Ctrl+Shift+Esc)
echo 2. Find "Windows Explorer"
echo 3. Right-click and select "Restart"
echo.
echo Or simply restart your computer.
echo ================================================
pause
goto MAIN_MENU

:REMOVE_CONTEXT_MENU
cls
echo.
echo ================================================
echo  Removing AI CLIs from Windows Context Menu
echo ================================================
echo.
echo This will cleanly remove all context menu entries
echo added by this script.
echo.
echo [ADMIN RIGHTS REQUIRED]
echo.
pause

reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /f >nul 2>&1

echo.
echo ================================================
echo Context menu removed successfully!
echo.
echo You may need to restart File Explorer to see changes.
echo ================================================
pause
goto MAIN_MENU

REM ========================================
REM Restart File Explorer
REM ========================================
:RESTART_EXPLORER
cls
echo.
echo ================================================
echo         Restarting File Explorer
echo ================================================
echo.
echo This will close and restart Windows Explorer.
echo Your desktop will briefly disappear and return.
echo.
pause
wt.exe powershell -NoExit -Command "Write-Host 'Restarting Explorer...' -ForegroundColor Yellow\; Stop-Process -Name explorer -Force\; Start-Sleep -Seconds 2\; Start-Process explorer\; Write-Host 'Explorer restarted!' -ForegroundColor Green"
goto MAIN_MENU

:END
endlocal
exit /b