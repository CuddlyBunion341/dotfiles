return {
  {
    "nvim-neotest/neotest",
    modules = { "neotest" },
    events = { "InsertEnter" },
    cmd = { "Neotest" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "zidhuss/neotest-minitest"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-minitest"),
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end,
          }),
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop" },
    },
  },
}
