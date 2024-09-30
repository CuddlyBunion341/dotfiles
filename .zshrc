source ~/.import-secrets.sh

export EDITOR=nvim
export BETTER_ERRORS_EDITOR=nvim
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
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

 # eval "$(fzf --zsh)"
 # bindkey -r "^t" # Unbind fzf keybinding

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
   print -S "bundle exec rspec $file"
   bundle exec rspec $file
 } # [r]spec [s]earch [f]ile
 function jsf() { 
   file=$(find ./**/*.java | fzf --preview 'bat --color "always" {}')
   echo "java $file"
   print -S "java $file"
   java $file
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

      
 function rr() { rustc "$@.rs" && ./"$@"} # [r]ust [r]un
 function rgs() { rg --json -C 2 "$@" | delta } # [r]ip[g]rep [s]earch

                                      function rkill() { "kill $(cat tmp/pids/server.pid)" }

 #                # IDEA: gsf TICKET NAME => git checkout -b feature/TICKET-NAME + check if user on develop
 # IDEA: grd => git pull origin develop && fork . => rebase

                         
 # compinit -C

 # Update history
 HISTSIZE=100000             # Size of in-memory history (you can set this to a large number)
 SAVEHIST=1000000            # Size of history saved to file (set to the same or a large number)
 HISTFILE=~/.zsh_history     # Location of history file
 setopt APPEND_HISTORY       # Append to history file instead of overwriting
 setopt HIST_IGNORE_DUPS     # Ignore duplicate commands in history
 setopt HIST_IGNORE_ALL_DUPS # Remove all previous duplicate entries
 setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks in command

 # Added by Zinit's installer
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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
