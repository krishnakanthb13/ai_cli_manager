#!/bin/bash
# AI CLI Manager - Launch Junie CLI

CMD="junie"
INSTALL_CMD="curl -fsSL https://junie.jetbrains.com/install.sh | bash"

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
