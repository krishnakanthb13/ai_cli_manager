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
echo           AI CLI TOOLS MANAGER (v1.1.8)
echo ================================================
echo.
echo    --- CLI Management ---
echo     I. Check and Install All CLIs
echo     V. Show Installed CLI Versions
echo.   
echo    --- Launch CLIs ---
echo     1. Launch Gemini CLI
echo     2. Launch Jules CLI
echo     3. Launch Mistral Vibe CLI
echo     4. Launch iFlow CLI
echo     5. Launch OpenCode CLI
echo     6. Launch Qwen Code CLI
echo     7. Launch KiloCode CLI
echo     8. Launch GitHub Copilot CLI
echo     9. Launch NanoCode CLI
echo     10. Launch Claude CLI
echo.   
echo    --- Context Menu ---
echo     A. Add to Windows Context Menu
echo     B. Remove from Windows Context Menu
echo     C. Export Registry Backup
echo.   
echo    --- Utilities ---
echo     D. Restart File Explorer
echo     E. Deep Refresh Icons (Clear Cache)
echo.   
echo     0. Exit
echo.
echo ================================================
set /p "choice=Enter your choice: "

echo [%time%] [INPUT] Choice: %choice% >> "%LOG_FILE%"

if /i "%choice%"=="I" goto INSTALL_ALL
if /i "%choice%"=="V" goto SHOW_VERSIONS
if "%choice%"=="1" goto LAUNCH_GEMINI
if "%choice%"=="2" goto LAUNCH_JULES
if "%choice%"=="3" goto LAUNCH_VIBE
if "%choice%"=="4" goto LAUNCH_IFLOW
if "%choice%"=="5" goto LAUNCH_OPENCODE
if "%choice%"=="6" goto LAUNCH_QWEN
if "%choice%"=="7" goto LAUNCH_KILOCODE
if "%choice%"=="8" goto LAUNCH_COPILOT
if "%choice%"=="9" goto LAUNCH_NANOCODE
if "%choice%"=="10" goto LAUNCH_CLAUDE
if /i "%choice%"=="A" goto ADD_CONTEXT_MENU
if /i "%choice%"=="B" goto REMOVE_CONTEXT_MENU
if /i "%choice%"=="C" goto BACKUP_REGISTRY
if /i "%choice%"=="D" goto RESTART_EXPLORER
if /i "%choice%"=="E" goto DEEP_REFRESH_ICONS
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

:LAUNCH_COPILOT
echo [%time%] === Launching GitHub Copilot CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k copilot >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k copilot
) else (
    echo [%time%] Command: cmd /k copilot (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && copilot"
)
goto EXIT_SCRIPT

:LAUNCH_CLAUDE
echo [%time%] === Launching Claude CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k claude >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k claude
) else (
    echo [%time%] Command: cmd /k claude (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && claude"
)
goto EXIT_SCRIPT

:LAUNCH_NANOCODE
echo [%time%] === Launching NanoCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k nanocode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k nanocode
) else (
    echo [%time%] Command: cmd /k nanocode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && nanocode"
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
echo --- GitHub Copilot CLI ---
echo --- GitHub Copilot CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @github/copilot 2^>nul ^| findstr "@github/copilot"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Claude CLI ---
echo --- Claude CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @anthropic-ai/claude-code 2^>nul ^| findstr "@anthropic-ai/claude-code"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- NanoCode CLI ---
echo --- NanoCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g nanocode-agent 2^>nul ^| findstr "nanocode-agent"') do set "_result=%%V"
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

echo [GitHub Copilot CLI] Checking...
call :CHECK_NPM "@github/copilot" "GitHub Copilot CLI"

echo [Claude CLI] Checking...
call :CHECK_NPM "@anthropic-ai/claude-code" "Claude CLI"

echo [NanoCode CLI] Checking...
call :CHECK_NANOCODE

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
REM Check NanoCode (Custom Git + Link)
REM ========================================
:CHECK_NANOCODE
echo --- NanoCode CLI --- >> "%LOG_FILE%"
set "LVER="

rem Get local version
for /f "tokens=*" %%A in ('npm list -g nanocode-agent --depth=0 2^>nul ^| findstr "nanocode-agent@"') do (
    set "TLINE=%%A"
    for /f "tokens=2 delims=@" %%Y in ("!TLINE!") do (
        set "LVER=%%Y"
    )
    if defined LVER for /f "tokens=1" %%V in ("!LVER!") do set "LVER=%%V"
)

if not defined LVER (
    echo [MISSING] Installing NanoCode via Git...
    where git >nul 2>&1
    if errorlevel 1 (
        echo [FAILED] Git not found! Cannot install NanoCode.
        echo [%time%] [FAILED] NanoCode install (Git missing) >> "%LOG_FILE%"
        exit /b
    )
    
    set "TOOLS_DIR=%SCRIPT_DIR%Tools"
    if not exist "!TOOLS_DIR!" mkdir "!TOOLS_DIR!"
    
    echo Cloning repository...
    cd /d "!TOOLS_DIR!"
    if exist "nanocode-2" (
        echo [INFO] nanocode-2 folder already exists. Skipping clone.
    ) else (
        git clone https://github.com/krishnakanthb13/nanocode-2 nanocode-2 >nul 2>&1
        if errorlevel 1 (
            echo [FAILED] Clone failed.
            echo [%time%] [FAILED] NanoCode git clone failed >> "%LOG_FILE%"
            cd /d "%SCRIPT_DIR%"
            exit /b
        )
    )
    
    echo Linking package...
    cd nanocode-2
    call npm link >nul 2>&1
    if errorlevel 1 (
        echo [FAILED] NPM link failed.
        echo [%time%] [FAILED] NanoCode npm link failed >> "%LOG_FILE%"
    ) else (
        echo [INSTALLED] Git Clone + NPM Link
        echo [%time%] [OK] Installed NanoCode via Link >> "%LOG_FILE%"
    )
    cd /d "%SCRIPT_DIR%"
) else (
    echo [OK] Installed + Linked Version [%LVER%]
    echo [%time%] [SKIP] NanoCode already linked [%LVER%] >> "%LOG_FILE%"
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
echo - Option 13 creates a backup before changes
echo - Option 12 removes all changes cleanly
echo - No system files are modified
echo - Only adds menu items, doesn't change behavior
echo.
echo RECOMMENDATION:
echo 1. Create a backup first (Option C)
echo 2. Create a System Restore Point (Windows Settings)
echo.
echo ================================================
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
set "ICONS_DIR=%~dp0Icons"
echo Adding registry keys...
echo [%time%] Creating root menu keys with MUIVerb... >> "%LOG_FILE%"

REM Directory Background (right-click empty space)
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "MUIVerb" /d "AI CLI Manager" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "Icon" /d "%ICONS_DIR%\darkterminal_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul

REM Directory (right-click folder)
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "MUIVerb" /d "AI CLI Manager" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "Icon" /d "%ICONS_DIR%\darkterminal_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu" /v "SubCommands" /t REG_SZ /f >nul

echo [%time%] Adding submenus with cmd.exe /c start wt.exe format... >> "%LOG_FILE%"

REM Add submenu items for Directory Background
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini" /ve /d "Open with Gemini CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini" /v "Icon" /d "%ICONS_DIR%\gemini_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k gemini" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\jules" /ve /d "Open with Jules CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\jules" /v "Icon" /d "%ICONS_DIR%\jules_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\jules\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k jules" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe" /v "Icon" /d "%ICONS_DIR%\mistral_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow" /ve /d "Open with iFlow CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow" /v "Icon" /d "%ICONS_DIR%\iflow_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k iflow" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode" /v "Icon" /d "%ICONS_DIR%\opencode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen" /ve /d "Open with Qwen Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen" /v "Icon" /d "%ICONS_DIR%\qwen_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k qwen" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode" /v "Icon" /d "%ICONS_DIR%\kilocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k kilocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\copilot" /ve /d "Open with GitHub Copilot CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\copilot" /v "Icon" /d "%ICONS_DIR%\github_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\copilot\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k copilot" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\claude" /ve /d "Open with Claude CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\claude" /v "Icon" /d "%ICONS_DIR%\claude_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\claude\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k claude" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\nanocode" /ve /d "Open with NanoCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\nanocode" /v "Icon" /d "%ICONS_DIR%\nanocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu\shell\nanocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k nanocode" /f >nul

REM Add submenu items for Directory (folder right-click)
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini" /ve /d "Open with Gemini CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini" /v "Icon" /d "%ICONS_DIR%\gemini_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\gemini\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k gemini" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\jules" /ve /d "Open with Jules CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\jules" /v "Icon" /d "%ICONS_DIR%\jules_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\jules\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k jules" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe" /v "Icon" /d "%ICONS_DIR%\mistral_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow" /ve /d "Open with iFlow CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow" /v "Icon" /d "%ICONS_DIR%\iflow_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\iflow\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k iflow" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode" /v "Icon" /d "%ICONS_DIR%\opencode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen" /ve /d "Open with Qwen Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen" /v "Icon" /d "%ICONS_DIR%\qwen_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\qwen\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k qwen" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode" /v "Icon" /d "%ICONS_DIR%\kilocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k kilocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\copilot" /ve /d "Open with GitHub Copilot CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\copilot" /v "Icon" /d "%ICONS_DIR%\github_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\copilot\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k copilot" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\claude" /ve /d "Open with Claude CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\claude" /v "Icon" /d "%ICONS_DIR%\claude_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\claude\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k claude" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\nanocode" /ve /d "Open with NanoCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\nanocode" /v "Icon" /d "%ICONS_DIR%\nanocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu\shell\nanocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k nanocode" /f >nul

echo.
echo [SUCCESS] Context menu updated!
echo [%time%] [SUCCESS] Context menu added >> "%LOG_FILE%"
echo [%time%] Added: Gemini, Jules, Vibe, iFlow, OpenCode, Qwen, KiloCode, Copilot, NanoCode, Claude >> "%LOG_FILE%"
echo.
echo.
echo TIP: Use Option E if the menu icons look old or broken.
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

echo SAFETY INFORMATION:
echo ------------------
echo This operation will completely remove the AI CLI entry
echo from your Windows right-click context menu.
echo.
echo RECOMMENDATION:
echo 1. Ensure you have a registry backup if you want to restore
echo    these settings later (Option C).
echo.

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
echo TIP: Use Option E if the menu icons still persist.
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
goto MAIN_MENU

REM ========================================
REM DEEP REFRESH ICONS
REM ========================================
:DEEP_REFRESH_ICONS
cls
echo.
echo ================================================
echo        Deep Refresh Icons (Clear Cache)
echo ================================================
echo.
echo This will:
echo 1. Close Windows Explorer
echo 2. Delete the Windows icon and thumbnail cache
echo 3. Restart Windows Explorer
echo.
echo Your desktop will briefly disappear.
echo [%time%] === Deep Refresh Started === >> "%LOG_FILE%"
pause

echo Killing Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul

echo Clearing Icon Cache (Legacy)...
attrib -h -s -r "%LocalAppData%\IconCache.db" >nul 2>&1
del /f /q "%LocalAppData%\IconCache.db" >nul 2>&1

echo Clearing Explorer Icon Cache...
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\iconcache*.db" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1

echo Restarting Explorer...
start explorer.exe
echo.
echo [SUCCESS] Icon cache cleared and Explorer restarted!
echo [%time%] [OK] Deep Refresh Completed >> "%LOG_FILE%"
timeout /t 3 >nul
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
