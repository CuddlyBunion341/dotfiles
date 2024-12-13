return {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = { },
  keys = {
    { "<C-x>", "<cmd>SessionDelete<cr>" }
  }
}
