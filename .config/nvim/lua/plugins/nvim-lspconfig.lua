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
          ensure_installed = {'lua_ls', 'rust_analyzer'},
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
      local lsp = require('lsp-zero')

      local lspconfig = require('lspconfig')
      local lspconfig_defaults = lspconfig.util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
      )

      require('mason-lspconfig').setup_handlers({
        function(server)
          lspconfig[server].setup({})
        end,
      })

      lsp.new_client({
        cmd = {'lua-language-server'},
        filetypes = {'lua'},
        on_init = function(client)
          lsp.nvim_lua_settings(client, {})
        end,
        root_dir = function(bufnr)
          -- You need Neovim v0.10 to use vim.fs.root
          -- Note: include a .git folder in the root of your Neovim config
          return vim.fs.root(bufnr, {'.git', '.luarc.json', '.luarc.jsonc'})
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<leader>cn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<leader>F', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })
    end)

    if not status then
      print("Error in LSP config: " .. err)
    end
  end
}
