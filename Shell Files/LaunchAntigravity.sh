#!/bin/bash
# AI CLI Manager - Launch Antigravity CLI

CMD="agy"
INSTALL_CMD="curl -fsSL https://antigravity.google/cli/install.sh | bash"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  $INSTALL_CMD"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."
