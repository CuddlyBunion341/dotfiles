#!/usr/bin/env bash

ALACRITTY_DARK_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Campbell.toml"
ALACRITTY_LIGHT_THEME="/Users/dani/.asdf/installs/nodejs/18.14.2/lib/node_modules/alacritty-themes/themes/Solarized-Light.toml"
ALACRITTY_CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"

# Check if ALACRITTY_CONFIG_FILE exists
if [ ! -f "$ALACRITTY_CONFIG_FILE" ]; then
    echo "File not found: $ALACRITTY_CONFIG_FILE"
    exit 1
fi

NVIM_THEME_FILE="$HOME/.config/nvim/lua/theme.lua"
NVIM_LIGHT_THEME='solarized'
NVIM_DARK_THEME='tokyodark'

# Check if NVIM_THEME_FILE exists
if [ ! -f "$NVIM_THEME_FILE" ]; then
    echo "File not found: $NVIM_THEME_FILE"
    exit 1
fi

NVIM_SERVERS=$(nvr --serverlist)

if grep -q "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_CONFIG_FILE"; then
    # switch to dark theme
    sed -i '' "s|$ALACRITTY_LIGHT_THEME|$ALACRITTY_DARK_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i '' "s|local USE_DARKMODE = false|local USE_DARKMODE = true|g" "$NVIM_THEME_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_DARK_THEME<CR>:set background=dark<CR>"
    done
    echo "Changed to dark theme"
else
    # switch to light theme
    sed -i '' "s|$ALACRITTY_DARK_THEME|$ALACRITTY_LIGHT_THEME|g" "$ALACRITTY_CONFIG_FILE"
    sed -i '' "s|local USE_DARKMODE = true|local USE_DARKMODE = false|g" "$NVIM_THEME_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_LIGHT_THEME<CR>:set background=light<CR>"
    done
    echo "Changed to light theme"
fi
