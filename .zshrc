source ~/.import-secrets.sh

set -o vi

 . ~/.asdf/plugins/java/set-java-home.zsh

 unset LIBRARY_PATH
 unset LDFLAGS

. /opt/homebrew/opt/asdf/libexec/asdf.sh

source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
#source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
 [ -s "/Users/dani/.bun/_bun" ] && source "/Users/dani/.bun/_bun"
source /opt/homebrew/opt/autojump/etc/autojump.sh
# source /opt/homebrew/opt/asdf/libexec/asdf.sh
 #source "$HOME/.cargo/env"

eval "$(fzf --zsh)"
bindkey -r "^t" # Unbind fzf keybinding
compinit -C

 # Update history
 HISTSIZE=100000             # Size of in-memory history (you can set this to a large number)
 SAVEHIST=1000000            # Size of history saved to file (set to the same or a large number)
 HISTFILE=~/.zsh_history     # Location of history file
 setopt APPEND_HISTORY       # Append to history file instead of overwriting
 setopt HIST_IGNORE_DUPS     # Ignore duplicate commands in history
 setopt HIST_IGNORE_ALL_DUPS # Remove all previous duplicate entries
 setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks in command

 if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
     print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
     command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
     command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
         print -P "%F{33} %F{34}Installation successful.%f%b" || \
         print -P "%F{160} The clone has failed.%f%b"
 fi

 source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
 autoload -Uz _zinit
 (( ${+_comps} )) && _comps[zinit]=_zinit

 zinit light-mode for \
     zdharma-continuum/zinit-annex-as-monitor \
     zdharma-continuum/zinit-annex-bin-gem-node \
     zdharma-continuum/zinit-annex-patch-dl \
     zdharma-continuum/zinit-annex-rust

 zinit ice pick"async.zsh" src"pure.zsh"
 zinit light sindresorhus/pure
