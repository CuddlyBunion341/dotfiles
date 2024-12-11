local lsp_servers = {
  "ts_ls",
  "lua_ls",
  "ruby_lsp",
  -- "rubocop",
  "standardrb"
}

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "VonHeikemen/lsp-zero.nvim",
    {
      "williamboman/mason.nvim",
      commands = { "Mason" },
      config = function()
        require("mason").setup()
      end
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = lsp_servers
        })
      end,
      keys = {
        { "<leader>li", "<cmd>LspInfo<cr>" },
        { "<leader>ll", "<cmd>LspLog<cr>" },
      }
    }
  },
  config = function()
    local status, err = pcall(function()
      require("lsp-zero").setup()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
            },
          },
        }
      })

      lspconfig["ruby_lsp"].setup({
        cmd = { "/Users/dani/.asdf/shims/ruby-lsp"},
        capabilities = capabilities
      })

      -- lspconfig["rubocop"].setup({
      --   capabilities = capabilities
      -- })

      lspconfig["rust_analyzer"].setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cachePriming = {
              enable = false
            }
          }
        }
      })

      lspconfig["jdtls"].setup({
        capabilities = capabilities,
        cmd = { "/opt/homebrew/bin/jdtls" },
        root_dir = lspconfig.util.root_pattern("pom.xml", "gradle.build", ".git"),
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, {})
    end)

    if not status then
      print("Error in LSP config: " .. err)
    end
  end
}
