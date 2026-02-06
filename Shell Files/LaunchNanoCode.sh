#!/bin/bash
# AI CLI Manager - Launch NanoCode CLI
# Compatible with Linux & macOS

CMD="nanocode"
REPO="https://github.com/krishnakanthb13/nanocode-2"

echo "Checking for $CMD..."

if ! command -v $CMD &> /dev/null; then
    echo "❌ $CMD not found."
    echo "To install, clone and link the repository:"
    echo "  git clone $REPO"
    echo "  cd nanocode-2"
    echo "  npm link"
    echo "  (You might need sudo for linking)"
else
    echo "✅ Launching $CMD..."
    $CMD
fi

# Keep window open if double-clicked
echo ""
read -p "Press Enter to close..."
