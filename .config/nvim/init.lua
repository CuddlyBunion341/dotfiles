vim.opt.title = true
vim.opt.titlelen = 0
-- vim.opt.titlestring = 'nvim %{expand("%:p")}'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.cmdheight = 1

vim.api.nvim_set_keymap('n', '@', '@q', {noremap = true})

vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>")
vim.keymap.set("n", "<leader>q!", "<cmd>qa!<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<a-j>", "5jzz")
vim.keymap.set("n", "<a-k>", "5kzz")

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"
vim.opt.wildignore = {
  "*.docx",
  "*.jpg",
  "*.png",
  "*.gif",
  "*.pdf",
  "*.pyc",
  "*.exe",
  "*.flv",
  "*.img",
  "*.xlsx",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


local plugins = {
  -- { "sainnhe/sonokai",                   lazy = true, priority = 1000 },
  -- { "iruzo/matrix-nvim",                 lazy = true, priority = 1000 },
  -- { "nyoom-engineering/nyoom.nvim",      lazy = true, priority = 1000 },
  -- { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  -- { "ray-x/aurora",                      lazy = true, priority = 1000 },
  -- { "shaunsingh/solarized.nvim",         lazy = false, priority = 1000 },
  { "ishan9299/nvim-solarized-lua", name = "moonfly", lazy = false, priority = 1000 },
  { "bluz71/vim-moonfly-colors",                      lazy = false, priority = 1000 },
  { import = "plugins" },
  { import = "languages" },
}

local opts = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, opts)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

vim.cmd.colorscheme("solarized")
vim.opt.background = "light"

-- vim.api.nvim_command('autocmd VimEnter * lua require("persistence").load()')
