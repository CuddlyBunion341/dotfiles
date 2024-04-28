vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.number = true
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2


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
  { "sainnhe/sonokai", priority = 9999 },
  { "nvim-treesitter/nvim-treesitter" },
  "christoomey/vim-system-copy",
  {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope File" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Telescope Git File" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffer" },
        { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Telescope Grep" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Keymap" },
        { "<leader><leader>", "<cmd>Telescope commands<cr>", desc = "Telescope Command" },
      }
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 0
    end,
    opts = {}
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  "christoomey/vim-tmux-navigator",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
}

local opts = {
  defaults = {
    lazy = false
  }
}

require("lazy").setup(plugins, opts)

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

vim.g.sonokai_better_performance = 1
vim.g.sonokai_style = 'andromeda'
vim.cmd.colorscheme "sonokai"



