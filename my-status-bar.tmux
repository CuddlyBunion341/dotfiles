!/usr/bin/env bash
#===============================================================================
#   Author: CuddlyBunion341
#  Created: 2024-04-13 22:25
#===============================================================================

tmux_get() {
	local value="$(tmux show -gqv "$1")"
	[ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
	tmux set-option -gq "$1" "$2"
}

#color1="#fcf6e5"
color1="black"
# color1="#fdf6e3"
# color1="#000000"
color2="white"
color3="white"
color4="white"

secondary="#[fg=$color2,bg=$color1]"
tertiary="#[fg=black,bg=$color1]"
primary="#[fg=$color1,bg=$color2]"
background="#[fg=$color2,bg=$color1]"

title="#W:#I"
# tmux_set status-fg "$colork"
# tmux_set status-bg "$color1"
tmux_set status-bg "$color1"
tmux_set status-fg "$color4"
# tmux_set window-status-current-format "#[underscore]$title"
# tmux_set window-status-format "$title"
# tmux_set window-status-separator " | "

tmux_set window-status-format "#[bg=$color1] $title "
tmux_set window-status-current-format "#[bg=$color4,fg=$color1] $title "
tmux_set window-status-separator " "

# tmux_set window-status-current-format "#[bg=$color1,fg=$color2]#[bg=$color2,fg=$color3] $title #[bg=$color1,fg=$color2]"
# tmux_set window-status-separator ""
# tmux_set window-status-format "#[bg=$color1,fg=$color3]#[bg=$color3,fg=$color2] $title #[bg=$color1,fg=$color3]"

#   
cmd="#[fg=black]#{pane_current_command}"
path="#(echo #{pane_current_path} | sed 's#$HOME#~#g')"
ruby_version=$(ruby -v | awk '{print $2}')
ruby="#[fg=red] $ruby_version"

# tmux_set status-left " #H [#S] "
tmux_set status-left "#[bg=green,fg=black][#S]#[bg=default] "
# tmux_set status-right "#{prefix_highlight} $cmd $path $ruby"
tmux_set status-right "#{prefix_highlight} $cmd $path"
# Window status style
# tmux_set window-status-style "fg=$tertiary,bg=$primary,none"
# tmux_set window-status-last-style "fg=$tertiary,bg=$primary,bold"
# tmux_set window-status-activity-style "fg=$tertiary,bg=$primary,bold"
tmux_set status-right-length 200
tmux_set status-left-length 200
