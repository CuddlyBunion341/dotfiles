return {
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
  }
}
