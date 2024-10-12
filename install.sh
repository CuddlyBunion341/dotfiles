#!/bin/zsh

OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install nvim alacritty stow
elif [[ "$OS" == "Linux" ]]; then
  if command -v pacman &> /dev/null; then
    sudo pacman -S bat eza github-cli stow zsh tmux kitty alacritty vim neovim fzf
    stow alacritty hypr kitty lazygit nixos nvim tmux util zsh
  else
    echo "Error: pacman not found."
    exit 1
  fi
else
  echo "Error: Unsupported OS."
  exit 1
fi

if [[ ! -f ~/.import-secrets ]]; then
  touch ~/.import-secrets
fi

if [[ ! -f nvim/.config/nvim/lua/theme.lua ]]; then
  cp nvim/.config/nvim/lua/theme.lua.example nvim/.config/nvim/lua/theme.lua
fi

if [[ ! -f alacritty/.config/alacritty/current-theme.toml ]]; then
  cp alacritty/.config/alacritty/current-theme.toml.example alacritty/.config/alacritt//current-theme.toml
fi
