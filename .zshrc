source ~/.import-secrets.sh

set -o vi

if [ "$TERM_PROGRAM" = "WarpTerminal" ] && [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]; then
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh"}}\x9c'
fi

PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.asdf/installs/ruby/latest/bin:$PATH"
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="~/renuo/personal/rails-generator/bin:$PATH"
export PATH="~/.asdf/shims/:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=~/dev/flutter/bin:$PATH
export PATH="/Users/dani/.gem/:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # fix libcurl error
export EDITOR="nvim"
unset LIBRARY_PATH
unset LDFLAGS

source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

[ -s "/Users/dani/.bun/_bun" ] && source "/Users/dani/.bun/_bun"
source /opt/homebrew/opt/autojump/etc/autojump.sh
source "$HOME/.cargo/env"
source /opt/homebrew/opt/asdf/libexec/asdf.sh

eval "$(fzf --zsh)"
bindkey -r "^t" # Unbind fzf keybinding

eval "$(tmuxifier init -)"

alias ls="eza"
alias l="eza -lah"
alias lh="eza -lah | grep -E ' \.\w+$'" # [l]ist [h]idden
function go() { ~/scripts/open-repo-in-browser.ts }
function gtable() { ~/scripts/git-smart-log.ts $@ }
function gitcopy() { ~/scripts/copy_remote_to_clipboard.sh }
function cscript() { ~/scripts/create_executable_script.sh }
function timelog() { ~/scripts/index.ts }
function openticket() { ~/scripts/open-ticket-in-browser.ts }
function ot() { ~/scripts/open-ticket-in-browser.ts }
function prt() { ~/scripts/get-pr-template.ts }
function cpt() { ~/scripts/copy-ticket-number.ts }
function rsf() { 
  file=$(find spec/**/*_spec.rb | fzf --preview 'bat --color "always" {}')
  echo "bundle exec rspec $file"
  print -S "$file"
  bundle exec rspec $file
} # [r]spec [s]earch [f]ile
function vg() { nvim $(fzf) } # [v]im [g]rep
function prokill() {
  port=$1
  process=$(lsof -i :$port | fzf | awk '{print $2}')
  kill $process
} # [k]ill [p]rocess

function cached_routes() {
  if ( [ ! -f config/routes.rb ]); then
    echo "No routes file found"
    return "Empty"
  fi


  if ( [ ! -f tmp/cache/routes-$(md5 -q config/routes.rb).txt ] ); then
    bundle exec rails routes > tmp/cache/routes-$(md5 -q config/routes.rb).txt
  fi

  cat tmp/cache/routes-$(md5 -q config/routes.rb).txt
}

reimport_abbr() {
  rm -rf $ABBR_TMPDIR
  rm $ABBR_USER_ABBREVIATIONS_FILE
  abbr import-aliases
}

backup_directory() {
  if [ -z "$1" ]; then
    echo "Please provide a directory to backup"
    return
  fi

  directory_name_with_timestamp_suffix=$1-$(date +%Y-%m-%d:%H:%M:%S)
  cp -r "$1" "$directory_name_with_timestamp_suffix"
  printf "Backup created at $directory_name_with_timestamp_suffix"
}

parallel_exec() {
  # Example usage:
  # parallel_exec "sleep 1" "echo 'Hello, World!'" "ls -l"

  trap 'kill $(jobs -p)' SIGINT SIGTERM # Kill child processes on interrupt or termination
  for cmd in "$@"; do
    eval "$cmd" &
  done
  wait
}

alias '~'='cd ~'
alias '..'='cd ..'
alias '...'='cd ../../'

function rr() { rustc "$@.rs" && ./"$@"} # [r]ust [r]un
function rgs() { rg --json -C 2 "$@" | delta } # [r]ip[g]rep [s]earch

alias zshrc='nvim ~/.zshrc' # Idea from Chris
alias calacritty='nvim ~/.config/alacritty/alacritty.toml'
alias ctmux='nvim ~/.tmux.conf'
alias clazygit='nvim ~/Library/Application\ Support/lazygit/config.yml'
alias cneovide='nvim ~/.config/neovide/config.toml'
alias chypr='nvim ~/.config/hypr/hyprland.conf'
alias cnix="sudo nvim /etc/nixos/configuration.nix"
alias nxs="sudo nixos-rebuild switch"
alias nv='neovide'
alias cgit='nvim ~/.gitconfig'
alias kts='tmux kill-server' # [k]ill [t]mux [s]erver
alias v='nvim'
alias cpp='pbcopy'
alias bo='tectonic -X build && open build/default/default.pdf' # [b]uild and [o]pen
alias bno='tectonic -X build' # [b]uild and do[n]'t [o]pen
alias g="grep" # [g]rep
alias myip="ipconfig getifaddr en0"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com -4" # borrowed from raphi
alias bra="bundle exec rubocop -A" # [b]undle exec [r]ubocop -[A]
alias spec="be rspec"
alias f="fork ." 
alias cnvim="cd ~/.config/nvim && nvim init.lua" # [c]onfigure [nvim]
alias yabairc="v ~/.yabairc"
alias skhdrc="v ~/.config/skhd/skhdrc"
alias dbreset="bundle exec rails db:drop db:create db:schema:load db:seed" # [d]ata[b]ase [reset]
alias change_theme="~/.config/change_theme.sh > /dev/null"
alias cpb="git branch | grep '*' | tr -d '*' | tr -d ' ' | pbcopy" # [c]o[p]y [b]ranch to clipboard
alias tks="tmux kill-server" # [t]mux [k]ill [s]erver
alias crc="cargo r -r --bin client"
alias crs="cargo r -r --bin server"
function rkill() { "kill $(cat tmp/pids/server.pid)" }

#alias glog="git log --oneline | grep -v -e '^\s*$' --color=always | less --use-color" # [g]it [log]
alias glog="git log --oneline"
alias glag="glog_ --all --since='00:00' --until='NOW' | grep -v -e '^\s*$' --color=always" # [g]it [l]og [a]ll [g]rep
alias gb="if ( git branch | grep '* develop' ); then; git checkout -b ; else; echo 'You can only start a new feature from the development branch' ;fi;" # [g]it [b]ranch
alias gs="git status" # [g]it [s]tatus
alias gso="git show" # [g]it [s]how
alias gp="git push" # [g]it [p]ush
alias gpp="git pull && git push" # [g]it [p]ull and [p]ush
alias gpl="git pull" # [g]it [p]u[l]l
alias gc="git commit" # [g]it [c]ommit
alias ga="git add" # [g]it [a]dd
alias gac="git add . && git commit" # [g]it [a]dd and [c]ommit
alias lg="lazygit" # [l]azy[g]it
alias gcl="git clone" # [g]it [cl]one
alias gss="git stash" # [g]it [s]tash [s]ave
alias cl="clear" # [cl]ear
# IDEA: gsf TICKET NAME => git checkout -b feature/TICKET-NAME + check if user on develop
# IDEA: grd => git pull origin develop && fork . => rebase

alias python="python3"
alias o="open"
alias q="exit"
alias be="bundle exec"
alias qlf='qlmanage -p "$@"'
alias mine='rubymine .'
alias m='rubymine .'
alias bs="bin/setup"
alias bc="bin/check"
alias br="bin/run"
alias bd="bin/dev"
alias yd="yarn dev"
alias yt="yarn test"
alias brc="be rspec --format doc" # [b]undle [e]xec run [c]hecks
alias nvimc="cd ~/.config/nvim && nvim ."
alias gcf="git checkout -b feature/"
alias rr="rails routes | rg"
alias c="code"
alias bat="bat --style plain --theme OneHalfDark"
alias cat="bat"
alias gdu="git diff @{upstream}"
alias spf="~/bin/spf"
alias clines="find . -type f -name '*.txt' -exec wc -l {} +"

alias gch="git checkout"

alias gcf="git checkout -b feature/"

compinit -C

# BEGIN zsh-sticky-prompt
ZLE_STICKY_PROMPT_LEFT=""
ZLE_STICKY_PROMPT_RIGHT=""

sticky-prompt-zle-line-init() {
  LBUFFER="$ZLE_STICKY_PROMPT_LEFT"
  RBUFFER="$ZLE_STICKY_PROMPT_RIGHT"
  zle _zle-line-init
}

sticky-prompt-set() {
  if [[ -z "$BUFFER" ]]; then
    if [[ -z "$ZLE_STICKY_PROMPT_LEFT" ]]; then
      zle -M "No sticky prompt set."
    else
      ZLE_STICKY_PROMPT_LEFT=""
      ZLE_STICKY_PROMPT_RIGHT=""
      zle -M "Removed sticky prompt."
    fi
    return
  fi

  local ZLE_STICKY_PROMPT_PREV_LEFT="$ZLE_STICKY_PROMPT_LEFT"
  local ZLE_STICKY_PROMPT_PREV_RIGHT="$ZLE_STICKY_PROMPT_RIGHT"
  ZLE_STICKY_PROMPT_LEFT="$LBUFFER"
  ZLE_STICKY_PROMPT_RIGHT="$RBUFFER"

  if { [[ -n "$ZLE_STICKY_PROMPT_LEFT" ]] && [[ "$ZLE_STICKY_PROMPT_PREV_LEFT" != "$ZLE_STICKY_PROMPT_LEFT" ]]; } ||
        { [[ -n "$ZLE_STICKY_PROMPT_RIGHT" ]] && [[ "$ZLE_STICKY_PROMPT_PREV_RIGHT" != "$ZLE_STICKY_PROMPT_RIGHT" ]]; }; then
    zle -M "Sticky prompt $ZLE_STICKY_PROMPT_LEFT|$ZLE_STICKY_PROMPT_RIGHT"
  else
    ZLE_STICKY_PROMPT_LEFT=""
    ZLE_STICKY_PROMPT_RIGHT=""
    BUFFER=""
    zle -M "Removed sticky prompt."
  fi
}

sticky-prompt-accept-line() {
    if [[ -z "$BUFFER" ]] && [[ -n "$ZLE_STICKY_PROMPT_LEFT" ]]; then
      ZLE_STICKY_PROMPT_LEFT=""
      ZLE_STICKY_PROMPT_RIGHT=""
      zle -M "Removed sticky prompt."
    fi
    zle .accept-line
}

functions[_zle-line-init]="${functions[zle-line-init]}"
zle -N _zle-line-init
zle -N zle-line-init sticky-prompt-zle-line-init
zle -N sticky-prompt-set
zle -N accept-line sticky-prompt-accept-line
bindkey '^F' sticky-prompt-set

# END zsh-sticky-prompt

### Added by Zinit's installer
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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

PATH=~/.console-ninja/.bin:$PATH

renuo-cli() {
  initial_directory=$(pwd)
  cd ~/renuo-cli
  trap "cd $initial_directory" EXIT
  ruby -Ilib ./bin/renuo "$@"
}

renuo-cli-hack() {
  local current_ruby_version=$(asdf current ruby | awk '{print $2}')

  local tool_versions_exists=false
  [ -f .tool-versions ] && tool_versions_exists=true

  local ruby_in_tool_versions=false
  grep -q "ruby" .tool-versions && ruby_in_tool_versions=true

  asdf local ruby 3.2.3
  renuo "$@"

  if ! $tool_versions_exists; then
    rm .tool-versions
  elif ! $ruby_in_tool_versions; then
    sed -i '' '/ruby/d' .tool-versions
  else
    asdf local ruby $current_ruby_version
  fi
}

