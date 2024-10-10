return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    "rcasia/neotest-java",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
        ["neotest-java"] = {
          ignore_wrapper = true
        }
      }
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>Neotest run file<cr>" },
    { "<leader>tr", "<cmd>Neotest run<cr>" },
    { "<leader>to", "<cmd>Neotest output<cr>" },
    { "<leader>tO", "<cmd>Neotest output-panel<cr>" },
    { "<leader>ts", "<cmd>Neotest stop<cr>" },
  }
}
