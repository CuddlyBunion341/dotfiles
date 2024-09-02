#!/usr/bin/env bash

ALACRITTY_DARK_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Campbell.toml"
ALACRITTY_LIGHT_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Solarized-Light.toml"
ALACRITTY_CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"

# Check if ALACRITTY_CONFIG_FILE exists
if [ ! -f "$ALACRITTY_CONFIG_FILE" ]; then
    echo "File not found: $ALACRITTY_CONFIG_FILE"
    exit 1
fi

NVIM_CONFIG_FILE="$HOME/.config/nvim/init.lua"
NVIM_LIGHT_THEME='solarized'
NVIM_DARK_THEME='moonfly'

NVIM_LIGHT_THEME_CONFIG="vim.cmd.colorscheme(\"$NVIM_LIGHT_THEME\")"
NVIM_DARK_THEME_CONFIG="vim.cmd.colorscheme(\"$NVIM_DARK_THEME\")"
NVIM_LIGHT_BACKGROUND_CONFIG='vim.opt.background = "light"'
NVIM_DARK_BACKGROUND_CONFIG='vim.opt.background = "dark"'

NVIM_SERVERS=$(nvr --serverlist)

if grep -q "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_CONFIG_FILE"; then
    # switch to dark theme
    sed -i "s|$ALACRITTY_LIGHT_THEME|$ALACRITTY_DARK_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i "s|$NVIM_LIGHT_BACKGROUND_CONFIG|$NVIM_DARK_BACKGROUND_CONFIG|g" "$NVIM_CONFIG_FILE"
    sed -i "s|$NVIM_LIGHT_THEME_CONFIG|$NVIM_DARK_THEME_CONFIG|g" "$NVIM_CONFIG_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_DARK_THEME<CR>:set background=dark<CR>"
    done
    echo "Changed to dark theme"
else
    # switch to light theme
    sed -i "s|$ALACRITTY_DARK_THEME|$ALACRITTY_LIGHT_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i "s|$NVIM_DARK_THEME_CONFIG|$NVIM_LIGHT_THEME_CONFIG|g" "$NVIM_CONFIG_FILE"
    sed -i "s|$NVIM_DARK_BACKGROUND_CONFIG|$NVIM_LIGHT_BACKGROUND_CONFIG|g" "$NVIM_CONFIG_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_LIGHT_THEME<CR>:set background=light<CR>"
    done
    echo "Changed to light theme"
fi
