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
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
