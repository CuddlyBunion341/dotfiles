return {
  { "tpope/vim-rails" },
  { "namadnuno/neoi18n" },
  {
    "airblade/vim-localorie",
  },
  {
    "valen20Chx/nvim-i18n-tools",
    config = function()
      require("nvim-i18n-tools").setup()
    end,
  },
  {
    "weizheheng/ror.nvim",
    config = function()
      require("ror").setup()
      vim.keymap.set("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
      -- vim.keymap.sot("n", "<Leader>fv", ":lua require('ror.commands').find_view()<CR>", { silent = true })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        solargraph = {
          settings = {
            solargraph = {
              autoformat = false,
              -- bundlerPath = "bundle",
              diagnostics = true,
              completion = true,
              formatting = false,
              definitions = true,
            },
          },
        },
      },
    },
  },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = true,
    setup = function()
      -- Requires nvim-treesitter installed
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
  { "tpope/vim-bundler" },
  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup({
        mappings = {
          -- builtin mappings
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
          -- custom mapping
          {
            pattern = "/app/.+(.*)_controller.rb",
            target = "/spec/request/%1_spec.rb",
            transformer = "lowercase",
          },
        },
        transformers = {
          -- defining a custom transformer
          lowercase = function(inputString)
            return inputString:lower()
          end,
        },
        style = {
          -- How the plugin paints its window borders
          -- Allowed values are none, single, double, rounded, solid and shadow
          border = "solid",

          -- Column seperator for the window
          seperator = "|",

          -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
          width = 0.7,

          -- min height in rows.
          -- when more columns are needed this value is extended automatically
          minHeight = 2,
        },
      })

      vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })

      -- Context specific bindings
      vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true })
    end,
  },
  {
    {
      "nvim-neotest/neotest",
      dependencies = {
        "haydenmeade/neotest-jest",
        "marilari88/neotest-vitest",
        "olimorris/neotest-rspec",
      },
      keys = {
        {
          "<leader>tl",
          function()
            require("neotest").run.run_last()
          end,
          desc = "Run Last Test",
        },
        {
          "<leader>tL",
          function()
            require("neotest").run.run_last({ strategy = "dap" })
          end,
          desc = "Debug Last Test",
        },
        {
          "<leader>tw",
          "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
          desc = "Run Watch",
        },
      },
      opts = function(_, opts)
        table.insert(
          opts.adapters,
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          })
        )
        table.insert(opts.adapters, require("neotest-vitest"))

        table.insert(
          opts.adapters,
          require("neotest-rspec")({
            -- jestCommand = "npm test --",
            -- jestConfigFile = "custom.jest.config.ts",
            -- env = { CI = true },
            -- cwd = function()
            -- return vim.fn.getcwd()
            -- end,
          })
        )
        table.insert(opts.adapters, require("neotest-rspec"))
      end,
    },
  },
}
