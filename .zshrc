export ZSH="$HOME/.oh-my-zsh"

set -o vi

 # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
 ZSH_THEME="robbyrussell"

 plugins=(
   rails
   ruby
   bundler
   fzf
   git
   brew
   bun
   you-should-use
   zsh-vi-mode
   zsh-autocomplete
   zsh-autosuggestions
   zsh-syntax-highlighting
   fast-syntax-highlighting
   rust
 )

 source $HOME/.import-secrets.sh
 source $ZSH/oh-my-zsh.sh
 source $HOME/.cargo/env
 source "$HOME/.cargo/env"

 unalias sd

 DISABLE_AUTO_TITLE="true"

 export LANG=en_US.UTF-8
 export EDITOR=nvim
 export THOR_MERGE="nvim -d $2 $1"
 export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

 [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
 tere() {
   local result=$(command tere "$@")
   [ -n "$result" ] && cd -- "$result"
 }

 export BUN_INSTALL="$HOME/.bun"
 export PATH="$BUN_INSTALL/bin:$PATH"
 export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
 export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
 export LDFLAGS="-L/opt/homebrew/opt/mysql@8.4/lib"
 export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.4/include"
 export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql@8.4/lib/pkgconfig"

 # Created by `pipx` on 2024-12-12 09:25:29
 export PATH="$PATH:/Users/dani/.local/bin"

 alias v="nvim"
 alias go='~/scripts/open-repo-in-browser.ts'

 alias myip="ipconfig getifaddr en0"
 alias pubip="curl ifconfig.me"
 alias gg="lazygit"
 alias bra="bundle exec rubocop -A"
 alias bsf="bundle exec standardrb --fix"
 alias ctags="`brew --prefix`/bin/ctags"
 alias o="open"

 # config
 alias cnvim="cd ~/.config/nvim && $EDITOR init.lua"
 alias vimrc="$EDITOR ~/.vimrc"
 alias zshrc="$EDITOR ~/.zshrc"
 alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
 alias clg="$EDITOR ~/Library/Application\ Support/lazygit/config.yml"
 alias cgit="$EDITOR ~/.gitconfig"


 set_terminal_title() {
   git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
   repo_name=$(basename "$(git rev-parse --show-toplevel 2> /dev/null)")
   echo -ne "\e]1;${repo_name} - ${git_branch}\a"
 }
 export PROMPT_COMMAND="$PROMPT_COMMAND; set_terminal_title"
 precmd() { set_terminal_title }


 alias y='yazi'

 alias jr='javac -d bin src/**/*.java; java -cp bin ch.zhaw.prog1.farm.Farm'
 alias gs='git status'
 jsf() {
   find . -name "*.java" | fzf --preview 'echo {}' | xargs java
 }

 alias fg='ls -1 | rg'
 alias bc='bin/check'
 alias bd='bin/dev'
