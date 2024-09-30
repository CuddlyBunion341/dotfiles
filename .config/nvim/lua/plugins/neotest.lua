return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")
      }
    })
  end,
  keys = {
    { "<leader>tr", "<cmd>Neotest run<cr>" },
    { "<leader>to", "<cmd>Neotest output<cr>" },
    { "<leader>ts", "<cmd>Neotest stop<cr>" },
  }
}
