#!/bin/bash
# AI CLI Manager - Launch Kimi Code CLI
# Compatible with Linux & macOS

CMD="kimi"
PKG="kimi-cli"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  pip install $PKG"
    echo "  (You might need sudo or use pip3)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
