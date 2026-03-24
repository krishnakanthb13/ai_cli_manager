#!/bin/bash

# ============================================================
# AI CLI Beast Mode - Multi-CLI Grid Launcher (Linux/macOS)
# Requires: tmux
# Opens 4 AI CLIs in a 2x2 grid layout in a tmux session.
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

SESSION="cli-beast-mode"

# ========================================
# 1. CHECK TMUX
# ========================================
if ! command -v tmux &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} tmux is required for Beast Mode but was not found."
    echo ""
    echo "  Install tmux:"
    echo "    macOS:   brew install tmux"
    echo "    Ubuntu:  sudo apt install tmux"
    echo "    Fedora:  sudo dnf install tmux"
    echo ""
    read -p "Press any key to exit..." -n1 -s
    exit 1
fi

# ========================================
# 2. CLI MAP (numbers -> commands)
# ========================================
CLI_NAMES=(
    ""         # index 0 unused
    "gemini"   # 1
    "jules"    # 2
    "vibe"     # 3
    "iflow"    # 4
    "opencode" # 5
    "qwen"     # 6
    "kilocode" # 7
    "copilot"  # 8
    "nanocode" # 9
    "claude"   # 10
    "codex"    # 11
    "cline"    # 12
    "junie"    # 13
    "kiro-cli" # 14
    "qodercli" # 15
)

CLI_DISPLAY=(
    ""
    "Gemini"   "Jules"    "Vibe"     "iFlow"    "OpenCode"
    "Qwen"     "KiloCode" "Copilot"  "NanoCode" "Claude"
    "Codex"    "Cline"    "Junie"    "Kiro"     "Qoder"
)

# ========================================
# 3. HELPER: Pause
# ========================================
pause_prompt() {
    read -p "Press any key to continue..." -n1 -s
    echo ""
}

# ========================================
# 4. HELPER: Ask for folder
# ========================================
ask_folder() {
    echo ""
    echo -e " ${CYAN}====================================================${NC}"
    echo -e "   Select working directory for all CLIs"
    echo -e " ${CYAN}====================================================${NC}"
    echo ""
    echo "   Press Enter to use default: $HOME"
    echo ""
    read -p "  Folder path: " LAUNCH_DIR
    if [ -z "$LAUNCH_DIR" ]; then
        LAUNCH_DIR="$HOME"
    fi

    # Remove trailing slash if present
    LAUNCH_DIR="${LAUNCH_DIR%/}"

    # Validate folder exists
    if [ ! -d "$LAUNCH_DIR" ]; then
        echo -e "  ${RED}[ERROR]${NC} Folder not found: $LAUNCH_DIR"
        echo "  Please enter a valid folder path."
        sleep 2
        ask_folder
        return
    fi

    echo ""
    echo -e "  ${GREEN}[OK]${NC} Using folder: $LAUNCH_DIR"
}

# ========================================
# 5. MAIN MENU
# ========================================
show_menu() {
    clear
    echo ""
    echo -e " ${CYAN}====================================================${NC}"
    echo -e " ${BOLD}     AI CLI BEAST MODE  |  Grid Launcher${NC}"
    echo -e " ${CYAN}====================================================${NC}"
    echo ""
    echo "   Launch 4 CLIs in a 2x2 tmux grid."
    echo ""
    echo -e "   ${YELLOW}--- Presets ---${NC}"
    echo ""
    echo "     1. Preset Alpha   [Gemini | Copilot | Codex | Qoder]"
    echo "     2. Preset Beta    [KiloCode | Vibe | OpenCode | Qwen]"
    echo ""
    echo -e "   ${YELLOW}--- Custom ---${NC}"
    echo ""
    echo "     3. Custom Pick    (Choose any 4 CLIs)"
    echo ""
    echo "     0. Exit"
    echo ""
    echo -e " ${CYAN}====================================================${NC}"
    echo ""
    read -p "  Enter your choice: " choice
}

# ========================================
# 6. CUSTOM PICKER
# ========================================
show_cli_list() {
    echo ""
    echo -e " ${CYAN}  Available CLIs:${NC}"
    echo ""
    echo "     1.  gemini        9.  nanocode"
    echo "     2.  jules         10. claude"
    echo "     3.  vibe          11. codex"
    echo "     4.  iflow         12. cline"
    echo "     5.  opencode      13. junie"
    echo "     6.  qwen          14. kiro-cli"
    echo "     7.  kilocode      15. qodercli"
    echo "     8.  copilot"
    echo ""
}

pick_cli() {
    local label=$1
    local result_var=$2
    while true; do
        read -p "  $label (1-15): " num
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le 15 ]; then
            eval "$result_var='${CLI_NAMES[$num]}'"
            return
        else
            echo -e "  ${RED}[!] Invalid.${NC} Enter a number from 1 to 15."
        fi
    done
}

custom_pick() {
    clear
    echo ""
    echo -e " ${CYAN}====================================================${NC}"
    echo -e " ${BOLD}     Custom Grid Picker${NC}"
    echo -e " ${CYAN}====================================================${NC}"
    echo -e "   Layout: [Top-Left | Top-Right] / [Bottom-Left | Bottom-Right]"
    show_cli_list
    pick_cli "Top-Left    " CLI_TL
    pick_cli "Top-Right   " CLI_TR
    pick_cli "Bottom-Left " CLI_BL
    pick_cli "Bottom-Right" CLI_BR
}

# ========================================
# 7. LAUNCH THE GRID (2x2 tmux layout)
# ========================================
launch_grid() {
    local tl=$1
    local tr=$2
    local bl=$3
    local br=$4
    local dir=$5

    echo ""
    echo -e " ${CYAN}====================================================${NC}"
    echo -e " ${BOLD}     Launching Beast Mode Grid...${NC}"
    echo -e " ${CYAN}====================================================${NC}"
    echo ""
    echo -e "  ${BOLD}[$tl]${NC}  |  ${BOLD}[$tr]${NC}"
    echo "  ------+------"
    echo -e "  ${BOLD}[$bl]${NC}  |  ${BOLD}[$br]${NC}"
    echo ""
    echo -e "  Directory: ${CYAN}$dir${NC}"
    echo ""

    # Kill existing session if it exists
    tmux kill-session -t "$SESSION" 2>/dev/null

    # Create new session with pane 0 = TL
    tmux new-session -d -s "$SESSION" -c "$dir"
    tmux send-keys -t "$SESSION:0.0" "$tl" Enter

    # Split right -> TR (pane 1)
    tmux split-window -h -t "$SESSION:0.0" -c "$dir"
    tmux send-keys -t "$SESSION:0.1" "$tr" Enter

    # Focus pane 0 (TL), split down -> BL (pane 2, inserted after pane 0)
    tmux select-pane -t "$SESSION:0.0"
    tmux split-window -v -t "$SESSION:0.0" -c "$dir"
    # After split, new pane becomes pane 1, old pane 1 (TR) becomes pane 2
    tmux send-keys -t "$SESSION:0.1" "$bl" Enter

    # Focus old TR pane (now pane 2), split down -> BR (pane 3)
    tmux select-pane -t "$SESSION:0.2"
    tmux split-window -v -t "$SESSION:0.2" -c "$dir"
    tmux send-keys -t "$SESSION:0.3" "$br" Enter

    # Focus top-left on attach
    tmux select-pane -t "$SESSION:0.0"

    echo ""
    echo -e " ${YELLOW}TIP: Press Ctrl+B then D to detach from tmux without killing CLIs.${NC}"
    echo ""
    sleep 1
    tmux attach-session -t "$SESSION"
}

# ========================================
# 8. MAIN LOOP
# ========================================
while true; do
    show_menu
    case "$choice" in
        1)
            CLI_TL="gemini"
            CLI_TR="copilot"
            CLI_BL="codex"
            CLI_BR="qodercli"
            ask_folder
            launch_grid "$CLI_TL" "$CLI_TR" "$CLI_BL" "$CLI_BR" "$LAUNCH_DIR"
            ;;
        2)
            CLI_TL="kilocode"
            CLI_TR="vibe"
            CLI_BL="opencode"
            CLI_BR="qwen"
            ask_folder
            launch_grid "$CLI_TL" "$CLI_TR" "$CLI_BL" "$CLI_BR" "$LAUNCH_DIR"
            ;;
        3)
            custom_pick
            ask_folder
            launch_grid "$CLI_TL" "$CLI_TR" "$CLI_BL" "$CLI_BR" "$LAUNCH_DIR"
            ;;
        0)
            echo ""
            echo "  Goodbye!"
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}Invalid choice.${NC}"
            sleep 1
            ;;
    esac
done
