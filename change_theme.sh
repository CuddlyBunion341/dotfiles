#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_COMMAND='sed -i ""'
else
    SED_COMMAND='sed -i'
fi

replace() {
    $SED_COMMAND "s|$1|$2|g" "$3"
}

ALACRITTY_LIGHT_THEME="solarized_light"
ALACRITTY_DARK_THEME="tokyonight"
ALACRITTY_CONFIG_FILE="$HOME/.config/alacritty/current-theme.toml"

if [ ! -f "$ALACRITTY_CONFIG_FILE" ]; then
    echo "File not found: $ALACRITTY_CONFIG_FILE"
    exit 1
fi

NVIM_THEME_FILE="$HOME/.config/nvim/lua/theme.lua"
NVIM_LIGHT_THEME='solarized'
NVIM_DARK_THEME='tokyodark'

if [ ! -f "$NVIM_THEME_FILE" ]; then
    echo "File not found: $NVIM_THEME_FILE"
    exit 1
fi

NVIM_SERVERS=$(nvr --serverlist)

if grep -q "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_CONFIG_FILE"; then
    # switch to dark theme
    replace "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_DARK_THEME" "$ALACRITTY_CONFIG_FILE"
    replace "local USE_DARKMODE = false" "local USE_DARKMODE = true" "$NVIM_THEME_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_DARK_THEME<CR>:set background=dark<CR>"
    done
    echo "Changed to dark theme"
else
    # switch to light theme
    replace "$ALACRITTY_DARK_THEME" "$ALACRITTY_LIGHT_THEME" "$ALACRITTY_CONFIG_FILE"
    replace "local USE_DARKMODE = true" "local USE_DARKMODE = false" "$NVIM_THEME_FILE"
    for server in $NVIM_SERVERS; do
        nvr --servername $server --remote-send ":colorscheme $NVIM_LIGHT_THEME<CR>:set background=light<CR>"
    done
    echo "Changed to light theme"
fi
