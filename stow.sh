#!/bin/bash

stow_package() {
    local package=$1
    echo "Stowing $package..."
    stow "$package"
}

PACKAGES="nvim lazygit tmux zsh alacritty kitty"

if [[ "$OSTYPE" == "darwin"* ]]; then
    PACKAGES="$PACKAGES"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PACKAGES="$PACKAGES hypr"
fi

for package in $PACKAGES; do
    if [ -d "$package" ]; then
        stow_package "$package"
    fi
done 