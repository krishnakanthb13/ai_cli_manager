@echo off
setlocal enabledelayedexpansion
color 0A
title AI CLI Tools Manager

REM ========================================
REM 1. ADMIN PRIVILEGES CHECK (BEFORE LOGGING)
REM ========================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [CRITICAL] Administrator privileges required.
    echo Requesting administrator privileges...
    powershell -Command "$f='%~f0'; if (Get-Command wt.exe -ErrorAction SilentlyContinue) { Start-Process wt -ArgumentList \"cmd /k `\"$f`\"\" -Verb RunAs } else { Start-Process cmd -ArgumentList '/k', \"`\"$f`\"\" -Verb RunAs }"
    exit /b
)

REM ========================================
REM 2. LOGGING SETUP
REM ========================================
set "SCRIPT_DIR=%~dp0"
set "LOG_FOLDER=%SCRIPT_DIR%Log Files"
if not exist "%LOG_FOLDER%" mkdir "%LOG_FOLDER%"

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "DT=%%I"
set "TIMESTAMP=%DT:~0,4%%DT:~4,2%%DT:~6,2%_%DT:~8,2%%DT:~10,2%%DT:~12,2%_%DT:~15,3%"
set "LOG_FILE=%LOG_FOLDER%\AI_CLI_MG_%TIMESTAMP%.log"

echo ================================================ > "%LOG_FILE%"
echo AI CLI Tools Manager - Session Log >> "%LOG_FILE%"
echo Started: %date% %time% >> "%LOG_FILE%"
echo ================================================ >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo [%time%] [OK] Running with Administrator privileges. >> "%LOG_FILE%"
echo [OK] Running with Administrator privileges.

REM ========================================
REM 3. TERMINAL DETECTION
REM ========================================
set "UseWT=0"
where wt >nul 2>&1
if %errorlevel% equ 0 (
    set "UseWT=1"
    echo [%time%] [OK] Windows Terminal found. >> "%LOG_FILE%"
    echo [OK] Windows Terminal found.
) else (
    echo [%time%] [INFO] Windows Terminal not found. >> "%LOG_FILE%"
    echo [INFO] Windows Terminal not found.
)
timeout /t 1 >nul

REM ========================================
REM 4. MAIN MENU LOOP
REM ========================================
:MAIN_MENU
cls
echo.
echo ================================================
echo           AI CLI TOOLS MANAGER (v1.0.0)
echo ================================================
echo.
echo    --- CLI Management ---
echo     1. Check and Install All CLIs
echo     2. Show Installed CLI Versions
echo.   
echo    --- Launch CLIs ---
echo     3. Launch Gemini CLI
echo     4. Launch Jules CLI
echo     5. Launch Mistral Vibe CLI
echo     6. Launch iFlow CLI
echo     7. Launch OpenCode CLI
echo     8. Launch Qwen Code CLI
echo     9. Launch KiloCode CLI
echo.   
echo    --- Context Menu ---
echo    10. Add to Windows Context Menu
echo    11. Remove from Windows Context Menu
echo    12. Export Registry Backup
echo.   
echo    --- Utilities ---
echo    13. Restart File Explorer
echo.   
echo     0. Exit
echo.
echo ================================================
set /p "choice=Enter your choice (0-13): "

echo [%time%] [INPUT] Choice: %choice% >> "%LOG_FILE%"

if "%choice%"=="1" goto INSTALL_ALL
if "%choice%"=="2" goto SHOW_VERSIONS
if "%choice%"=="3" goto LAUNCH_GEMINI
if "%choice%"=="4" goto LAUNCH_JULES
if "%choice%"=="5" goto LAUNCH_VIBE
if "%choice%"=="6" goto LAUNCH_IFLOW
if "%choice%"=="7" goto LAUNCH_OPENCODE
if "%choice%"=="8" goto LAUNCH_QWEN
if "%choice%"=="9" goto LAUNCH_KILOCODE
if "%choice%"=="10" goto ADD_CONTEXT_MENU
if "%choice%"=="11" goto REMOVE_CONTEXT_MENU
if "%choice%"=="12" goto BACKUP_REGISTRY
if "%choice%"=="13" goto RESTART_EXPLORER
if "%choice%"=="0" goto EXIT_SCRIPT

echo [%time%] [WARNING] Invalid choice >> "%LOG_FILE%"
echo Invalid choice. Press any key...
pause >nul
goto MAIN_MENU

REM ========================================
REM LAUNCH CLI SECTIONS
REM ========================================
:LAUNCH_GEMINI
echo [%time%] === Launching Gemini CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k gemini >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k gemini
) else (
    echo [%time%] Command: cmd /k gemini (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && gemini"
)
goto EXIT_SCRIPT

:LAUNCH_JULES
echo [%time%] === Launching Jules CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k jules >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k jules
) else (
    echo [%time%] Command: cmd /k jules (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && jules"
)
goto EXIT_SCRIPT

:LAUNCH_VIBE
echo [%time%] === Launching Mistral Vibe === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k vibe >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k vibe
) else (
    echo [%time%] Command: cmd /k vibe (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && vibe"
)
goto EXIT_SCRIPT

:LAUNCH_IFLOW
echo [%time%] === Launching iFlow CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k iflow >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k iflow
) else (
    echo [%time%] Command: cmd /k iflow (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && iflow"
)
goto EXIT_SCRIPT

:LAUNCH_OPENCODE
echo [%time%] === Launching OpenCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k opencode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k opencode
) else (
    echo [%time%] Command: cmd /k opencode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && opencode"
)
goto EXIT_SCRIPT

:LAUNCH_QWEN
echo [%time%] === Launching Qwen Code CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k qwen >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k qwen
) else (
    echo [%time%] Command: cmd /k qwen (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && qwen"
)
goto EXIT_SCRIPT

:LAUNCH_KILOCODE
echo [%time%] === Launching KiloCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k kilocode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k kilocode
) else (
    echo [%time%] Command: cmd /k kilocode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && kilocode"
)
goto EXIT_SCRIPT

REM ========================================
REM SHOW VERSIONS
REM ========================================
:SHOW_VERSIONS
cls
echo.
echo ================================================
echo         Installed CLI Tool Versions
echo ================================================
echo.
echo [%time%] === Checking versions === >> "%LOG_FILE%"

echo --- Gemini CLI ---
echo --- Gemini CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @google/gemini-cli 2^>nul ^| findstr "@google/gemini-cli"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Jules CLI ---
echo --- Jules CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @google/jules 2^>nul ^| findstr "@google/jules"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- iFlow CLI ---
echo --- iFlow CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @iflow-ai/iflow-cli 2^>nul ^| findstr "@iflow-ai/iflow-cli"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- OpenCode CLI ---
echo --- OpenCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g opencode-ai 2^>nul ^| findstr "opencode-ai"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Qwen Code CLI ---
echo --- Qwen Code CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @qwen-code/qwen-code 2^>nul ^| findstr "@qwen-code/qwen-code"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- KiloCode CLI ---
echo --- KiloCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @kilocode/cli 2^>nul ^| findstr "@kilocode/cli"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Mistral Vibe ---
echo --- Mistral Vibe --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('pip show mistral-vibe 2^>nul ^| findstr "Version"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo ================================================
pause
goto MAIN_MENU

REM ========================================
REM INSTALL ALL
REM ========================================
:INSTALL_ALL
cls
echo.
echo ================================================
echo     Installing Checks All CLIs
echo ================================================
echo.
echo [%time%] === Installation Checks started === >> "%LOG_FILE%"

where node >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not found! Install from nodejs.org
    echo [%time%] [ERROR] Node.js missing >> "%LOG_FILE%"
    pause
    goto MAIN_MENU
)
echo [OK] Node.js found.
echo [%time%] [OK] Node.js found >> "%LOG_FILE%"

set "HAS_PYTHON=0"
where python >nul 2>&1
if not errorlevel 1 (
    set "HAS_PYTHON=1"
    echo [OK] Python found.
    echo [%time%] [OK] Python found >> "%LOG_FILE%"
) else (
    echo [WARNING] Python not found. Mistral Vibe will be skipped.
    echo [%time%] [WARNING] Python missing >> "%LOG_FILE%"
)
echo.

echo [Gemini CLI] Checking...
call :CHECK_NPM "@google/gemini-cli" "Gemini CLI"

echo [Jules CLI] Checking...
call :CHECK_NPM "@google/jules" "Jules CLI"

echo [iFlow CLI] Checking...
call :CHECK_NPM "@iflow-ai/iflow-cli" "iFlow CLI"

echo [OpenCode CLI] Checking...
call :CHECK_NPM "opencode-ai" "OpenCode CLI"

echo [Qwen Code] Checking...
call :CHECK_NPM "@qwen-code/qwen-code" "Qwen Code"

echo [KiloCode] Checking...
call :CHECK_NPM "@kilocode/cli" "KiloCode"

if "%HAS_PYTHON%"=="1" (
    echo [Mistral Vibe] Checking...
    call :CHECK_PIP "mistral-vibe" "Mistral Vibe"
)

echo.
echo ================================================
echo All tasks completed!
echo ================================================
echo [%time%] === Installation Checks completed === >> "%LOG_FILE%"
pause
goto MAIN_MENU

REM ========================================
REM Check NPM Packages
REM ========================================
:CHECK_NPM
set "PKG=%~1"
set "DNAME=%~2"
set "LVER="
set "CVER="

echo --- %DNAME% --- >> "%LOG_FILE%"

rem Get local version (handles scoped and non-scoped packages)
for /f "tokens=*" %%A in ('npm list -g %PKG% --depth=0 2^>nul ^| findstr "%PKG%@"') do (
    set "TLINE=%%A"
    set "LVER="
    for /f "tokens=1,2,3 delims=@" %%X in ("!TLINE!") do (
        if "%%Z"=="" (set "LVER=%%Y") else (set "LVER=%%Z")
    )
    rem Strip potential trailing spaces/characters
    if defined LVER for /f "tokens=1" %%V in ("!LVER!") do set "LVER=%%V"
)

rem Get cloud version
for /f "delims=" %%V in ('npm show %PKG% version 2^>nul') do (
    set "CVER=%%V"
)

if not defined CVER set "CVER=unknown"

if not defined LVER (
    echo [MISSING] Installing %DNAME% [%CVER%]...
    call npm install -g %PKG% >nul 2>&1
    if errorlevel 1 (
        echo [FAILED]
        echo [%time%] [FAILED] %PKG% install >> "%LOG_FILE%"
    ) else (
        echo [INSTALLED] Install + Installed
        echo [%time%] [OK] Installed %PKG% v%CVER% >> "%LOG_FILE%"
    )
) else (
    if "!LVER!"=="!CVER!" (
        echo [OK] Installed + Updated Version [%LVER%]
        echo [%time%] [SKIP] %PKG% already updated [%LVER%] >> "%LOG_FILE%"
    ) else (
        echo [OLD] Updating %DNAME% %LVER% -> %CVER%...
        call npm install -g %PKG% >nul 2>&1
        if errorlevel 1 (
            echo [FAILED]
            echo [%time%] [FAILED] %PKG% update >> "%LOG_FILE%"
        ) else (
            echo [UPDATED] Updated [!CVER!]
            echo [%time%] [OK] Updated %PKG% to %CVER% >> "%LOG_FILE%"
        )
    )
)
exit /b

REM ========================================
REM Check PIP Packages
REM ========================================
:CHECK_PIP
set "PKG=%~1"
set "DNAME=%~2"
set "LVER="
set "CVER="

echo --- %DNAME% --- >> "%LOG_FILE%"

rem Get local version
for /f "tokens=2" %%V in ('pip show %PKG% 2^>nul ^| findstr "Version:"') do set "LVER=%%V"

rem Get cloud version
for /f "delims=" %%V in ('powershell -NoProfile -Command "(Invoke-RestMethod https://pypi.org/pypi/%PKG%/json).info.version" 2^>nul') do (
    set "CVER=%%V"
)

if not defined CVER set "CVER=unknown"

if not defined LVER (
    echo [MISSING] Installing %DNAME% [%CVER%]...
    pip install %PKG% >nul 2>&1
    if errorlevel 1 (
        echo [FAILED]
        echo [%time%] [FAILED] %PKG% install >> "%LOG_FILE%"
    ) else (
        echo [INSTALLED] Install + Installed
        echo [%time%] [OK] Installed %PKG% v%CVER% >> "%LOG_FILE%"
    )
) else (
    if "!LVER!"=="!CVER!" (
        echo [OK] Installed + Updated Version [%LVER%]
        echo [%time%] [SKIP] %PKG% already updated [%LVER%] >> "%LOG_FILE%"
    ) else (
        echo [OLD] Updating %DNAME% %LVER% -> %CVER%...
        pip install %PKG% --upgrade >nul 2>&1
        if errorlevel 1 (
            echo [FAILED]
            echo [%time%] [FAILED] %PKG% update >> "%LOG_FILE%"
        ) else (
            echo [UPDATED] Updated [!CVER!]
            echo [%time%] [OK] Updated %PKG% to %CVER% >> "%LOG_FILE%"
        )
    )
)
exit /b

REM ========================================
REM BACKUP REGISTRY
REM ========================================
:BACKUP_REGISTRY
cls
echo.
echo ================================================
echo         Export Registry Backup
echo ================================================
echo.

set "BACKUP_FILE=%LOG_FOLDER%\AI_CLI_Backup_%TIMESTAMP%.reg"
echo Saving to: %BACKUP_FILE%
echo [%time%] Backup to: %BACKUP_FILE% >> "%LOG_FILE%"
echo.

reg export "HKEY_CLASSES_ROOT\Directory\Background\shell" "%BACKUP_FILE%" /y
if %errorlevel% equ 0 (
    echo [SUCCESS] Backup created.
    echo [%time%] [SUCCESS] Backup created >> "%LOG_FILE%"
) else (
    echo [ERROR] Backup failed.
    echo [%time%] [ERROR] Backup failed >> "%LOG_FILE%"
)
pause
goto MAIN_MENU

REM ========================================
REM ADD CONTEXT MENU
REM ========================================
:ADD_CONTEXT_MENU
cls
echo.
echo ================================================
echo     Adding AI CLIs to Context Menu
echo ================================================
echo.
echo [%time%] === Adding context menu === >> "%LOG_FILE%"

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
echo - Option 12 creates a backup before changes
echo - Option 11 removes all changes cleanly
echo - No system files are modified
echo - Only adds menu items, doesn't change behavior
echo.
echo RECOMMENDATION:
echo 1. Create a backup first (Option 12)
echo 2. Create a System Restore Point (Windows Settings)
echo.
echo ================================================
echo.
set /p "confirm=Do you want to continue? (Y/N): "
echo [%time%] User confirm: %confirm% >> "%LOG_FILE%"
if /i not "%confirm%"=="Y" (
    echo [%time%] [CANCELLED] User cancelled >> "%LOG_FILE%"
    goto MAIN_MENU
)

echo.
echo Adding registry keys...
echo [%time%] Creating root menu keys with MUIVerb... >> "%LOG_FILE%"

REM Directory Background (right-click empty space)
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "MUIVerb" /d "AI CLI Manager" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "Icon" /d "shell32.dll,2" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul

REM Directory (right-click folder)
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "MUIVerb" /d "AI CLI Manager" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "Icon" /d "shell32.dll,2" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul

echo [%time%] Adding submenus with cmd.exe /c start wt.exe format... >> "%LOG_FILE%"

REM Add submenu items for Directory Background
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini" /ve /d "Open with Gemini CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k gemini" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\jules" /ve /d "Open with Jules CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\jules\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k jules" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow" /ve /d "Open with iFlow CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k iflow" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen" /ve /d "Open with Qwen Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k qwen" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k kilocode" /f >nul

REM Add submenu items for Directory (folder right-click)
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini" /ve /d "Open with Gemini CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k gemini" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\jules" /ve /d "Open with Jules CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\jules\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k jules" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow" /ve /d "Open with iFlow CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k iflow" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen" /ve /d "Open with Qwen Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k qwen" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k kilocode" /f >nul

echo.
echo [SUCCESS] Context menu updated!
echo [%time%] [SUCCESS] Context menu added >> "%LOG_FILE%"
echo [%time%] Added: Gemini, Jules, Vibe, iFlow, OpenCode, Qwen, KiloCode >> "%LOG_FILE%"
echo.
echo TIP: Use Option 13 to restart Explorer if menu doesn't appear.
pause
goto MAIN_MENU

REM ========================================
REM REMOVE CONTEXT MENU
REM ========================================
:REMOVE_CONTEXT_MENU
cls
echo.
echo ================================================
echo     Remove AI CLI Context Menu
echo ================================================
echo.
echo [%time%] === Removing context menu === >> "%LOG_FILE%"

set /p "confirm=Are you sure? (Y/N): "
echo [%time%] User confirm: %confirm% >> "%LOG_FILE%"
if /i not "%confirm%"=="Y" (
    echo [%time%] [CANCELLED] User cancelled >> "%LOG_FILE%"
    goto MAIN_MENU
)

echo.
echo Removing registry keys...
echo [%time%] Deleting HKCR\Directory\Background\shell\AI_CLI_Menu >> "%LOG_FILE%"
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /f >nul 2>&1
echo [%time%] Deleting HKCR\Directory\shell\AI_CLI_Menu >> "%LOG_FILE%"
reg delete "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /f >nul 2>&1

echo.
echo [SUCCESS] Context menu removed.
echo [%time%] [SUCCESS] Context menu removed >> "%LOG_FILE%"
echo.
echo TIP: Use Option 13 to restart Explorer if menu still appears.
pause
goto MAIN_MENU

REM ========================================
REM RESTART EXPLORER
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
echo [%time%] === Restarting Explorer === >> "%LOG_FILE%"
pause

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo.
echo [SUCCESS] Explorer restarted!
echo [%time%] [OK] Explorer restarted >> "%LOG_FILE%"
timeout /t 2 >nul
goto MAIN_MENU

REM ========================================
REM EXIT
REM ========================================
:EXIT_SCRIPT
echo.
echo [%time%] Session ended >> "%LOG_FILE%"
echo Goodbye!
endlocal
exit /b
