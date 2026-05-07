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
    echo "   [3] Ling 2.6 Flash Free"
    echo "   [4] Hy3 Preview Flash Free"
    echo "   [5] Trinity Large Preview Free"
    echo "   [6] Nemotron 3 Super Free"
    echo ""
    echo "   [0] Exit"
    echo ""
    echo "============================================================"
    echo ""
    
    read -p " Enter your choice (0-6): " choice
    
    case $choice in
        0) exit 0 ;;
        1) model="opencode/big-pickle"; modelname="Big Pickle" ;;
        2) model="opencode/minimax-m2.5-free"; modelname="MiniMax M2.5 Free" ;;
        3) model="opencode/ling-2.6-flash-free"; modelname="Ling 2.6 Flash Free" ;;
        4) model="opencode/hy3-preview-free"; modelname="Hy3 Preview Flash Free" ;;
        5) model="opencode/trinity-large-preview-free"; modelname="Trinity Large Preview Free" ;;
        6) model="opencode/nemotron-3-super-free"; modelname="Nemotron 3 Super Free" ;;
        *) 
            echo ""
            echo " ❌ Invalid choice. Please enter a number between 0-6."
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
