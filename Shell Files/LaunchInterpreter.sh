#!/bin/bash
# AI CLI Manager - Launch Open Interpreter CLI
# Compatible with Linux & macOS

CMD="interpreter"
PKG="open-interpreter"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  pip3 install $PKG"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
