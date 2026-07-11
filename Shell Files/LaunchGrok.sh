#!/bin/bash
# AI CLI Manager - Launch Grok CLI

CMD="grok"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, run:"
    echo "  curl -fsSL https://x.ai/cli/install.sh | bash"
    echo "  (You might need sudo)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open
echo ""
read -p "Press Enter to close..."
