vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.5

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "Lokaltog/vim-distinguished" },
  {
    "LazyVim/LazyVim",
    opts = {
      transparent = true,
      colorscheme = "tokyonight",
    },
  },
  {
    "wk13eagle/telescope.nvim",
    opts = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },
}
