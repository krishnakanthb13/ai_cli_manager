#!/bin/bash
# AI CLI Manager - Launch OpenCode CLI
# Compatible with Linux & macOS

CMD="opencode"
PKG="opencode-ai"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  npm install -g $PKG"
    echo "  (You might need sudo)"
    exit 1
fi

echo "✅ $CMD found!"
sleep 1

while true; do
    clear
    echo "============================================================"
    echo "             OPENCODE CLI - MODEL SELECTOR"
    echo "============================================================"
    echo ""
    echo " Select a model to run:"
    echo ""
    echo "   [1] Big Pickle"
    echo "   [2] MiniMax M2.5 Free"
    echo "   [3] Qwen3.6 Plus Free"
    echo "   [4] MiMo V2 Pro Free"
    echo "   [5] MiMo V2 Omni Free"
    echo "   [6] MiMo V2 Flash Free"
    echo "   [7] Trinity Large Preview Free"
    echo "   [8] Nemotron 3 Super Free"
    echo "   [9] GPT 5 Nano"
    echo ""
    echo "   [0] Exit"
    echo ""
    echo "============================================================"
    echo ""
    
    read -p " Enter your choice (0-9): " choice
    
    case $choice in
        0) exit 0 ;;
        1) model="opencode/big-pickle"; modelname="Big Pickle" ;;
        2) model="opencode/minimax-m2.5-free"; modelname="MiniMax M2.5 Free" ;;
        3) model="opencode/qwen3.6-plus-free"; modelname="Qwen3.6 Plus Free" ;;
        4) model="opencode/mimo-v2-pro-free"; modelname="MiMo V2 Pro Free" ;;
        5) model="opencode/mimo-v2-omni-free"; modelname="MiMo V2 Omni Free" ;;
        6) model="opencode/mimo-v2-flash-free"; modelname="MiMo V2 Flash Free" ;;
        7) model="opencode/trinity-large-preview-free"; modelname="Trinity Large Preview Free" ;;
        8) model="opencode/nemotron-3-super-free"; modelname="Nemotron 3 Super Free" ;;
        9) model="opencode/gpt-5-nano"; modelname="GPT 5 Nano" ;;
        *) 
            echo ""
            echo " ❌ Invalid choice. Please enter a number between 0-9."
            sleep 2
            continue
            ;;
    esac
    
    echo ""
    echo "============================================================"
    echo " Starting: $modelname"
    echo " Model ID: $model"
    echo "============================================================"
    echo ""
    
    $CMD --model $model
    
    echo ""
    echo "============================================================"
    echo " Model execution completed!"
    echo "============================================================"
    echo ""
    read -p "Press Enter to continue..."
done
