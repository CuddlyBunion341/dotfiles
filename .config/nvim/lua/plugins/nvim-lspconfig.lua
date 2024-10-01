local lsp_servers = {
  "ts_ls",
  "lua_ls",
  "ruby_lsp"
}

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
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
    -- print(vim.inspect(capabilities))  -- Debug the capabilities
    lspconfig.lua_ls.setup({ capabilities = capabilities })
    require("lspconfig")["lua_ls"].setup({
      capabilities = capabilities,
      cmd = { "/run/current-system/sw/bin/lua-language-server" },
      on_attach = function()
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
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
