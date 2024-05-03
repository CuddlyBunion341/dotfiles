vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")

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
  { "sainnhe/sonokai",   priority = 9999 },
  { import = "plugins" },
  { import = "languages" },
}

local opts = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, opts)

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

vim.g.sonokai_better_performance = 1
vim.g.sonokai_style = "andromeda"
vim.cmd.colorscheme("sonokai")
