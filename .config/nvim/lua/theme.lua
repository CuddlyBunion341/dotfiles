if vim.o.background == "dark" then
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_transparent_background = 1
    vim.g.tokyonight_enable_italic = 1
    vim.cmd("colorscheme tokyonight")
    vim.cmd("set bg=dark")
else
    vim.o.background = "light"
    -- vim.cmd("colorscheme solarized")
    -- vim.cmd("colorscheme wildcharm")
    vim.cmd("colorscheme polar")
    vim.cmd("set bg=light")
end
