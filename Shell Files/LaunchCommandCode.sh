#!/bin/bash
# AI CLI Manager - Launch CommandCode CLI
# Compatible with Linux & macOS

CMD="commandcode"
PKG="command-code"

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

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
