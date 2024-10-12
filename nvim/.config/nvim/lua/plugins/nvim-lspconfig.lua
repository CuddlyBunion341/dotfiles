local lsp_servers = {
  "ts_ls",
  "lua_ls",
  "ruby_lsp",
  "rust_analyzer"
}

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
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
      end
    }
  },
  config = function()
    local lspconfig = require("lspconfig")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      -- cmd = { "lua-language-server" },
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

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, {})
  end,
}
