#!/bin/bash

# Navigate to your repository folder (if not already in it)
# cd /path/to/your/repo

# Fetch the latest changes from the remote
git fetch origin

# Pull the latest changes, rebase if possible
git pull origin main --rebase

# Check if there are uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo "There are uncommitted changes. Committing them..."
  # Add changes to staging
  git add .

  # Commit changes with a message
  git commit -m "Automated commit: $(date)"

  # Push changes to the remote repository
  git push origin main
else
  echo "No changes to commit. Proceeding with push."
  # Push changes if there were no local modifications
  git push origin main
fi
