#!/bin/bash

ORG_NAME="prog1-kurs"
GH_USER="bengldan"
GH_HOST="github.zhaw.ch"

for cmd in gh jq fzf; do
  if ! command -v $cmd &>/dev/null; then
    echo "Error: $cmd is not installed." >&2
    exit 1
  fi
done

list_repos() {
  GH_HOST=$GH_HOST gh repo list $ORG_NAME --json name | jq -r '.[].name' | fzf
}

fork_and_clone_repo() {
  local repo_name=$1
  GH_HOST=$GH_HOST gh repo fork "$ORG_NAME/$repo_name" --clone
}

REPO_LIST=$(list_repos)
if [ -n "$REPO_LIST" ]; then
  fork_and_clone_repo "$REPO_LIST"
else
  echo "No repository selected."
fi
