# AI CLI Manager - Context & Purpose

## 🎯 The "Why"

As the landscape of AI coding assistants grows, developers are juggling multiple Command Line Interface (CLI) tools. Each tool (Gemini, Mistral Vibe, OpenCode, etc.) has its own installation command, update process, and launch syntax.

**We needed a way to:**
1.  **Centralize Management**: A single dashboard to install all tools at once
2.  **Unify Access**: Standardized access points regardless of the underlying tool
3.  **Integrate with Workflow**: Deep integration into Windows File Explorer for instant access in any project directory
4.  **Track Operations**: Comprehensive logging of all actions for troubleshooting

## 💡 The "What"

**AI CLI Manager (v1.0.0)** is a Windows automation tool designed to be the "Command Center" for AI-powered terminal applications.

### Managed AI CLI Tools

| Tool | Package | Type | Use Case |
|------|---------|------|----------|
| **Google Gemini CLI** | `@google/gemini-cli` | NPM | Google's AI coding assistant |
| **Mistral Vibe** | `mistral-vibe` | PIP | Mistral AI's coding helper |
| **iFlow CLI** | `@iflow-ai/iflow-cli` | NPM | iFlow AI assistant |
| **OpenCode CLI** | `opencode-ai` | NPM | Open-source coding AI |
| **Qwen Code CLI** | `@qwen-code/qwen-code` | NPM | Alibaba's Qwen AI |
| **KiloCode CLI** | `@kilocode/cli` | NPM | KiloCode AI assistant |

## 🚀 Key Features

### 1. Smart Installation
- Checks if each CLI is already installed before acting
- Only installs missing tools, skips existing ones
- Shows `[ALREADY INSTALLED]` or `[INSTALLED]` status

### 2. Context-Aware Launching
- Right-click inside any folder to open AI assistants
- Opens Windows Terminal directly in the selected directory
- Falls back to CMD if Windows Terminal not available

### 3. Categorized Menu Interface
```
--- CLI Management ---
 1. Check and Install All CLIs
 2. Show Installed CLI Versions

--- Launch CLIs ---
 3-8. Launch individual AI tools

--- Context Menu ---
 9-11. Windows integration options

--- Utilities ---
 12. Restart File Explorer
```

### 4. Robust Context Menu Integration
- **MUIVerb**: Proper cascading submenu support
- **Reliable Commands**: Uses `cmd.exe /c start wt.exe` format
- **Dual Registration**: Works for both folder backgrounds and folder icons
- **Safety Info**: Detailed explanation before registry changes

### 5. Comprehensive Logging
- All operations logged with timestamps
- User inputs recorded
- Errors captured for troubleshooting
- Registry backups included

### 6. Safety & Reversibility
- **Registry Backup**: Option 11 creates `.reg` backup files
- **Clean Removal**: Option 10 removes all registry changes
- **Explorer Restart**: Option 12 applies changes without reboot

## 📁 Project Structure

```
0_CLI_Manager/
├── AI_CLI_Manager.bat          # Main script (v1.0.0)
├── AI_CLI_Manager_0.bat        # Backup/reference version (v0.1)
├── AI_CLI_MG_readme.md         # User guide
├── AI_CLI_MG_code_readme.md    # Technical documentation
├── AI_CLI_MG_context_readme.md # This file - context & purpose
└── Log Files/                  # Created on first run
    ├── AI_CLI_MG_*.log         # Session logs
    └── AI_CLI_Backup_*.reg     # Registry backups
```

## 🔧 Requirements

| Requirement | Purpose |
|-------------|---------|
| **Windows 10/11** | Operating system |
| **Windows Terminal** | Preferred terminal (optional, has CMD fallback) |
| **Node.js** | Required for NPM-based CLIs |
| **Python** | Required for Mistral Vibe only |
| **Administrator Rights** | Required for registry modifications |
