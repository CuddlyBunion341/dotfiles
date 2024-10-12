#!/bin/zsh

OS="$(uname)"
ADOPT_STOW=$1

install_bun() {
  if ! command -v bun &> /dev/null; then
    echo "Bun not found, installing..."
    curl -fsSL https://bun.sh/install | bash
  fi
}

install_macos_packages() {
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install nvim alacritty stow rustup asdf
  rustup component add rust-analyzer
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf install nodejs latest
  asdf install ruby latest
  npm install -g lua-language-server
}

install_linux_packages() {
  if command -v pacman &> /dev/null; then
    sudo pacman -S bat eza github-cli stow zsh tmux kitty alacritty vim neovim fzf npm nodejs bun hyprland
    rustup component add rust-analyzer
    npm install -g lua-language-server
  else
    echo "Error: pacman not found."
    exit 1
  fi
}

handle_stow_adoption() {
  if [[ "$ADOPT_STOW" == "--adopt" ]]; then
    stow --adopt alacritty kitty lazygit nvim tmux util zsh
    if [[ "$OS" == "Linux" ]]; then
      stow --adopt hypr
    fi
  else
    echo "To adopt the stow command, rerun the script with --adopt as an argument."
    exit 1
  fi
}

setup_config_files() {
  if [[ ! -f ~/.import-secrets ]]; then
    touch ~/.import-secrets
  fi

  if [[ ! -f nvim/.config/nvim/lua/theme.lua ]]; then
    cp nvim/.config/nvim/lua/theme.lua.example nvim/.config/nvim/lua/theme.lua
  fi

  if [[ ! -f alacritty/.config/alacritty/current-theme.toml ]]; then
    cp alacritty/.config/alacritty/current-theme.toml.example alacritty/.config/alacritty/current-theme.toml
  fi
}

main() {
  install_bun

  if [[ "$OS" == "Darwin" ]]; then
    install_macos_packages
  elif [[ "$OS" == "Linux" ]]; then
    install_linux_packages
  else
    echo "Error: Unsupported OS."
    exit 1
  fi

  handle_stow_adoption
  setup_config_files
}

main
