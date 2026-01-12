# Contributing to AI CLI Manager

First off, thank you for considering contributing to AI CLI Manager! It's people like you that make the open-source community such an amazing place to learn, inspire, and create.

## 🐛 How to Report Bugs

1.  **Check existing issues**: Before opening a new issue, please search the tracker to see if the bug has already been reported.
2.  **Use a clear title**: Summarize the problem concisely.
3.  **Provide reproduction steps**: Detailed steps on how to reproduce the bug.
4.  **Describe the environment**: Include your OS version, Node.js/Python versions, and any relevant logs from the `Log Files` folder.

## 💡 How to Suggest Features

1.  **Open an issue**: Describe the feature you'd like to see and why it would be useful.
2.  **Be specific**: If possible, suggest how the feature might be implemented.
3.  **Discuss first**: For large features, it's best to discuss them in an issue before starting work.

## 💻 How to Submit Code

1.  **Fork the repository**.
2.  **Create a branch**: Use a descriptive name like `feature/add-new-cli` or `fix/registry-error`.
3.  **Make your changes**: Ensure your code follows the existing style (Batch/Bash).
4.  **Test your changes**: See the [Testing Checklist](#testing-checklist) below.
5.  **Submit a Pull Request**: Provide a clear description of what your PR does and link to any relevant issues.

## 🛠️ Development Setup

### Windows
1.  Clone the repo: `git clone https://github.com/krishnakanthb13/ai_cli_manager.git`
2.  Run `AI_CLI_Manager.bat` as Administrator.
3.  Use Option 12 to create a registry backup before testing menu changes.

### Linux/macOS
1.  Clone the repo: `git clone https://github.com/krishnakanthb13/ai_cli_manager.git`
2.  Make the script executable: `chmod +x AI_CLI_Manager.sh`
3.  Run the script: `./AI_CLI_Manager.sh`

## ✅ Testing Checklist

Before submitting a PR, please ensure:
- [ ] The script runs without syntax errors.
- [ ] Admin/Root checks work correctly.
- [ ] Logging captures the new or modified behavior.
- [ ] CLI installation logic handles both "missing" and "already exits" cases.
- [ ] Context menu additions/removals work as expected.
- [ ] Documentation has been updated to reflect your changes.

---

By contributing, you agree that your contributions will be licensed under the project's [LICENSE](LICENSE).
