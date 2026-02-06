#!/bin/bash
# AI CLI Manager - Launch Claude CLI
# Compatible with Linux & macOS

CMD="claude"
PKG="@anthropic-ai/claude-code"

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
