#!/usr/bin/env bash
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

color1="#000000"
color2="green"

primary="#[fg=$color1,bg=$color2]"
secondary="#[fg=$color2,bg=$color1]"
tertiary="#[fg=orange,bg=$color1]"
background="#[fg=$color2,bg=$color1]"

title="#W:#I"
tmux_set status-fg "$color2"
tmux_set status-bg "$color1"
# tmux_set window-status-format "$secondary""$primary$title""$secondary"""
# tmux_set window-status-format "$secondary"" $primary$title""$secondary"""
tmux_set window-status-current-format "$secondary""$primary $title ""$secondary"""
tmux_set window-status-format "  $title  "
tmux_set window-status-separator " "
#   
# Window status style
# tmux_set window-status-style "fg=$tertiary,bg=$primary,none"
# tmux_set window-status-last-style "fg=$tertiary,bg=$primary,bold"
# tmux_set window-status-activity-style "fg=$tertiary,bg=$primary,bold"
