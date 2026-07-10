#!/bin/bash
# AI CLI Manager - Launch Cursor CLI

CMD="agent"
PKG="cursor"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  curl https://cursor.com/install -fsS | bash"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."