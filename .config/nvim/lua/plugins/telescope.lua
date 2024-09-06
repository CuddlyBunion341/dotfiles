return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>" },
    { "<leader>w", "<cmd>Telescope live_grep<cr>" },
    { "<leader>r", "<cmd>Telescope resume<cr>" },
    { "<leader>c", "<cmd>Telescope git_commits<cr>" },
  }
}
