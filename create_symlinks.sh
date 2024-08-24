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
