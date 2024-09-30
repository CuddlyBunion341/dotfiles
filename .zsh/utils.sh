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
