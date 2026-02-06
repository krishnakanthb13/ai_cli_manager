#!/bin/bash
# AI CLI Manager - Launch Mistral Vibe CLI
# Compatible with Linux & macOS

CMD="vibe"
PKG="mistral-vibe"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  pip3 install $PKG"
    echo "  (Ensure you have Python 3 installed)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
