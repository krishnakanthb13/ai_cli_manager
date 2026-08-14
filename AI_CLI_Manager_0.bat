@echo off
setlocal enabledelayedexpansion
color 0A
title AI CLI Tools Manager (Focus)

REM ========================================
REM 1. ADMIN PRIVILEGES CHECK (BEFORE LOGGING)
REM ========================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [CRITICAL] Administrator privileges required.
    echo Requesting administrator privileges...
    powershell -Command "$f='%~f0'; if (Get-Command wt.exe -ErrorAction SilentlyContinue) { Start-Process wt -ArgumentList \"cmd /c `\"$f`\"\" -Verb RunAs } else { Start-Process cmd -ArgumentList '/c', \"`\"$f`\"\" -Verb RunAs }"
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
set "LOG_FILE=%LOG_FOLDER%\AI_CLI_MG_Focus_%TIMESTAMP%.log"

echo ================================================ > "%LOG_FILE%"
echo AI CLI Tools Manager (Focus) - Session Log >> "%LOG_FILE%"
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
echo        AI CLI TOOLS MANAGER - FOCUS (v1.0)
echo ================================================
echo.
echo    --- CLI Management ---
echo     I. Check and Install Focus CLIs
echo     V. Show Installed CLI Versions
echo.   
echo    --- Launch Focus CLIs ---
echo     1. Launch Antigravity CLI
echo     2. Launch Claude CLI
echo     3. Launch CommandCode CLI
echo     4. Launch Freebuff CLI
echo     5. Launch GitHub Copilot CLI
echo     6. Launch KiloCode CLI
echo     7. Launch MiMo Code CLI
echo     8. Launch Mistral Vibe CLI
echo     9. Launch NanoCode CLI
echo     10. Launch OpenAI Codex CLI
echo     11. Launch OpenCode CLI
echo     12. Launch Perch AI CLI
echo.
echo    --- Context Menu ---
echo     A. Add to Windows Context Menu [Focus]
echo     B. Remove from Windows Context Menu [Focus]
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
if "%choice%"=="1" goto LAUNCH_ANTIGRAVITY
if "%choice%"=="2" goto LAUNCH_CLAUDE
if "%choice%"=="3" goto LAUNCH_COMMANDCODE
if "%choice%"=="4" goto LAUNCH_FREEBUFF
if "%choice%"=="5" goto LAUNCH_COPILOT
if "%choice%"=="6" goto LAUNCH_KILOCODE
if "%choice%"=="7" goto LAUNCH_MIMO
if "%choice%"=="8" goto LAUNCH_VIBE
if "%choice%"=="9" goto LAUNCH_NANOCODE
if "%choice%"=="10" goto LAUNCH_OPENAI
if "%choice%"=="11" goto LAUNCH_OPENCODE
if "%choice%"=="12" goto LAUNCH_PERCHAI
if /i "%choice%"=="A" goto ADD_CONTEXT_MENU
if /i "%choice%"=="B" goto REMOVE_CONTEXT_MENU
if /i "%choice%"=="C" goto BACKUP_REGISTRY
if /i "%choice%"=="D" goto RESTART_EXPLORER
if /i "%choice%"=="E" goto DEEP_REFRESH_ICONS
if "%choice%"=="0" goto EXIT_SCRIPT
if /i "%choice%"=="exit" goto EXIT_SCRIPT
if /i "%choice%"=="quit" goto EXIT_SCRIPT
if /i "%choice%"=="q" goto EXIT_SCRIPT

echo [%time%] [WARNING] Invalid choice >> "%LOG_FILE%"
echo Invalid choice. Press any key...
pause >nul
goto MAIN_MENU

REM ========================================
REM LAUNCH CLI SECTIONS
REM ========================================
:LAUNCH_ANTIGRAVITY
echo [%time%] === Launching Antigravity CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC agy
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k agy >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k agy
) else (
    echo [%time%] Command: cmd /k agy (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && agy"
)
goto LAUNCH_DONE

:LAUNCH_CLAUDE
echo [%time%] === Launching Claude CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC claude
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k claude >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k claude
) else (
    echo [%time%] Command: cmd /k claude (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && claude"
)
goto LAUNCH_DONE

:LAUNCH_COMMANDCODE
echo [%time%] === Launching CommandCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC commandcode
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k commandcode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k commandcode
) else (
    echo [%time%] Command: cmd /k commandcode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && commandcode"
)
goto LAUNCH_DONE

:LAUNCH_FREEBUFF
echo [%time%] === Launching Freebuff CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC freebuff
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k freebuff >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k freebuff
) else (
    echo [%time%] Command: cmd /k freebuff (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && freebuff"
)
goto LAUNCH_DONE

:LAUNCH_COPILOT
echo [%time%] === Launching GitHub Copilot CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC copilot
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k copilot >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k copilot
) else (
    echo [%time%] Command: cmd /k copilot (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && copilot"
)
goto LAUNCH_DONE

:LAUNCH_KILOCODE
echo [%time%] === Launching KiloCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC kilocode
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k kilocode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k kilocode
) else (
    echo [%time%] Command: cmd /k kilocode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && kilocode"
)
goto LAUNCH_DONE

:LAUNCH_MIMO
echo [%time%] === Launching MiMo Code CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC mimo
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k mimo >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k mimo
) else (
    echo [%time%] Command: cmd /k mimo (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && mimo"
)
goto LAUNCH_DONE

:LAUNCH_VIBE
echo [%time%] === Launching Mistral Vibe === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC vibe
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k vibe >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k vibe
) else (
    echo [%time%] Command: cmd /k vibe (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && vibe"
)
goto LAUNCH_DONE

:LAUNCH_NANOCODE
echo [%time%] === Launching NanoCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC nanocode
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k nanocode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k nanocode
) else (
    echo [%time%] Command: cmd /k nanocode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && nanocode"
)
goto LAUNCH_DONE

:LAUNCH_OPENAI
echo [%time%] === Launching OpenAI Codex CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC codex
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k codex >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k codex
) else (
    echo [%time%] Command: cmd /k codex (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && codex"
)
goto LAUNCH_DONE

:LAUNCH_OPENCODE
echo [%time%] === Launching OpenCode CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC opencode
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k opencode >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k opencode
) else (
    echo [%time%] Command: cmd /k opencode (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && opencode"
)
goto LAUNCH_DONE

:LAUNCH_PERCHAI
echo [%time%] === Launching Perch AI CLI === >> "%LOG_FILE%"
set "LAUNCH_DIR=%~1"
if "%LAUNCH_DIR%"=="" set "LAUNCH_DIR=%USERPROFILE%"
call :CHECK_CLI_EXEC perch
if errorlevel 1 goto MAIN_MENU
if "%UseWT%"=="1" (
    echo [%time%] Command: wt.exe -d "%LAUNCH_DIR%" cmd /k perch >> "%LOG_FILE%"
    start wt.exe -d "%LAUNCH_DIR%" cmd /k perch
) else (
    echo [%time%] Command: cmd /k perch (in %LAUNCH_DIR%) >> "%LOG_FILE%"
    start cmd /k "cd /d "%LAUNCH_DIR%" && perch"
)
goto LAUNCH_DONE

REM ========================================
REM SHOW VERSIONS
REM ========================================
:SHOW_VERSIONS
cls
echo.
echo ================================================
echo         Installed Focus CLI Versions
echo ================================================
echo.
echo [%time%] === Checking focus versions === >> "%LOG_FILE%"

echo --- Antigravity CLI ---
echo --- Antigravity CLI --- >> "%LOG_FILE%"
set "_result="
where agy >nul 2>&1
if %errorlevel% equ 0 (
    for /f "delims=" %%V in ('agy --version 2^>nul') do set "_result=%%V"
    if not defined _result set "_result=[INSTALLED]"
)
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Claude CLI ---
echo --- Claude CLI --- >> "%LOG_FILE%"
set "_result="
where claude >nul 2>&1
if %errorlevel% equ 0 (set "_result=[INSTALLED]") else (set "_result=")
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- CommandCode CLI ---
echo --- CommandCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g command-code --depth=0 2^>nul ^| findstr /C:"-- command-code@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Freebuff CLI ---
echo --- Freebuff CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g freebuff --depth=0 2^>nul ^| findstr /C:"-- freebuff@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- GitHub Copilot CLI ---
echo --- GitHub Copilot CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @github/copilot --depth=0 2^>nul ^| findstr /C:"-- @github/copilot@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- KiloCode CLI ---
echo --- KiloCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @kilocode/cli --depth=0 2^>nul ^| findstr /C:"-- @kilocode/cli@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- MiMo Code CLI ---
echo --- MiMo Code CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @mimo-ai/cli --depth=0 2^>nul ^| findstr /C:"-- @mimo-ai/cli@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Mistral Vibe ---
echo --- Mistral Vibe --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('pip show mistral-vibe 2^>nul ^| findstr /B /C:"Version:"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- NanoCode CLI ---
echo --- NanoCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g nanocode-agent --depth=0 2^>nul ^| findstr /C:"-- nanocode-agent@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- OpenAI Codex CLI ---
echo --- OpenAI Codex CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g @openai/codex --depth=0 2^>nul ^| findstr /C:"-- @openai/codex@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- OpenCode CLI ---
echo --- OpenCode CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g opencode-ai --depth=0 2^>nul ^| findstr /C:"-- opencode-ai@"') do set "_result=%%V"
if defined _result (echo %_result% & echo [%time%] %_result% >> "%LOG_FILE%") else (echo [NOT INSTALLED] & echo [%time%] [NOT INSTALLED] >> "%LOG_FILE%")

echo.
echo --- Perch AI CLI ---
echo --- Perch AI CLI --- >> "%LOG_FILE%"
set "_result="
for /f "delims=" %%V in ('npm list -g perchai-cli --depth=0 2^>nul ^| findstr /C:"-- perchai-cli@"') do set "_result=%%V"
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
echo      Installing Checks Focus CLIs
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

echo [Antigravity CLI] Checking...
call :CHECK_ANTIGRAVITY

echo [Claude CLI] Checking...
call :CHECK_CLAUDE

echo [CommandCode CLI] Checking...
call :CHECK_NPM "command-code" "CommandCode CLI"

echo [Freebuff CLI] Checking...
call :CHECK_NPM "freebuff" "Freebuff CLI"

echo [GitHub Copilot CLI] Checking...
call :CHECK_NPM "@github/copilot" "GitHub Copilot CLI"

echo [KiloCode] Checking...
call :CHECK_NPM "@kilocode/cli" "KiloCode"

echo [MiMo Code CLI] Checking...
call :CHECK_NPM "@mimo-ai/cli" "MiMo Code CLI"

echo [NanoCode CLI] Checking...
call :CHECK_NANOCODE

echo [OpenAI Codex CLI] Checking...
call :CHECK_NPM "@openai/codex" "OpenAI Codex CLI"

echo [OpenCode CLI] Checking...
call :CHECK_NPM "opencode-ai" "OpenCode CLI"

echo [Perch AI CLI] Checking...
call :CHECK_NPM "perchai-cli" "Perch AI CLI"

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

for /f "tokens=*" %%A in ('npm list -g %PKG% --depth=0 2^>nul ^| findstr /C:"-- %PKG%@"') do (
    set "TLINE=%%A"
    set "LVER="
    for /f "tokens=1,2,3 delims=@" %%X in ("!TLINE!") do (
        if "%%Z"=="" (set "LVER=%%Y") else (set "LVER=%%Z")
    )
    if defined LVER for /f "tokens=1" %%V in ("!LVER!") do set "LVER=%%V"
)

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

for /f "tokens=2" %%V in ('pip show %PKG% 2^>nul ^| findstr "Version:"') do set "LVER=%%V"

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

for /f "tokens=*" %%A in ('npm list -g nanocode-agent --depth=0 2^>nul ^| findstr /C:"-- nanocode-agent@"') do (
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
REM Check Antigravity CLI (Official Script)
REM ========================================
:CHECK_ANTIGRAVITY
echo --- Antigravity CLI --- >> "%LOG_FILE%"
where agy >nul 2>&1
if %errorlevel% neq 0 (
    echo [MISSING] Installing Antigravity CLI...
    echo [INFO] Downloading official installer from: https://antigravity.google/cli/install.ps1
    echo [INFO] This runs Google's official installation script.
    echo [%time%] [INFO] Running Antigravity official installer >> "%LOG_FILE%"
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm 'https://antigravity.google/cli/install.ps1')"
    if errorlevel 1 (
        echo [INFO] Connection failed. Retrying download with curl.exe...
        curl.exe -fsSL "https://antigravity.google/cli/install.ps1" -o "%TEMP%\agy_install.ps1"
        if not errorlevel 1 (
            powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\agy_install.ps1"
            del "%TEMP%\agy_install.ps1" >nul 2>&1
            echo [INSTALLED] Official Script
            echo [%time%] [OK] Installed Antigravity CLI >> "%LOG_FILE%"
        ) else (
            echo [FAILED]
            echo [%time%] [FAILED] Antigravity install >> "%LOG_FILE%"
        )
    ) else (
        echo [INSTALLED] Official Script
        echo [%time%] [OK] Installed Antigravity CLI >> "%LOG_FILE%"
    )
) else (
    echo [OK] Installed
    echo [%time%] [SKIP] Antigravity already installed >> "%LOG_FILE%"
)
exit /b

REM ========================================
REM Check Claude CLI (Official Script)
REM ========================================
:CHECK_CLAUDE
echo --- Claude CLI --- >> "%LOG_FILE%"
where claude >nul 2>&1
if %errorlevel% neq 0 (
    echo [MISSING] Installing Claude CLI...
    echo [INFO] Downloading official installer from: https://claude.ai/install.ps1
    echo [INFO] This runs Anthropic's official installation script.
    echo [%time%] [INFO] Running Claude official installer >> "%LOG_FILE%"
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm 'https://claude.ai/install.ps1')"
    if errorlevel 1 (
        echo [INFO] Connection failed. Retrying download with curl.exe...
        curl.exe -fsSL "https://claude.ai/install.ps1" -o "%TEMP%\claude_install.ps1"
        if not errorlevel 1 (
            powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\claude_install.ps1"
            del "%TEMP%\claude_install.ps1" >nul 2>&1
            echo [INSTALLED] Official Script
            echo [%time%] [OK] Installed Claude CLI >> "%LOG_FILE%"
        ) else (
            echo [FAILED]
            echo [%time%] [FAILED] Claude install >> "%LOG_FILE%"
        )
    ) else (
        echo [INSTALLED] Official Script
        echo [%time%] [OK] Installed Claude CLI >> "%LOG_FILE%"
    )
) else (
    echo [OK] Installed
    echo [%time%] [SKIP] Claude already installed >> "%LOG_FILE%"
)
exit /b

REM ========================================
REM Subroutine: Check if a CLI command exists in PATH
REM Usage: call :CHECK_CLI_EXEC <command>
REM Returns: exit code 1 if not found, 0 if found
REM ========================================
:CHECK_CLI_EXEC
where %~1 >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] '%~1' not found in PATH.
    echo Run option 'I' to install all Focus CLIs first.
    echo [%time%] [ERROR] CLI not found: %~1 >> "%LOG_FILE%"
    echo.
    pause
    exit /b 1
)
exit /b 0

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

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "DT_BK=%%I"
set "BK_STAMP=%DT_BK:~0,4%%DT_BK:~4,2%%DT_BK:~6,2%_%DT_BK:~8,2%%DT_BK:~10,2%%DT_BK:~12,2%"
set "BACKUP_FILE=%LOG_FOLDER%\AI_CLI_Backup_%BK_STAMP%.reg"
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
REM ADD CONTEXT MENU (FOCUS)
REM ========================================
:ADD_CONTEXT_MENU
cls
echo.
echo ================================================
echo  Adding AI CLI Manager (Focus) to Context Menu
echo ================================================
echo.
echo [%time%] === Adding focus context menu === >> "%LOG_FILE%"

echo SAFETY INFORMATION:
echo ------------------
echo This script will modify Windows Registry to add
echo the "AI CLI Manager (Focus)" context menu entries.
echo.
echo SAFEGUARDS:
echo - Option C creates a backup before changes
echo - Option B removes changes cleanly
echo - No system files are modified
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
echo [%time%] Creating root menu keys for AI_CLI_Menu_Focus... >> "%LOG_FILE%"

REM Directory Background (right-click empty space)
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus" /v "MUIVerb" /d "AI CLI Manager (Focus)" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus" /v "Icon" /d "%ICONS_DIR%\darkterminal_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus" /v "SubCommands" /t REG_SZ /f >nul

REM Directory (right-click folder)
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus" /v "MUIVerb" /d "AI CLI Manager (Focus)" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus" /v "Icon" /d "%ICONS_DIR%\darkterminal_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus" /v "SubCommands" /t REG_SZ /f >nul

echo [%time%] Adding focus submenus... >> "%LOG_FILE%"

REM ----------------------------------------
REM Directory Background submenu items
REM ----------------------------------------
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\antigravity" /ve /d "Open with Antigravity CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\antigravity" /v "Icon" /d "%ICONS_DIR%\antigravity_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\antigravity\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k agy" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\claude" /ve /d "Open with Claude CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\claude" /v "Icon" /d "%ICONS_DIR%\claude_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\claude\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k claude" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\commandcode" /ve /d "Open with CommandCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\commandcode" /v "Icon" /d "%ICONS_DIR%\commandcode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\commandcode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k commandcode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\freebuff" /ve /d "Open with Freebuff CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\freebuff" /v "Icon" /d "%ICONS_DIR%\freebuff_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\freebuff\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k freebuff" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\copilot" /ve /d "Open with GitHub Copilot CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\copilot" /v "Icon" /d "%ICONS_DIR%\github_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\copilot\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k copilot" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\kilocode" /v "Icon" /d "%ICONS_DIR%\kilocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k kilocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\mimo" /ve /d "Open with MiMo Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\mimo" /v "Icon" /d "%ICONS_DIR%\mimo_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\mimo\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k mimo" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\vibe" /v "Icon" /d "%ICONS_DIR%\mistral_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\nanocode" /ve /d "Open with NanoCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\nanocode" /v "Icon" /d "%ICONS_DIR%\nanocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\nanocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k nanocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\openai" /ve /d "Open with OpenAI Codex CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\openai" /v "Icon" /d "%ICONS_DIR%\codex_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\openai\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k codex" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\opencode" /v "Icon" /d "%ICONS_DIR%\opencode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\perchai" /ve /d "Open with Perch AI CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\perchai" /v "Icon" /d "%ICONS_DIR%\perch_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus\shell\perchai\command" /ve /d "cmd.exe /c start wt.exe -d \"%%V\" cmd /k perch" /f >nul

REM ----------------------------------------
REM Directory (Folder) submenu items
REM ----------------------------------------
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\antigravity" /ve /d "Open with Antigravity CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\antigravity" /v "Icon" /d "%ICONS_DIR%\antigravity_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\antigravity\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k agy" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\claude" /ve /d "Open with Claude CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\claude" /v "Icon" /d "%ICONS_DIR%\claude_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\claude\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k claude" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\commandcode" /ve /d "Open with CommandCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\commandcode" /v "Icon" /d "%ICONS_DIR%\commandcode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\commandcode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k commandcode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\freebuff" /ve /d "Open with Freebuff CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\freebuff" /v "Icon" /d "%ICONS_DIR%\freebuff_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\freebuff\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k freebuff" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\copilot" /ve /d "Open with GitHub Copilot CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\copilot" /v "Icon" /d "%ICONS_DIR%\github_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\copilot\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k copilot" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\kilocode" /ve /d "Open with KiloCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\kilocode" /v "Icon" /d "%ICONS_DIR%\kilocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\kilocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k kilocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\mimo" /ve /d "Open with MiMo Code CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\mimo" /v "Icon" /d "%ICONS_DIR%\mimo_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\mimo\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k mimo" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\vibe" /ve /d "Open with Mistral Vibe CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\vibe" /v "Icon" /d "%ICONS_DIR%\mistral_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\vibe\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k vibe" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\nanocode" /ve /d "Open with NanoCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\nanocode" /v "Icon" /d "%ICONS_DIR%\nanocode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\nanocode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k nanocode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\openai" /ve /d "Open with OpenAI Codex CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\openai" /v "Icon" /d "%ICONS_DIR%\codex_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\openai\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k codex" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\opencode" /ve /d "Open with OpenCode CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\opencode" /v "Icon" /d "%ICONS_DIR%\opencode_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\opencode\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k opencode" /f >nul

reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\perchai" /ve /d "Open with Perch AI CLI" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\perchai" /v "Icon" /d "%ICONS_DIR%\perch_v2.ico" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus\shell\perchai\command" /ve /d "cmd.exe /c start wt.exe -d \"%%1\" cmd /k perch" /f >nul

echo.
echo [SUCCESS] Focus context menu updated!
echo [%time%] [SUCCESS] Focus context menu added >> "%LOG_FILE%"
echo [%time%] Added: Antigravity, Claude, CommandCode, Freebuff, GitHub Copilot, KiloCode, MiMo, Mistral Vibe, NanoCode, OpenAI Codex, OpenCode, Perch AI >> "%LOG_FILE%"
echo.
echo TIP: Use Option E if the menu icons look old or broken.
pause
goto MAIN_MENU

REM ========================================
REM REMOVE CONTEXT MENU (FOCUS)
REM ========================================
:REMOVE_CONTEXT_MENU
cls
echo.
echo ================================================
echo  Remove AI CLI Manager (Focus) Context Menu
echo ================================================
echo.
echo [%time%] === Removing focus context menu === >> "%LOG_FILE%"

echo SAFETY INFORMATION:
echo ------------------
echo This operation will remove the "AI CLI Manager (Focus)"
echo entry from your Windows right-click context menu.
echo.

set /p "confirm=Are you sure? (Y/N): "
echo [%time%] User confirm: %confirm% >> "%LOG_FILE%"
if /i not "%confirm%"=="Y" (
    echo [%time%] [CANCELLED] User cancelled >> "%LOG_FILE%"
    goto MAIN_MENU
)

echo.
echo Removing registry keys...
echo [%time%] Deleting HKCR\Directory\Background\shell\AI_CLI_Menu_Focus >> "%LOG_FILE%"
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\AI_CLI_Menu_Focus" /f >nul 2>&1
echo [%time%] Deleting HKCR\Directory\shell\AI_CLI_Menu_Focus >> "%LOG_FILE%"
reg delete "HKEY_CLASSES_ROOT\Directory\shell\AI_CLI_Menu_Focus" /f >nul 2>&1

echo.
echo [SUCCESS] Focus context menu removed.
echo [%time%] [SUCCESS] Focus context menu removed >> "%LOG_FILE%"
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
set "WAIT_RETRIES=0"
:WAIT_EXPLORER_RESTART
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if not errorlevel 1 (
    set /a WAIT_RETRIES+=1
    if !WAIT_RETRIES! geq 10 (
        echo [WARN] explorer.exe still running after 10s, proceeding anyway.
        echo [%time%] [WARN] Explorer poll timeout >> "%LOG_FILE%"
    ) else (
        timeout /t 1 >nul
        goto WAIT_EXPLORER_RESTART
    )
)
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
set "WAIT_DEEP_RETRIES=0"
:WAIT_EXPLORER_DEEP
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if not errorlevel 1 (
    set /a WAIT_DEEP_RETRIES+=1
    if !WAIT_DEEP_RETRIES! geq 10 (
        echo [WARN] explorer.exe still running after 10s, proceeding anyway.
        echo [%time%] [WARN] Explorer poll timeout (deep) >> "%LOG_FILE%"
    ) else (
        timeout /t 1 >nul
        goto WAIT_EXPLORER_DEEP
    )
)

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
REM POST-LAUNCH: return to main menu
REM ========================================
:LAUNCH_DONE
echo.
echo [OK] CLI launched in a new window. Returning to menu...
timeout /t 1 >nul
goto MAIN_MENU

REM ========================================
REM EXIT
REM ========================================
:EXIT_SCRIPT
echo.
echo [%time%] Session ended >> "%LOG_FILE%"
echo Goodbye!
endlocal
exit
