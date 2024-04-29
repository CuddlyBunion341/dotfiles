return {
  { "tpope/vim-rails", event = "VeryLazy" },
  {
    "sato-s/telescope-rails.nvim",
    dependencies = {"nvim-telescope/telescope.nvim"},
    keys = {
      { "<leader>rs", "<cmd>Telescope rails specs<cr>", desc = "Telescope rails specs" },
      { "<leader>rc", "<cmd>Telescope rails controllers<cr>", desc = "Telescope rails controllers" },
      { "<leader>rm", "<cmd>Telescope rails models<cr>", desc = "Telescope rails models" },
      { "<leader>rv", "<cmd>Telescope rails views<cr>", desc = "Telescope rails views" },
      { "<leader>ri", "<cmd>Telescope rails migrations<cr>", desc = "Telescope rails migrations" },
      { "<leader>rl", "<cmd>Telescope rails libs<cr>", desc = "Telescope rails libs" },
    }
  }
}
