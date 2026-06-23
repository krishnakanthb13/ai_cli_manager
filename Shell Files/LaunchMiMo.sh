#!/bin/bash
# AI CLI Manager - Launch MiMo Code CLI

CMD="mimo"
PKG="@mimo-ai/cli"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  npm install -g $PKG"
    echo "  (You might need sudo)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."
