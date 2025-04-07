# enocholaleye.github.io

![Auto Commit Badge](https://img.shields.io/badge/Auto--Commit--Script-Success-green)

## Auto Commit & Push Script

This repository includes an **auto commit and push script** that automates the process of syncing changes with GitHub. The script:

- Automatically stages and commits changes to the repository
- Stashes uncommitted changes, pulls the latest changes from GitHub with `--rebase`, and then restores the changes
- Pushes changes to GitHub whenever there are updates

### How It Works

1. **Stashes Changes:** The script will stash any uncommitted changes (including untracked files) to ensure that a clean pull happens.
2. **Rebase Pull:** It fetches the latest changes and pulls with `--rebase` to keep history clean.
3. **Commit and Push:** If there are changes, it will commit them with an automated message and push them to GitHub.

### Usage

To use this script:
1. Clone the repo to your local machine.
2. Ensure that your GitHub token is set in `.bashrc`.
3. Run the script:  
   ```bash
   ./auto_git.sh
