#!/usr/bin/env bash

set -e

# Directory of your Git repository
REPO_DIR="/etc/nixos"

# Commit message with timestamp and custom changes
COMMIT_MSG="(ツ)_/¯ Edit: $(date '+%d-%m-%Y %I:%M:%S %p')"

# Ensure the Git repository is initialized and 'origin' remote is set
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Initializing Git repository in $REPO_DIR..."
    git init "$REPO_DIR"
    git -C "$REPO_DIR" remote add origin git@github.com:tolgaerok/nixos-kde-2405.git
fi

# Set user identity for Git (adjust these lines accordingly)
git -C "$REPO_DIR" config user.name "Tolga Erok"
git -C "$REPO_DIR" config user.email "kingtolga@gmail.com"

# Navigate to the repository directory
cd "$REPO_DIR" || exit

# Add all changes
git add .

# Commit changes with custom message
git commit -am "$COMMIT_MSG"

# Pull changes from remote repository to avoid conflicts
git pull --rebase origin main

# Push changes to remote repository
git push origin main

# Notification of completion
echo "Files uploaded successfully."
