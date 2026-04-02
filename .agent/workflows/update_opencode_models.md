---
description: Update OpenCode launchers with the latest free models
---

# Update OpenCode Models Workflow

This workflow ensures the OpenCode launchers are up to date with the latest free models provided by the OpenCode Zen API.

1. Fetch latest free model listings by reading the content from `https://opencode.ai/zen/v1/models` and `https://opencode.ai/docs/zen/`.
2. Identify all models provided for free.
3. Update `Batch Files/LaunchOpencode.bat` model selector echo statements and their corresponding assignments under the `if` choices.
4. Update `Shell Files/LaunchOpenCode.sh` model selector menu and case statement to exactly match the `.bat` file list.
