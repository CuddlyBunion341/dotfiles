return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 0.8
  end
}
