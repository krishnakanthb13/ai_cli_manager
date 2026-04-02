---
name: update_opencode_models
description: Automates checking OpenCode's API and docs for the latest free models and updating the bat/sh launchers.
---

# Update OpenCode Models

This skill automates the process of fetching the latest free models offered by OpenCode AI and injecting them into the project's launcher scripts.

## Steps

1. **Verify Availability**
   - Read content from `https://opencode.ai/docs/zen/`.
   - Read content from `https://opencode.ai/zen/v1/models`.
   - Compile a list of all models classified as "free" (typically suffixed with `-free`, along with stealth/preview ones like `big-pickle` and `gpt-5-nano`).

2. **Update `Batch Files/LaunchOpencode.bat`**
   - Locate the `OPENCODE CLI - MODEL SELECTOR` section.
   - Replace the list of printed model options with the updated list.
   - Update the interactive prompt max range (e.g., `(0-8)`).
   - Update the mapping variables string (e.g., `if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"`).

3. **Update `Shell Files/LaunchOpenCode.sh`**
   - Locate the launcher loop (`while true; do`).
   - Match the menu UI to precisely equal the `bat` file structure.
   - Match the `case $choice` selection to correctly set `model` and `modelname` based on the updated model IDs mapping.
   - Wait for the user to submit modifications.
