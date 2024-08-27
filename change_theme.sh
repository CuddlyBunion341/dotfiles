#!/usr/bin/env bash

ALACRITTY_DARK_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Campbell.toml"
ALACRITTY_LIGHT_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Solarized-Light.toml"
ALACRITTY_CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"

NVIM_CONFIG_FILE="$HOME/.config/nvim/init.lua"
NVIM_LIGHT_THEME='vim.cmd.colorscheme("solarized")'
NVIM_DARK_THEME='vim.cmd.colorscheme("elflord")'
NVIM_DARK_BACKGROUND='vim.opt.background = "dark"'
NVIM_LIGHT_BACKGROUND='vim.opt.background = "light"'
NVIM_LIGHT_CMD=':colorscheme solarized | set background=light'
NVIM_DARK_CMD=':colorscheme blue | set background=dark'
NVIM_SERVERS=$(nvr --serverlist)

# Check if ALACRITTY_CONFIG_FILE exists
if [ ! -f "$ALACRITTY_CONFIG_FILE" ]; then
    echo "File not found: $ALACRITTY_CONFIG_FILE"
    exit 1
fi

if grep -q "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_CONFIG_FILE"; then
    sed -i "s|$ALACRITTY_LIGHT_THEME|$ALACRITTY_DARK_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i "s|$NVIM_LIGHT_THEME|$NVIM_DARK_THEME|g" "$NVIM_CONFIG_FILE"
    sed -i "s|$NVIM_LIGHT_BACKGROUND|$NVIM_DARK_BACKGROUND|g" "$NVIM_CONFIG_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme elflord<CR>:set background=dark<CR>"
    done
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep vim | cut -d ' ' -f 1 | xargs -I PANE tmux send-keys -t PANE ESCAPE "$NVIM_LIGHT_CMD" ENTER
    echo "Changed to dark theme"
else
    sed -i "s|$ALACRITTY_DARK_THEME|$ALACRITTY_LIGHT_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i "s|$NVIM_DARK_THEME|$NVIM_LIGHT_THEME|g" "$NVIM_CONFIG_FILE"
    sed -i "s|$NVIM_DARK_BACKGROUND|$NVIM_LIGHT_BACKGROUND|g" "$NVIM_CONFIG_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme solarized<CR>:set background=light<CR>"
    done
    echo "Changed to light theme"
fi
