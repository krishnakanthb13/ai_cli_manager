#!/bin/bash
# AI CLI Manager - Launch Claude CLI
# Compatible with Linux & macOS

CMD="claude"
PKG="curl -fsSL https://claude.ai/install.sh | bash"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  $PKG"
    exit 1
fi

echo "✅ $CMD found!"
sleep 1

while true; do
    clear
    echo "============================================================"
    echo "          ANTHROPIC CLAUDE CLI - MODEL SELECTOR"
    echo "============================================================"
    echo ""
    echo " Select a model option to run:"
    echo ""
    echo " --- OPUS (Complex Reasoning / Planning) ---"
    echo "   [1] Claude Opus 4.8 (Latest - Most Capable)"
    echo "   [2] Claude Opus 4.8 [1M] (1M Token Context Window)"
    echo "   [3] Claude Opus 4.7"
    echo "   [4] Claude Opus 4.7 [1M] (1M Token Context Window)"
    echo "   [5] Claude Opus Plan (Hybrid: Opus plans, Sonnet executes)"
    echo ""
    echo " --- SONNET (Latest / Daily Coding) ---"
    echo "   [6] Claude Sonnet 4.6"
    echo "   [7] Claude Sonnet 4.6 [1M] (1M Token Context Window)"
    echo ""
    echo " --- HAIKU (Fast & Efficient Tasks) ---"
    echo "   [8] Claude Haiku 4.5"
    echo ""
    echo " --- OTHER ---"
    echo "   [9] Claude Best (Most Capable - resolves to Opus)"
    echo "   [10] Claude Default (Account Tier Default Model)"
    echo ""
    echo "   [0] Exit"
    echo ""
    echo "============================================================"
    echo ""

    read -p " Enter your choice (0-10): " choice

    case $choice in
        0) exit 0 ;;
        1) model="claude-opus-4-8"; modelname="Claude Opus 4.8" ;;
        2) model="claude-opus-4-8[1m]"; modelname="Claude Opus 4.8 [1M]" ;;
        3) model="claude-opus-4-7"; modelname="Claude Opus 4.7" ;;
        4) model="claude-opus-4-7[1m]"; modelname="Claude Opus 4.7 [1M]" ;;
        5) model="opusplan"; modelname="Claude Opus Plan" ;;
        6) model="sonnet"; modelname="Claude Sonnet 4.6" ;;
        7) model="sonnet[1m]"; modelname="Claude Sonnet 4.6 [1M]" ;;
        8) model="haiku"; modelname="Claude Haiku 4.5" ;;
        9) model="best"; modelname="Claude Best" ;;
        10) model="default"; modelname="Claude Default" ;;
        *)
            echo ""
            echo " ❌ Invalid choice. Please enter a number between 0-10."
            sleep 2
            continue
            ;;
    esac
    
    echo ""
    echo "============================================================"
    echo " Starting: $modelname"
    if [ "$model" != "default" ]; then
        echo " Model Alias: $model"
    else
        echo " Model Alias: [Default Settings]"
    fi
    echo "============================================================"
    echo ""
    
    if [ "$model" = "default" ]; then
        $CMD
    else
        $CMD --model "$model"
    fi
    
    echo ""
    echo "============================================================"
    echo " Model execution completed!"
    echo "============================================================"
    echo ""
    read -p "Press Enter to continue..."
done
