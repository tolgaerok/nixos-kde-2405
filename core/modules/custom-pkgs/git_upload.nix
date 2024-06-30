{
  config,
  pkgs,
  lib,
  ...
}:

let

  gitup = pkgs.writeScriptBin "gitup" ''
    #!/usr/bin/env bash

    set -e

    # Directory of your Git repository----
    REPO_DIR="/etc/nixos"

    # Commit message with timestamp and custom changes
    COMMIT_MSG="(ツ)_/¯ Edit: $(date '+%d-%m-%Y %I:%M:%S %p')"

    # Ensure the Git repository is initialized and 'origin' remote is set--
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo "Initializing Git repository in $REPO_DIR..."
        sudo git init "$REPO_DIR"
        sudo git -C "$REPO_DIR" remote add origin git@github.com:tolgaerok/nixos-kde-2405.git
    fi

    # Set user identity for Git
    sudo git -C "$REPO_DIR" config user.name "Your Name"
    sudo git -C "$REPO_DIR" config user.email "you@example.com"

    # Navigate to the repository directory
    cd "$REPO_DIR" || exit

    # Add all changes
    sudo git add .

    # Commit changes with custom message
    sudo git commit -am "$COMMIT_MSG"

    # Pull changes from remote repository to avoid conflicts
    sudo git pull --rebase origin main

    # Push changes to remote repository
    sudo git push origin main

    # Notification of completion
    echo "Files uploaded successfully."

  '';
in

{

  #---------------------------------------------------------------------
  # Type: gitup in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ gitup ];
}
