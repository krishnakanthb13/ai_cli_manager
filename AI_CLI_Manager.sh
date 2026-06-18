#!/bin/bash

# ============================================================
# AI CLI Tools Manager (Linux/macOS)
# ============================================================

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/Log Files"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/AI_CLI_MG_Linux_$TIMESTAMP.log"

log() {
    echo -e "[$1] $2" >> "$LOG_FILE"
}

log "INFO" "Session started"

# --- Functions ---

header() {
    clear
    echo -e "${CYAN}================================================${NC}"
    echo -e "${CYAN}   AI CLI TOOLS MANAGER (v1.2.27) (Linux/Mac)${NC}"
    echo -e "${CYAN}================================================${NC}"

    echo ""
}

pause() {
    read -p "Press any key to continue..." -n1 -s
    echo ""
}

check_dependencies() {
    echo -e "${YELLOW}[*] Checking dependencies...${NC}"
    log "INFO" "Checking dependencies"
    
    if ! command -v node &> /dev/null; then
        echo -e "${RED}[ERROR] Node.js is not installed. Please install Node.js first.${NC}"
        log "ERROR" "Node.js missing"
        pause
        return 1
    else
        echo -e "${GREEN}[OK] Node.js found.${NC}"
    fi

    if ! command -v python3 &> /dev/null; then
        echo -e "${YELLOW}[WARNING] Python3 not found. Mistral Vibe and others requiring Python may fail.${NC}"
        log "WARN" "Python3 missing"
        HAS_PYTHON=0
    else
        echo -e "${GREEN}[OK] Python3 found.${NC}"
        HAS_PYTHON=1
    fi
    echo ""
    return 0
}

install_npm_cli() {
    local name=$1
    local package=$2
    
    echo -e "[$name] Checking..."
    
    # Get local version (robust extraction using sed)
    local lver=$(npm list -g "$package" --depth=0 2>/dev/null | grep "$package@" | sed 's/.*@//' | xargs)
    
    # Get cloud version
    local cver=$(npm show "$package" version 2>/dev/null | xargs)
    
    if [ -z "$cver" ]; then cver="unknown"; fi

    if [ -z "$lver" ]; then
        echo -e "${YELLOW}[MISSING]${NC} Installing $name [$cver]..."
        if npm install -g "$package" >/dev/null 2>&1 || sudo npm install -g "$package" >/dev/null 2>&1; then
            echo -e "${GREEN}[INSTALLED] Install + Installed${NC}"
            log "SUCCESS" "$name installed v$cver"
        else
            echo -e "${RED}[FAILED]${NC}"
            log "ERROR" "Failed to install $name"
        fi
    elif [ "$lver" == "$cver" ]; then
        echo -e "${GREEN}[OK] Installed + Updated Version [$lver]${NC}"
        log "INFO" "$name already updated ($lver)"
    else
        echo -e "${YELLOW}[OLD]${NC} Updating $name $lver -> $cver..."
        if npm install -g "$package" >/dev/null 2>&1 || sudo npm install -g "$package" >/dev/null 2>&1; then
            echo -e "${GREEN}[UPDATED] Updated [$cver]${NC}"
            log "SUCCESS" "$name updated to $cver"
        else
            echo -e "${RED}[FAILED]${NC}"
            log "ERROR" "Failed to update $name"
        fi
    fi
}

install_pip_cli() {
    local name=$1
    local package=$2
    
    if [ "$HAS_PYTHON" -eq 0 ]; then
        echo -e "[$name] Skipping (Python missing)"
        return
    fi

    echo -e "[$name] Checking..."
    
    # Get local version
    local lver=$(pip3 show "$package" 2>/dev/null | grep "Version:" | awk '{print $2}' | xargs)
    
    # Get cloud version
    local cver=$(python3 -c "import urllib.request, json; print(json.loads(urllib.request.urlopen(\"https://pypi.org/pypi/$package/json\").read())['info']['version'])" 2>/dev/null | xargs)
    
    if [ -z "$cver" ]; then cver="unknown"; fi

    if [ -z "$lver" ]; then
        echo -e "${YELLOW}[MISSING]${NC} Installing $name [$cver]..."
        if pip3 install "$package" >/dev/null 2>&1; then
            echo -e "${GREEN}[INSTALLED] Install + Installed${NC}"
            log "SUCCESS" "$name installed v$cver"
        else
            echo -e "${RED}[FAILED]${NC}"
            log "ERROR" "Failed to install $name"
        fi
    elif [ "$lver" == "$cver" ]; then
        echo -e "${GREEN}[OK] Installed + Updated Version [$lver]${NC}"
        log "INFO" "$name already updated ($lver)"
    else
        echo -e "${YELLOW}[OLD]${NC} Updating $name $lver -> $cver..."
        if pip3 install "$package" --upgrade >/dev/null 2>&1; then
            echo -e "${GREEN}[UPDATED] Updated [$cver]${NC}"
            log "SUCCESS" "$name updated to $cver"
        else
            echo -e "${RED}[FAILED]${NC}"
            log "ERROR" "Failed to update $name"
        fi
    fi
}

install_nanocode() {
    echo -e "[NanoCode CLI] Checking..."
    
    # Get local version
    local lver=$(npm list -g nanocode-agent --depth=0 2>/dev/null | grep "nanocode-agent@" | sed 's/.*@//' | xargs)
    
    if [ -z "$lver" ]; then
        echo -e "${YELLOW}[MISSING]${NC} Installing NanoCode via Git..."
        if ! command -v git &> /dev/null; then
            echo -e "${RED}[FAILED] Git not found!${NC}"
            log "ERROR" "NanoCode install failed (Git missing)"
            return
        fi
        
        TOOLS_DIR="./Tools"
        mkdir -p "$TOOLS_DIR"
        
        echo "Cloning repository..."
        if [ -d "$TOOLS_DIR/nanocode-2" ]; then
            echo -e "${CYAN}[INFO] nanocode-2 folder already exists. Skipping clone.${NC}"
        else
            if git clone https://github.com/krishnakanthb13/nanocode-2 "$TOOLS_DIR/nanocode-2" >/dev/null 2>&1; then
                echo -e "${GREEN}Clone successful.${NC}"
            else
                echo -e "${RED}[FAILED] Clone failed.${NC}"
                log "ERROR" "NanoCode clone failed"
                return
            fi
        fi
        
        echo "Linking package..."
        cd "$TOOLS_DIR/nanocode-2"
        if sudo npm link >/dev/null 2>&1 || npm link >/dev/null 2>&1; then
            echo -e "${GREEN}[INSTALLED] Git Clone + NPM Link${NC}"
            log "SUCCESS" "NanoCode linked"
        else
            echo -e "${RED}[FAILED] NPM link failed.${NC}"
            log "ERROR" "NanoCode link failed"
        fi
        cd - >/dev/null
    else
        echo -e "${GREEN}[OK] Installed + Linked Version [$lver]${NC}"
        log "INFO" "NanoCode already linked ($lver)"
    fi
}

install_all() {
    clear
    echo -e "${CYAN}=== Checking and Installing All CLIs ===${NC}"
    echo ""
    check_dependencies
    
    # install_npm_cli "Gemini CLI" "@google/gemini-cli"
    echo ""
    install_npm_cli "Jules CLI" "@google/jules"
    echo ""
    # install_npm_cli "iFlow CLI" "@iflow-ai/iflow-cli"
    echo ""
    install_npm_cli "OpenCode CLI" "opencode-ai"
    echo ""
    install_npm_cli "Qwen Code CLI" "@qwen-code/qwen-code"
    echo ""
    install_npm_cli "KiloCode CLI" "@kilocode/cli"
    echo ""
    install_npm_cli "GitHub Copilot CLI" "@github/copilot"
    echo ""
    echo "[Claude CLI] Checking..."
    if ! command -v claude &> /dev/null; then
        echo -e "${YELLOW}[MISSING]${NC} Installing Claude CLI..."
        if ! command -v curl &> /dev/null; then
            echo -e "${RED}[FAILED]${NC} curl not found. Install curl first."
            log "ERROR" "Claude install failed: curl missing"
        else
            echo -e "${CYAN}[INFO]${NC} Downloading from: https://claude.ai/install.sh"
            curl -fsSL https://claude.ai/install.sh | bash
            if [ "${PIPESTATUS[0]}" -eq 0 ] && [ "${PIPESTATUS[1]}" -eq 0 ]; then
                echo -e "${GREEN}[INSTALLED]${NC}"
                log "SUCCESS" "Claude CLI installed"
            else
                echo -e "${RED}[FAILED]${NC}"
                log "ERROR" "Claude install failed"
            fi
        fi
    else
        echo -e "${GREEN}[OK] Installed${NC}"
        log "INFO" "Claude already installed"
    fi
    echo ""
    install_npm_cli "OpenAI Codex CLI" "@openai/codex"
    echo ""
    install_nanocode
    echo ""
    install_npm_cli "Cline CLI" "cline"
    echo ""
    echo "[Junie CLI] Checking..."
    if ! command -v junie &> /dev/null; then
        echo -e "${YELLOW}[MISSING]${NC} Installing Junie CLI..."
        if ! command -v curl &> /dev/null; then
            echo -e "${RED}[FAILED]${NC} curl not found. Install curl first."
            log "ERROR" "Junie install failed: curl missing"
        else
            echo -e "${CYAN}[INFO]${NC} Downloading from: https://junie.jetbrains.com/install.sh"
            curl -fsSL https://junie.jetbrains.com/install.sh | bash
            if [ "${PIPESTATUS[0]}" -eq 0 ] && [ "${PIPESTATUS[1]}" -eq 0 ]; then
                echo -e "${GREEN}[INSTALLED]${NC}"
                log "SUCCESS" "Junie CLI installed"
            else
                echo -e "${RED}[FAILED]${NC}"
                log "ERROR" "Junie install failed"
            fi
        fi
    else
        echo -e "${GREEN}[OK] Installed${NC}"
        log "INFO" "Junie already installed"
    fi
    echo ""
    echo "[Kiro CLI] Checking..."
    if ! command -v kiro-cli &> /dev/null; then
        echo -e "${YELLOW}[MISSING]${NC} Installing Kiro CLI..."
        if ! command -v curl &> /dev/null; then
            echo -e "${RED}[FAILED]${NC} curl not found. Install curl first."
            log "ERROR" "Kiro install failed: curl missing"
        else
            echo -e "${CYAN}[INFO]${NC} Downloading from: https://cli.kiro.dev/install"
            curl -fsSL https://cli.kiro.dev/install | bash
            if [ "${PIPESTATUS[0]}" -eq 0 ] && [ "${PIPESTATUS[1]}" -eq 0 ]; then
                echo -e "${GREEN}[INSTALLED]${NC}"
                log "SUCCESS" "Kiro CLI installed"
            else
                echo -e "${RED}[FAILED]${NC}"
                log "ERROR" "Kiro install failed"
            fi
        fi
    else
        echo -e "${GREEN}[OK] Installed${NC}"
        log "INFO" "Kiro already installed"
    fi
    install_npm_cli "Qoder CLI" "@qoder-ai/qodercli"
    echo ""
    echo "[Antigravity CLI] Checking..."
    if ! command -v agy &> /dev/null; then
        echo -e "${YELLOW}[MISSING]${NC} Installing Antigravity CLI..."
        if ! command -v curl &> /dev/null; then
            echo -e "${RED}[FAILED]${NC} curl not found. Install curl first."
            log "ERROR" "Antigravity install failed: curl missing"
        else
            echo -e "${CYAN}[INFO]${NC} Downloading from: https://antigravity.google/cli/install.sh"
            curl -fsSL https://antigravity.google/cli/install.sh | bash
            if [ "${PIPESTATUS[0]}" -eq 0 ] && [ "${PIPESTATUS[1]}" -eq 0 ]; then
                echo -e "${GREEN}[INSTALLED]${NC}"
                log "SUCCESS" "Antigravity CLI installed"
            else
                echo -e "${RED}[FAILED]${NC}"
                log "ERROR" "Antigravity install failed"
            fi
        fi
    else
        echo -e "${GREEN}[OK] Installed${NC}"
        log "INFO" "Antigravity already installed"
    fi
    echo ""
    install_pip_cli "Mistral Vibe" "mistral-vibe"
    echo ""
    install_pip_cli "Kimi Code CLI" "kimi-cli"
    echo ""
    install_pip_cli "Aider CLI" "aider-chat"
    echo ""
    install_pip_cli "Open Interpreter CLI" "open-interpreter"


    echo ""
    echo -e "${CYAN}=== Completed ===${NC}"
    pause
}

show_versions() {
    clear
    echo -e "${CYAN}=== Installed Models Versions ===${NC}"
    echo ""
    log "INFO" "Checking versions"
    
    echo -e "${CYAN}--- Gemini CLI ---${NC}"
    echo "--- Gemini CLI ---" >> "$LOG_FILE"
    npm list -g @google/gemini-cli --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- Jules CLI ---${NC}"
    echo -e "\n--- Jules CLI ---" >> "$LOG_FILE"
    npm list -g @google/jules --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2

    echo -e "\n${CYAN}--- iFlow CLI ---${NC}"
    echo -e "\n--- iFlow CLI ---" >> "$LOG_FILE"
    npm list -g @iflow-ai/iflow-cli --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- OpenCode CLI ---${NC}"
    echo -e "\n--- OpenCode CLI ---" >> "$LOG_FILE"
    npm list -g opencode-ai --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- Qwen Code CLI ---${NC}"
    echo -e "\n--- Qwen Code CLI ---" >> "$LOG_FILE"
    npm list -g @qwen-code/qwen-code --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- KiloCode CLI ---${NC}"
    echo -e "\n--- KiloCode CLI ---" >> "$LOG_FILE"
    npm list -g @kilocode/cli --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- GitHub Copilot CLI ---${NC}"
    echo -e "\n--- GitHub Copilot CLI ---" >> "$LOG_FILE"
    npm list -g @github/copilot --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2

    echo -e "\n${CYAN}--- Claude CLI ---${NC}"
    echo -e "\n--- Claude CLI ---" >> "$LOG_FILE"
    if command -v claude &> /dev/null; then
        echo "[INSTALLED]" | tee -a "$LOG_FILE"
    else
        echo "[NOT INSTALLED]" | tee -a "$LOG_FILE"
    fi

    echo -e "\n${CYAN}--- OpenAI Codex CLI ---${NC}"
    echo -e "\n--- OpenAI Codex CLI ---" >> "$LOG_FILE"
    npm list -g @openai/codex --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2

    echo -e "\n${CYAN}--- NanoCode CLI ---${NC}"
    echo -e "\n--- NanoCode CLI ---" >> "$LOG_FILE"
    npm list -g nanocode-agent --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2

    echo -e "\n${CYAN}--- Cline CLI ---${NC}"
    echo -e "\n--- Cline CLI ---" >> "$LOG_FILE"
    npm list -g cline --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- Junie CLI ---${NC}"
    echo -e "\n--- Junie CLI ---" >> "$LOG_FILE"
    if command -v junie &> /dev/null; then
        junie --version 2>/dev/null | tee -a "$LOG_FILE"
    else
        echo "[NOT INSTALLED]" | tee -a "$LOG_FILE"
    fi

    echo -e "\n${CYAN}--- Kiro CLI ---${NC}"
    echo -e "\n--- Kiro CLI ---" >> "$LOG_FILE"
    if command -v kiro-cli &> /dev/null; then
        echo "[INSTALLED]" | tee -a "$LOG_FILE"
    else
        echo "[NOT INSTALLED]" | tee -a "$LOG_FILE"
    fi

    echo -e "\n${CYAN}--- Qoder CLI ---${NC}"
    echo -e "\n--- Qoder CLI ---" >> "$LOG_FILE"
    npm list -g @qoder-ai/qodercli --depth=0 2>/dev/null | tee -a "$LOG_FILE" | head -n 2
    
    echo -e "\n${CYAN}--- Antigravity CLI ---${NC}"
    echo -e "\n--- Antigravity CLI ---" >> "$LOG_FILE"
    if command -v agy &> /dev/null; then
        agy --version 2>/dev/null | tee -a "$LOG_FILE"
    else
        echo "[NOT INSTALLED]" | tee -a "$LOG_FILE"
    fi

    echo -e "\n${CYAN}--- Mistral Vibe ---${NC}"

    echo -e "\n--- Mistral Vibe ---" >> "$LOG_FILE"
    pip3 show mistral-vibe 2>/dev/null | grep "Version" | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}--- Kimi Code CLI ---${NC}"
    echo -e "\n--- Kimi Code CLI ---" >> "$LOG_FILE"
    pip3 show kimi-cli 2>/dev/null | grep "Version" | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}--- Aider CLI ---${NC}"
    echo -e "\n--- Aider CLI ---" >> "$LOG_FILE"
    pip3 show aider-chat 2>/dev/null | grep "Version" | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}--- Open Interpreter CLI ---${NC}"
    echo -e "\n--- Open Interpreter CLI ---" >> "$LOG_FILE"
    pip3 show open-interpreter 2>/dev/null | grep "Version" | tee -a "$LOG_FILE"

    echo ""
    pause
}

detect_terminal() {
    # Echo a terminal-spawn command prefix that accepts a shell command as its trailing arg.
    # Empty result = no terminal emulator found.
    if [ "$(uname)" = "Darwin" ]; then
        echo "osascript-mac"
        return
    fi
    if [ -n "$DISPLAY$WAYLAND_DISPLAY" ] || command -v gnome-terminal &> /dev/null; then
        if command -v gnome-terminal &> /dev/null;     then echo "gnome-terminal";   return; fi
        if command -v konsole &> /dev/null;            then echo "konsole";          return; fi
        if command -v xfce4-terminal &> /dev/null;     then echo "xfce4-terminal";   return; fi
        if command -v tilix &> /dev/null;              then echo "tilix";            return; fi
        if command -v alacritty &> /dev/null;          then echo "alacritty";        return; fi
        if command -v kitty &> /dev/null;              then echo "kitty";            return; fi
        if command -v xterm &> /dev/null;              then echo "xterm";            return; fi
        if command -v x-terminal-emulator &> /dev/null; then echo "x-terminal-emulator"; return; fi
    fi
    echo ""
}

spawn_in_terminal() {
    # Spawn "$@" in a new terminal window (returns immediately).
    # Falls back to running inline if no terminal emulator is available.
    local term
    term="$(detect_terminal)"
    case "$term" in
        gnome-terminal)       gnome-terminal -- "$@" & ;;
        konsole)              konsole -e "$@" & ;;
        xfce4-terminal)       xfce4-terminal -e "$*" & ;;
        tilix)                tilix -e "$@" & ;;
        alacritty)            alacritty -e "$@" & ;;
        kitty)                kitty "$@" & ;;
        xterm)                xterm -e "$@" & ;;
        x-terminal-emulator)  x-terminal-emulator -e "$@" & ;;
        osascript-mac)
            local quoted
            printf -v quoted '%q ' "$@"
            osascript -e "tell application \"Terminal\" to do script \"$quoted\""
            ;;
        *)
            echo -e "${YELLOW}[WARN]${NC} No terminal emulator detected; running inline."
            "$@"
            pause
            return
            ;;
    esac
    disown 2>/dev/null
}

launch_tool() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}[ERROR]${NC} '$cmd' not found in PATH."
        echo "Run option 'I' to install all CLIs first."
        log "ERROR" "CLI not found: $cmd"
        sleep 2
        return 1
    fi
    echo -e "${GREEN}Launching $cmd in a new terminal...${NC}"
    log "INFO" "Launching $cmd"
    spawn_in_terminal "$cmd"
    sleep 1
}

create_script_file() {
    local tool=$1
    local cmd=$2
    local dir="$HOME/.local/share/nautilus/scripts/AI CLI Tools"
    local file="$dir/$tool"
    local term_cmd

    # Detect available terminal emulator
    if command -v gnome-terminal &> /dev/null; then
        term_cmd="gnome-terminal --"
    elif command -v xfce4-terminal &> /dev/null; then
        term_cmd="xfce4-terminal -e"
    elif command -v konsole &> /dev/null; then
        term_cmd="konsole -e"
    elif command -v tilix &> /dev/null; then
        term_cmd="tilix -e"
    elif command -v alacritty &> /dev/null; then
        term_cmd="alacritty -e"
    elif command -v xterm &> /dev/null; then
        term_cmd="xterm -e"
    else
        term_cmd="x-terminal-emulator -e"
    fi

    mkdir -p "$dir"
    echo "#!/bin/bash" > "$file"
    echo "$term_cmd $cmd" >> "$file"
    chmod +x "$file"
    echo -e "Created ${CYAN}$tool${NC} script."
}

add_context_menu_linux() {
    clear
    echo -e "${CYAN}=== Add to Context Menu (Linux/Nautilus) ===${NC}"
    echo ""
    echo -e "This feature creates scripts in ${YELLOW}~/.local/share/nautilus/scripts${NC}"
    echo "It allows you to right-click in Nautilus (Files) -> Scripts -> AI CLI Tools"
    echo ""
    read -p "Do you want to continue? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        return
    fi
    
    echo ""
    log "INFO" "Adding Nautilus scripts"
    
    if [ ! -d "$HOME/.local/share/nautilus/scripts" ]; then
        echo -e "${YELLOW}Nautilus scripts directory not found. Creating it...${NC}"
        mkdir -p "$HOME/.local/share/nautilus/scripts"
    fi

    create_script_file "Open with Gemini CLI (Deprecated)" "\"$SCRIPT_DIR/Shell Files/LaunchGemini_deprecated.sh\""
    create_script_file "Open with Jules CLI" "jules"
    create_script_file "Open with Mistral Vibe CLI" "vibe"
    create_script_file "Open with iFlow CLI (Deprecated)" "\"$SCRIPT_DIR/Shell Files/LaunchIFlow_deprecated.sh\""
    create_script_file "Open with OpenCode CLI" "opencode"
    create_script_file "Open with Qwen Code CLI" "qwen"
    create_script_file "Open with KiloCode CLI" "kilocode"
    create_script_file "Open with GitHub Copilot CLI" "copilot"
    create_script_file "Open with Claude CLI" "claude"
    create_script_file "Open with OpenAI Codex CLI" "codex"
    create_script_file "Open with NanoCode CLI" "nanocode"
    create_script_file "Open with Cline CLI" "cline"
    create_script_file "Open with Junie CLI" "junie"
    create_script_file "Open with Kiro CLI" "kiro-cli"
    create_script_file "Open with Qoder CLI" "qodercli"
    create_script_file "Open with Antigravity CLI" "agy"
    create_script_file "Open with Kimi Code CLI" "kimi"
    create_script_file "Open with Aider CLI" "aider"
    create_script_file "Open with Open Interpreter CLI" "interpreter"

    echo ""

    echo -e "${GREEN}[SUCCESS] Scripts added!${NC}"
    echo "Right-click a file in Nautilus -> Scripts -> AI CLI Tools"
    pause
}

remove_context_menu_linux() {
    clear
    echo -e "${CYAN}=== Remove Context Menu (Linux/Nautilus) ===${NC}"
    echo ""
    echo -e "This will remove the folder: ${YELLOW}~/.local/share/nautilus/scripts/AI CLI Tools${NC}"
    echo ""
    echo -e "${YELLOW}SAFETY INFORMATION:${NC}"
    echo "------------------"
    echo "This operation will permanently delete the AI CLI scripts folder."
    echo "It will cleanly remove the 'AI CLI Tools' entry from your right-click menu."
    echo ""
    echo -e "${YELLOW}RECOMMENDATION:${NC}"
    echo "1. You can always re-add them using Option A."
    echo ""
    read -p "Are you sure? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        return
    fi
    
    echo ""
    log "INFO" "Removing Nautilus scripts"
    
    dir="$HOME/.local/share/nautilus/scripts/AI CLI Tools"
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo -e "${GREEN}[SUCCESS] Scripts removed.${NC}"
        log "SUCCESS" "Nautilus scripts removed"
    else
        echo -e "${YELLOW}Scripts directory not found. Nothing to remove.${NC}"
        log "WARN" "Nautilus scripts not found"
    fi
    pause
}

restart_nautilus() {
    clear
    echo -e "${CYAN}=== Restart Nautilus ===${NC}"
    echo ""
    echo "This will kill all Nautilus processes to refresh the context menu."
    echo "Your open file manager windows will close."
    echo ""
    echo -e "${YELLOW}SAFETY INFORMATION:${NC}"
    echo "------------------"
    echo "This will forcibly close all open File Manager windows."
    echo "Any file operations (copying/moving) currently in progress MAY be interrupted."
    echo ""
    echo -e "${YELLOW}RECOMMENDATION:${NC}"
    echo "1. Finish any file transfers before proceeding."
    echo "2. Save any work in open applications."
    echo ""
    read -p "Continue? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        return
    fi
    
    echo ""
    log "INFO" "Restarting Nautilus"
    
    if pgrep -x "nautilus" > /dev/null; then
        killall nautilus
        echo -e "${GREEN}[SUCCESS] Nautilus restarted.${NC}"
        log "SUCCESS" "Nautilus restarted"
    else
        echo -e "${YELLOW}Nautilus is not running.${NC}"
    fi
    pause
}

# --- Mac Functions ---

create_automator_workflow() {
    local tool=$1
    local cmd=$2
    # Mac automation via script is complex/risky.
    # Placeholder to keep structure consistent if we add AppleScript support later.
    # Read details in LINUX_MAC_README.md - 🍏 macOS: How to Add Context Menu (Manual Workaround) for more info.
}

# --- Main Loop ---

while true; do
    header
    echo -e " ${YELLOW}--- CLI Management ---${NC}"
    echo "  I. Check and Install All CLIs"
    echo "  V. Show Installed CLI Versions"
    echo ""
    echo -e " ${YELLOW}--- Launch CLIs ---${NC}"
    echo "  1. Launch Gemini CLI (Deprecated)"
    echo "  2. Launch Jules CLI"
    echo "  3. Launch Mistral Vibe CLI"
    echo "  4. Launch iFlow CLI (Deprecated)"
    echo "  5. Launch OpenCode CLI"
    echo "  6. Launch Qwen Code CLI"
    echo "  7. Launch KiloCode CLI"
    echo "  8. Launch GitHub Copilot CLI"
    echo "  9. Launch NanoCode CLI"
    echo "  10. Launch Claude CLI"
    echo "  11. Launch OpenAI Codex CLI"
    echo "  12. Launch Cline CLI"
    echo "  13. Launch Junie CLI"
    echo "  14. Launch Kiro CLI"
    echo "  15. Launch Qoder CLI"
    echo "  16. Launch Antigravity CLI"
    echo "  17. Launch Kimi Code CLI"
    echo "  18. Launch Aider CLI"
    echo "  19. Launch Open Interpreter CLI"
    echo ""

    echo -e " ${YELLOW}--- Context Menu ---${NC}"
    echo "  A. Add to Context Menu (Linux/Nautilus Only)"
    echo "  B. Remove from Context Menu (Linux Only)"
    echo "  C. Restart Nautilus (Linux Only)"
    echo ""
    echo "  0. Exit"
    echo ""
    echo -e "${CYAN}================================================${NC}"
    
    read -p "Enter your choice: " choice
    log "INPUT" "User choice: $choice"
    
    case $choice in
        [Ii]) install_all ;;
        [Vv]) show_versions ;;
        1) 
            echo -e "${RED}[WARNING] Gemini CLI is deprecated and sunsetted.${NC}"
            echo "Please use Google Antigravity CLI (agy) instead."
            sleep 2
            ;;
        2) launch_tool "jules" ;;
        3) launch_tool "vibe" ;;
        4) 
            echo -e "${RED}[WARNING] iFlow CLI is deprecated and shutdown.${NC}"
            echo "Please use Qoder CLI (qodercli) instead."
            sleep 2
            ;;
        5) launch_tool "opencode" ;;
        6) launch_tool "qwen" ;;
        7) launch_tool "kilocode" ;;
        8) launch_tool "copilot" ;;
        9) launch_tool "nanocode" ;;
        10) launch_tool "claude" ;;
        11) launch_tool "codex" ;;
        12) launch_tool "cline" ;;
        13) launch_tool "junie" ;;
        14) launch_tool "kiro-cli" ;;
        15) launch_tool "qodercli" ;;
        16) launch_tool "agy" ;;
        17) launch_tool "kimi" ;;
        18) launch_tool "aider" ;;
        19) launch_tool "interpreter" ;;
        [Aa]) add_context_menu_linux ;;
        [Bb]) remove_context_menu_linux ;;
        [Cc]) restart_nautilus ;;
        0) 
            echo "Goodbye!"
            exit 0 
            ;;
        *) 
            echo -e "${RED}Invalid choice.${NC}" 
            sleep 1 
            ;;
    esac
done
