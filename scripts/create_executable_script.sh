#!/bin/zsh
# Author: ChatGPT 3.5 Turbo

# Check if both the directory and script name are provided as arguments
if [ $# -lt 2 ]; then
  echo "Usage: create_executable_script.sh directory_name script_name"
  exit 1
fi

# Extract directory name and script name from input arguments
directory_name="$1"
script_name="$2"

# Create the directory if it doesn't exist
if [ ! -d "$directory_name" ]; then
  mkdir -p "$directory_name"
fi

# Change to the specified directory
cd "$directory_name" || exit

# Check if the script name already exists
if [ -f "$script_name" ]; then
  echo "A script with the name $script_name already exists in the directory $directory_name."
  exit 1
fi

# Create the new script file
touch "$script_name"

# Make the script executable
chmod +x "$script_name"

# Open the script file in a text editor for further editing
nvim "$script_name"
