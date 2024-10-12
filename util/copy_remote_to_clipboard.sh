#!/bin/zsh

# Get the git remote origin URL
remote_url=$(git remote -v | awk '/origin.*fetch/ { print $2 }')

# Copy the remote URL to the clipboard
echo "$remote_url" | pbcopy
