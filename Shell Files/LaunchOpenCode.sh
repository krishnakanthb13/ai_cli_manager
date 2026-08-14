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
    echo "   [2] DeepSeek V4 Flash Free"
    echo "   [3] MiMo-V2.5 Free"
    echo "   [4] Hy3 Free"
    echo "   [5] Laguna S 2.1 Free"
    echo "   [6] Nemotron 3 Ultra Free"
    echo "   [7] Nemotron 3.5 Lightning Free"
    echo ""
    echo "   [0] Exit"
    echo ""
    echo "============================================================"
    echo ""
    
    read -p " Enter your choice (0-7): " choice
    
    case $choice in
        0) exit 0 ;;
        1) model="opencode/big-pickle"; modelname="Big Pickle" ;;
        2) model="opencode/deepseek-v4-flash-free"; modelname="DeepSeek V4 Flash Free" ;;
        3) model="opencode/mimo-v2.5-free"; modelname="MiMo-V2.5 Free" ;;
        4) model="opencode/hy3-free"; modelname="Hy3 Free" ;;
        5) model="opencode/laguna-s-2.1-free"; modelname="Laguna S 2.1 Free" ;;
        6) model="opencode/nemotron-3-ultra-free"; modelname="Nemotron 3 Ultra Free" ;;
        7) model="opencode/nemotron-3.5-lightning-free"; modelname="Nemotron 3.5 Lightning Free" ;;
        *) 
            echo ""
            echo " ❌ Invalid choice. Please enter a number between 0-7."
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
