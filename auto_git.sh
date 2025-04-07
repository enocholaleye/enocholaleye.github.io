#!/bin/bash

# Set variables
GITHUB_USERNAME="enocholaleye"
REPO_DIR="$HOME/enocholaleye.github.io"
EMAIL="eolaleye.techadvisor@gmail.com"
LOG_FILE="$HOME/auto_git.log"

# Load your token from an environment variable
# Add this to your ~/.bashrc or ~/.bash_profile: export GITHUB_PAT=your_token
if [ -z "$GITHUB_TOKEN" ]; then
  echo "GitHub token (GITHUB_TOKEN) is not set. Exiting." | tee -a "$LOG_FILE"
  exit 1
fi

cd "$REPO_DIR" || {
  echo "Repo directory $REPO_DIR not found." | tee -a "$LOG_FILE"
  exit 1
}

# Update remote with PAT for authentication
git remote set-url origin https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/enocholaleye.github.io.git

# Stage all changes before stashing (optional but safe)
git add .

# Stash any changes (includes untracked files)
git stash --include-untracked -m "Auto-stash before pulling with rebase"

# Fetch and rebase
git fetch origin
if ! git pull origin main --rebase; then
  echo "Rebase failed!" | tee -a "$LOG_FILE"
  echo "🚨 Git rebase failed for auto_git.sh on $(date)" | mail -s "Git Automation Failed" "$EMAIL"
  exit 1
fi

# Restore stashed changes
git stash pop || echo "No stash to pop, or merge conflicts occurred."

# Check for changes
if [ -n "$(git status --porcelain)" ]; then
  echo "Uncommitted changes found. Committing..." | tee -a "$LOG_FILE"

  git add .
  git commit -m "Automated commit: $(date)"

  if git push origin main; then
    echo "✅ Push successful on $(date)" | tee -a "$LOG_FILE"
    echo "✅ Git push successful for your automation script on $(date)" | mail -s "Git Automation Success" "$EMAIL"
  else
    echo "❌ Push failed!" | tee -a "$LOG_FILE"
    echo "❌ Git push failed for your automation script on $(date)" | mail -s "Git Automation Failed" "$EMAIL"
  fi
else
  echo "No changes to commit. Still pushing..." | tee -a "$LOG_FILE"

  if git push origin main; then
    echo "✅ Push with no changes successful on $(date)" | tee -a "$LOG_FILE"
    echo "✅ Git push (no new commits) completed successfully on $(date)" | mail -s "Git Automation Success" "$EMAIL"
  else
    echo "❌ Push with no changes failed!" | tee -a "$LOG_FILE"
    echo "❌ Git push (no new commits) failed on $(date)" | mail -s "Git Automation Failed" "$EMAIL"
  fi
fi

