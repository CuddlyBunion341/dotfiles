alias '~'='cd ~'
alias '..'='cd ..'
alias '...'='cd ../../'
alias '....'='cd ../../../'
alias '.....'='cd ../../../../'
alias '......'='cd ../../../../../'
alias ls="eza"
alias l="eza -lah"
alias lh="eza -lah | grep -E ' \.\w+$'" # [l]ist [h]idden
alias zshrc='nvim ~/.zshrc' # Idea from Chris
alias czsh='cd ~/.zsh && nvim .'
alias calacritty='nvim ~/.config/alacritty/alacritty.toml'
alias ckitty='nvim ~/.config/kitty/kitty.conf'
alias ctmux='nvim ~/.tmux.conf'
alias clazygit='nvim ~/Library/Application\ Support/lazygit/config.yml'
alias cneovide='nvim ~/.config/neovide/config.toml'
alias chypr='nvim ~/.config/hypr/hyprland.conf'
alias ff="fastfetch"
alias cnix="sudo nvim /etc/nixos/configuration.nix"
alias pkgsearch="nix search nixpkgs"
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
alias pubip="curl ifconfig.me"
alias bra="bundle exec rubocop -A" # [b]undle exec [r]ubocop -[A]
alias spec="be rspec"
alias f="fork ." 
alias cnvim="cd ~/.config/nvim && nvim init.lua" # [c]onfigure [nvim]
alias vimrc="nvim ~/.vimrc"
alias yabairc="v ~/.yabairc"
alias skhdrc="v ~/.config/skhd/skhdrc"
alias dbreset="bundle exec rails db:drop db:create db:schema:load db:seed" # [d]ata[b]ase [reset]
alias bsf="bundle exec standardrb --fix"
alias change_theme="~/.config/change_theme.sh > /dev/null"
alias cpb="git branch | grep '*' | tr -d '*' | tr -d ' ' | pbcopy" # [c]o[p]y [b]ranch to clipboard
alias tks="tmux kill-server" # [t]mux [k]ill [s]erver
alias crc="cargo r -r --bin client"
alias crs="cargo r -r --bin server"
alias fastfetch="cat ~/.config/fastfetch/logo.txt | fastfetch --file - --logo-color-1 magenta"
alias ff="fastfetch"
alias listfonts="fc-list | sed 's/.*:\s*\([^:]*\):.*/\1/' | tr ',' '\n' | sed 's/^[ \t]*//;s/[ \t]*$//' | sort | uniq" # https://stackoverflow.com/questions/57473124/how-to-find-all-available-fonts-on-osx-using-the-default-shell
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
alias bt="bin/test"
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
