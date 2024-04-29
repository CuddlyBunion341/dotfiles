return {
    {
    "ThePrimeagen/refactoring.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({})
    end,
    keys = {
      { "<leader>rr", function() require('refactoring').select_refactor() end, desc = "Refactor" }
    }
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    keys = {
      { "<leader>m", "<cmd>Mason<cr>" }
    },
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer" },
      }
    end
  },
  {
    "nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
    end,
    keys = {
      { "K", function() vim.lsp.buf.hover() end }
    }
  }
}
