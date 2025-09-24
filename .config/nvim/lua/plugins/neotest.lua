return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    "zidhuss/neotest-minitest",
    "rcasia/neotest-java",
    "mfussenegger/nvim-jdtls",
    "adrigzr/neotest-mocha",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-minitest"),
        require("neotest-mocha")({
          command = "bunx mocha --",
          command_args = function(context)
            -- The context contains:
            --   results_path: The file that json results are written to
            --   test_name_pattern: The generated pattern for the test
            --   path: The path to the test file
            --
            -- It should return a string array of arguments
            --
            -- Not specifying 'command_args' will use the defaults below
            local relative_path = vim.fn.fnamemodify(context.path, ":.")
            return {
              "--full-trace",
              "--reporter=json",
              "--reporter-options=output=" .. context.results_path,
              "--grep=" .. context.test_name_pattern,
              relative_path,
            }
          end,
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-rspec")({
          rspec_cmd = function()
            return { "mise", "exec", "--", "bundle", "exec", "rspec" }
          end,
        }),
        require("neotest-java")({
          ignore_wrapper = true,
        }),
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>Neotest run file<cr>", desc = "Test file" },
    { "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run closest test" },
    { "<leader>to", "<cmd>Neotest output<cr>", desc = "Test output" },
    { "<leader>tO", "<cmd>Neotest output-panel<cr>", desc = "Test output panel" },
    { "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop test" },
  },
}
