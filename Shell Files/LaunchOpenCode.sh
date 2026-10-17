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
    echo "   [2] Beam Free"
    echo "   [3] DeepSeek V4.1 Flash Free"
    echo "   [4] Exo Free"
    echo "   [5] GLM-5.3-Flash Free"
    echo "   [6] Jev 1.13 Free"
    echo "   [7] LL Alpha Free"
    echo "   [8] LongCat 2.5 Preview Free"
    echo "   [9] MiMo-V2.5 Free"
    echo "   [10] MiMo-V2.6-Flash Free"
    echo "   [11] Muse Spark 1.3 Contributor Free"
    echo "   [12] Nemotron 3 Ultra Free"
    echo "   [13] Nemotron 3.5 Lightning Free"
    echo "   [14] Nemotron 3.5 Super VL Free"
    echo "   [15] Space Bunny Free"
    echo ""
    echo "   [0] Exit"
    echo ""
    echo "============================================================"
    echo ""
    
    read -p " Enter your choice (0-15): " choice
    
    case $choice in
        0) exit 0 ;;
        1) model="opencode/big-pickle"; modelname="Big Pickle" ;;
        2) model="opencode/beam-free"; modelname="Beam Free" ;;
        3) model="opencode/deepseek-v4.1-flash-free"; modelname="DeepSeek V4.1 Flash Free" ;;
        4) model="opencode/exo-free"; modelname="Exo Free" ;;
        5) model="opencode/glm-5.3-flash-free"; modelname="GLM-5.3-Flash Free" ;;
        6) model="opencode/jev-1.13-free"; modelname="Jev 1.13 Free" ;;
        7) model="opencode/ll-alpha-free"; modelname="LL Alpha Free" ;;
        8) model="opencode/longcat-2.5-preview-free"; modelname="LongCat 2.5 Preview Free" ;;
        9) model="opencode/mimo-v2.5-free"; modelname="MiMo-V2.5 Free" ;;
        10) model="opencode/mimo-v2.6-flash-free"; modelname="MiMo-V2.6-Flash Free" ;;
        11) model="opencode/muse-spark-1.3-contributor-free"; modelname="Muse Spark 1.3 Contributor Free" ;;
        12) model="opencode/nemotron-3-ultra-free"; modelname="Nemotron 3 Ultra Free" ;;
        13) model="opencode/nemotron-3.5-lightning-free"; modelname="Nemotron 3.5 Lightning Free" ;;
        14) model="opencode/nemotron-3.5-super-vl-free"; modelname="Nemotron 3.5 Super VL Free" ;;
        15) model="opencode/space-bunny-free"; modelname="Space Bunny Free" ;;
        *) 
            echo ""
            echo " ❌ Invalid choice. Please enter a number between 0-15."
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
