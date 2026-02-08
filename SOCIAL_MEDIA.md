# AI CLI Manager - Social Media Announcements (v1.1.8)

## 🟦 LinkedIn (v1.1.10)
Headline: Code with OpenAI Codex directly from your terminal. 💻

I just pushed v1.1.10 of AI CLI Manager! This release adds native support for individual OpenAI Codex CLI integration.

What's new:
- OpenAI Codex CLI Support: Install and launch `@openai/codex` with a single click.
- Full Context Menu Integration: Right-click any folder to open Codex context instantly.
- Cross-Platform: Works seamlessly on Windows, Linux, and macOS.

If you are exploring local reasoning models or legacy Codex workflows, this manager keeps your environment organized.

Check it out on GitHub!

#OpenAI #Codex #AI #DevTools #OpenSource

---

## 🟥 Reddit (v1.1.10)
**Post Title: [Update] AI CLI Manager v1.1.10 Released - Added OpenAI Codex CLI Support**

Just a quick update for those following the project. I've added support for the `@openai/codex` CLI tool.

This brings the total supported agents to 11 (!), including Gemini, Claude, Copilot, and now Codex.

**New in v1.1.10:**
- Added separate batch launcher for Codex.
- Updated Linux/macOS Nautilus scripts.
- Synced context menu logic across all platforms.

It's getting crowded in here, but the managed menu keeps it clean.

**GitHub**: [https://github.com/krishnakanthb13/ai_cli_manager](https://github.com/krishnakanthb13/ai_cli_manager)

---

## ⬛ X (v1.1.10)
OpenAI Codex CLI is now supported! 🧠

AI CLI Manager v1.1.10 is live.

NEW: Launch OpenAI Codex (@openai/codex)
NEW: Context Menu integration
FIX: Synced batch/sh logic

Manage 11 different AI CLI tools from one simple release.

#OpenAI #Codex #AI #DevTools

---

## 🟦 LinkedIn
Headline: Stop fighting your terminal. Start coding with your AI agents. 🚀

I just released v1.1.8 of the AI CLI Manager!

Managing multiple AI coding assistants shouldn't be harder than using them. This update introduces some major workflow improvements for developers.

What's new in v1.1.8:
- Claude CLI Support: One-click launch, install, and update for Anthropic's agentic coder.
- GitHub Copilot CLI: Standardized nomenclature and improved launcher logic for seamless integration.
- Dedicated Batch File System: We've reorganized the internal structure, moving all standalone launchers to a dedicated directory for better project hygiene.
- Native NanoCode Launcher: Ensuring every CLI option has a corresponding standalone entry point.
- System Refinement: Smoother terminal transitions and updated registry logic for the cascading right-click menu.

Stop manual cd commands and remembering specific package names. Start coding with Gemini, Jules, Mistral, Copilot, and now Claude—all from a single right-click exactly where your project lives.

I built this tool to handle my own friction of juggling 10+ different AI terminal tools. It's lightweight, open-source, and integrates directly into your Windows Explorer workflow.

Check it out on GitHub! 

#AI #OpenSource #DevTools #WindowsTerminal #CodingAssistants #Productivity #ClaudeCode #GitHubCopilot #Anthropic #Dev #Update

---

## 🟥 Reddit (r/programming / r/webdev / r/commandline / r/SideProject / r/ClaudeAI / r/GithubCopilot)
**Post Title: [Showcase] I built a "Command Center" for AI CLI agents that integrates directly into the Windows Context Menu - Just added Claude Code support!**

Hey everyone!

As the landscape of AI coding assistants grows, I found myself juggling a dozen different CLI tools (Gemini, Copilot, Mistral Vibe, etc.). Each has its own install command, update process, and launch syntax. Navigating to a project directory and then remembering the exact command for the specific agent I wanted was creating unnecessary friction.

I built **AI CLI Manager** to solve this. It's a lightweight Batch/Bash dashboard that manages these tools and, most importantly, integrates them into the Windows Explorer right-click menu using cascading submenus.

In the latest **v1.1.8** release, I've added full support for **Anthropic's Claude Code (@anthropic-ai/claude-code)**.

**Technical Deep-Dive:**
- **Cascading Registry Integration**: Uses `MUIVerb` and `SubCommands` registry keys to create a clean, organized shell extension without installing bulky third-party software.
- **Hybrid Distribution System**: The manager handles standard NPM/PIP packages alongside local Git clones (like NanoCode), linking them globally automatically via a custom `/Tools` sandbox.
- **Self-Healing Icons**: Windows icon cache is notorious for getting stuck. I implemented a "Deep Refresh" utility that nukes the `.db` caches and restarts Explorer safely to fix icon corruption.
- **Terminal Context Handoff**: The script detects Windows Terminal (wt.exe) and falls back to standard CMD if needed, passing the directory context (`%V` or `%1`) directly to the AI agent's entry point.

The project is completely open-source (GPL v3) and written in pure scripts to ensure zero dependencies and maximum speed.

I'd love to hear how you guys are managing your local AI agent workflows and if there are other tools you'd like to see integrated!

**GitHub**: [https://github.com/krishnakanthb13/ai_cli_manager](https://github.com/krishnakanthb13/ai_cli_manager)

---

## ⬛ X (Twitter)
Claude Code is here! ☀️

AI CLI Manager v1.1.8 is out! 🚀

NEW: Claude CLI Support
NEW: GitHub Copilot CLI branding
NEW: Optimized Batch Launcher architecture

Seamlessly switch between Claude, Gemini, and Copilot exactly where your code lives. 💻

Check it out: https://github.com/krishnakanthb13/ai_cli_manager

#ClaudeCode #AI #BuildInPublic #OpenSource

## 🟦 LinkedIn
**Headline: Stop fighting your terminal. Start coding with your AI agents.** 🚀

I just released **v1.1.4** of the **AI CLI Manager**! 

Managing multiple AI coding assistants shouldn't be harder than using them. This update introduces some major workflow improvements for developers:

✅ **NanoCode Support**: We now support "Hybrid Distribution"—meaning you can link Git-cloned agents like NanoCode just as easily as NPM/PIP tools.
✅ **Deep Refresh Utilities**: No more "broken icon" ghosts in Windows. Force-clear your system icon cache directly from the dashboard.
✅ **New Navigation**: A redesigned alphanumeric menu makes it faster to get from "Folder" to "Focused AI Coding."
✅ **Registry Safety**: Automated backups before any shell modification.

Whether you're using Gemini, Jules, Mistral, or NanoCode, this manager ensures they're always exactly where you need them: in your right-click context menu.

Check it out on GitHub! 

#AI #OpenSource #DevTools #WindowsTerminal #CodingAssistants #Productivity

---

## 🟥 Reddit (r/programming / r/webdev)
**Post Title: [Showcase] I built a "Command Center" for AI CLI agents that integrates directly into the Windows Context Menu**

Hey everyone!

I've been juggling 10+ AI CLI tools (Gemini, Copilot, NanoCode, etc.) and got tired of manual installations and `cd` commands. 

I built **AI CLI Manager**, and just pushed **v1.1.4** with some cool technical features:

- **Self-Healing Icons**: Windows icon cache is notorious for getting stuck. I added a "Deep Refresh" utility that nukes the `.db` caches and restarts Explorer to fix it safely.
- **Git-Link Hybrid Support**: It handles NPM/PIP packages alongside local Git clones, linking them globally automatically.
- **Cascading Submenus**: Uses `MUIVerb` registry keys to keep your right-click menu clean and organized.

It's all Batch/Bash based (zero bloat, zero dependencies outside the tools themselves).

I'd love to hear how you guys manage your local AI agent workflows!

**GitHub Link**: [Link here]

---

## ⬛ X (Twitter)
Stop manual `cd` commands for your AI agents! 🛑

AI CLI Manager v1.1.4 is out! 🚀

🔥 NEW: NanoCode integration
🔥 NEW: Deep Icon Refresh utility
🔥 NEW: Alphanumeric pro-navigation

Manage Gemini, Jules, Mistral, and NanoCode all from one right-click.

#AI #DevTool #OpenSource #BuildInPublic
