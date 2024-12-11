source ~/.import-secrets.sh
source ~/.zsh/aliases.sh
source ~/.zsh/exports.sh
source ~/.zsh/history.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    source ~/.zsh/homebrew.sh
fi

source ~/.zsh/utils.sh
source ~/.zsh/zinit.sh

set -o vi

eval "$(fzf --zsh)"
bindkey -r "^t"

compinit -C

# test -e "${HOME}/.iterm2_shell_integration.zh" && source "${HOME}/.iterm2_shell_integration.zsh"

