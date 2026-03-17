#!/bin/bash
# AI CLI Manager - Launch Kiro CLI

CMD="kiro-cli"
INSTALL_CMD="curl -fsSL https://cli.kiro.dev/install | bash"

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
