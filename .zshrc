source ~/.import-secrets.sh
source ~/.zsh/aliases.sh
source ~/.zsh/exports.sh
source ~/.zsh/history.sh
source ~/.zsh/homebrew.sh
source ~/.zsh/utils.sh
source ~/.zsh/zinit.sh

set -o vi

eval "$(fzf --zsh)"
bindkey -r "^t" # Unbind fzf keybinding
compinit -C

