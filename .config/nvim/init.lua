vim.g.mapleader = " "
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "Q", ":quit<cr>")
vim.keymap.set("n", "<leader>q", ":quitall<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")
vim.api.nvim_set_keymap('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', '<C-k>', ':wincmd k<cr>', { silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<cr>', { silent = true })
vim.keymap.set('n', '<C-h>', ':wincmd h<cr>', { silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<cr>', { silent = true })
vim.keymap.set('n', '<C-e>', ':wincmd =<cr>', { silent = true })
vim.keymap.set('n', '<C-n>', ':wincmd s<cr>', { silent = true })
vim.keymap.set('n', '<C-m>', ':wincmd v<cr>', { silent = true })

vim.api.nvim_set_keymap('n', '@', '@q', {noremap = true})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = "plugins" }
}

local opts = { defaults = { lazy = true }, change_detection = { notify = false } }

require("lazy").setup(plugins, opts)
