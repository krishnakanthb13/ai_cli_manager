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

LOG_DIR="./Log Files"
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
    echo -e "${CYAN}        AI CLI TOOLS MANAGER (Linux/Mac)${NC}"
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
    
    echo -e "Checking ${CYAN}$name${NC}..."
    if npm list -g "$package" &> /dev/null || command -v "$(basename $package)" &> /dev/null; then
         echo -e "${GREEN}[ALREADY INSTALLED]${NC}"
         log "INFO" "$name already installed"
    else
        echo -e "${YELLOW}Installing $name...${NC}"
        # Try without sudo first, then with sudo if failed
        if npm install -g "$package"; then
            echo -e "${GREEN}[INSTALLED]${NC}"
            log "SUCCESS" "$name installed"
        else
            echo -e "${YELLOW}Permission denied. Trying with sudo...${NC}"
            if sudo npm install -g "$package"; then
                echo -e "${GREEN}[INSTALLED]${NC}"
                log "SUCCESS" "$name installed with sudo"
            else
                echo -e "${RED}[FAILED] Could not install $name${NC}"
                log "ERROR" "Failed to install $name"
            fi
        fi
    fi
}

install_pip_cli() {
    local name=$1
    local package=$2
    
    if [ "$HAS_PYTHON" -eq 0 ]; then
        echo -e "${YELLOW}Skipping $name (Python missing)${NC}"
        return
    fi

    echo -e "Checking ${CYAN}$name${NC}..."
    if pip3 show "$package" &> /dev/null; then
         echo -e "${GREEN}[ALREADY INSTALLED]${NC}"
         log "INFO" "$name already installed"
    else
        echo -e "${YELLOW}Installing $name...${NC}"
        if pip3 install "$package"; then
            echo -e "${GREEN}[INSTALLED]${NC}"
            log "SUCCESS" "$name installed"
        else
             echo -e "${RED}[FAILED] Could not install $name${NC}"
             log "ERROR" "Failed to install $name"
        fi
    fi
}

install_all() {
    clear
    echo -e "${CYAN}=== Checking and Installing All CLIs ===${NC}"
    echo ""
    check_dependencies
    
    install_npm_cli "Gemini CLI" "@google/gemini-cli"
    echo ""
    install_npm_cli "Jules CLI" "@google/jules"
    echo ""
    install_npm_cli "iFlow CLI" "@iflow-ai/iflow-cli"
    echo ""
    install_npm_cli "OpenCode CLI" "opencode-ai"
    echo ""
    install_npm_cli "Qwen Code CLI" "@qwen-code/qwen-code"
    echo ""
    install_npm_cli "KiloCode CLI" "@kilocode/cli"
    echo ""
    install_pip_cli "Mistral Vibe" "mistral-vibe"
    
    echo ""
    echo -e "${CYAN}=== Completed ===${NC}"
    pause
}

show_versions() {
    clear
    echo -e "${CYAN}=== Installed Models Versions ===${NC}"
    echo ""
    
    echo -e "${CYAN}--- Gemini CLI ---${NC}"
    npm list -g @google/gemini-cli --depth=0 2>/dev/null | head -n 2
    
    echo -e "\n${CYAN}--- Jules CLI ---${NC}"
    npm list -g @google/jules --depth=0 2>/dev/null | head -n 2

    echo -e "\n${CYAN}--- iFlow CLI ---${NC}"
    npm list -g @iflow-ai/iflow-cli --depth=0 2>/dev/null | head -n 2
    
    echo -e "\n${CYAN}--- OpenCode CLI ---${NC}"
    npm list -g opencode-ai --depth=0 2>/dev/null | head -n 2
    
    echo -e "\n${CYAN}--- Qwen Code CLI ---${NC}"
    npm list -g @qwen-code/qwen-code --depth=0 2>/dev/null | head -n 2
    
    echo -e "\n${CYAN}--- KiloCode CLI ---${NC}"
    npm list -g @kilocode/cli --depth=0 2>/dev/null | head -n 2
    
    echo -e "\n${CYAN}--- Mistral Vibe ---${NC}"
    pip3 show mistral-vibe 2>/dev/null | grep "Version"
    
    echo ""
    pause
}

launch_tool() {
    local cmd=$1
    echo -e "${GREEN}Launching $cmd...${NC}"
    log "INFO" "Launching $cmd"
    $cmd
    pause
}


# --- Main Loop ---

while true; do
    header
    echo -e " ${YELLOW}--- CLI Management ---${NC}"
    echo "  1. Check and Install All CLIs"
    echo "  2. Show Installed CLI Versions"
    echo ""
    echo -e " ${YELLOW}--- Launch CLIs ---${NC}"
    echo "  3. Launch Gemini CLI"
    echo "  4. Launch Jules CLI"
    echo "  5. Launch Mistral Vibe CLI"
    echo "  6. Launch iFlow CLI"
    echo "  7. Launch OpenCode CLI"
    echo "  8. Launch Qwen Code CLI"
    echo "  9. Launch KiloCode CLI"
    echo ""
    echo "  0. Exit"
    echo ""
    echo -e "${CYAN}================================================${NC}"
    
    read -p "Enter your choice (0-9): " choice
    log "INPUT" "User choice: $choice"
    
    case $choice in
        1) install_all ;;
        2) show_versions ;;
        3) launch_tool "gemini" ;;
        4) launch_tool "jules" ;;
        5) launch_tool "vibe" ;;
        6) launch_tool "iflow" ;;
        7) launch_tool "opencode" ;;
        8) launch_tool "qwen" ;;
        9) launch_tool "kilocode" ;;
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
