return {
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    {
      "pwntester/octo.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        -- OR 'ibhagwan/fzf-lua',
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("octo").setup()
      end,
    },
  },
  {
    "junkblocker/git-time-lapse",
    config = function()
      vim.keymap.set("n", "<Leader>gt", "<Plug>(git-time-lapse)", { noremap = false })
    end,
  },
}
