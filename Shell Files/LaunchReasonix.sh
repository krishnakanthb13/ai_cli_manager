#!/bin/bash
# AI CLI Manager - Launch Reasonix CLI

CMD="reasonix"
PKG="reasonix@next"

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
