source ~/.import-secrets.sh
source ~/.zsh/aliases.sh
source ~/.zsh/exports.sh
source ~/.zsh/history.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    source ~/.zsh/homebrew.sh
fi

source ~/.zsh/utils.sh
source ~/.zsh/zinit.sh

source ~/.local-zshrc.sh

set -o vi

eval "$(fzf --zsh)"
bindkey -r "^t"

# compinit -C
