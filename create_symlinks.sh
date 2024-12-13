#!/bin/zsh

function create_symlink() {
  if [[ ! -e $1 ]]; then
    echo "Source file $1 does not exist"
  elif [[ ! -e $2 ]]; then
    ln -s $1 $2
    echo "Created symlink $2 -> $1"
  elif [[ -L $2 && ! -e $2 ]]; then
    echo "Symlink $2 is broken"
  else
    echo "Symlink $2 already exists"
  fi
}

create_symlink ~/dotfiles/.zshrc ~/.zshrc
create_symlink ~/dotfiles/.config/nvim ~/.config/nvim
create_symlink ~/dotfiles/.config/alacritty ~/.config/alacritty
create_symlink ~/dotfiles/.tmux.conf ~/.tmux.conf
create_symlink ~/dotfiles/my-status-bar.tmux ~/my-status-bar.tmux
create_symlink ~/dotfiles/.gitignore ~/.gitignore
create_symlink ~/dotfiles/scripts ~/scripts
