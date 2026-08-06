#!/bin/bash
# AI CLI Manager - Launch Meta Muse Code CLI

CMD="muse"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  curl -fsSL https://dev.meta.ai/install.sh | bash"
    echo "  (You might need sudo)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."
