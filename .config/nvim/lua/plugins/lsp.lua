return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    keys = {
      { "<leader>m", "<cmd>Mason<cr>" },
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "solargraph", "rust_analyzer" },
      })
    end,
  },
  {
    "sheerun/vim-polyglot",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require('lspconfig')

      local common_options = {
        capabilities = capabilities,
      }

      local function setup_lsp(server_name, options)
        options = options or {}
        lspconfig[server_name].setup(vim.tbl_extend('force', common_options, options))
      end

      setup_lsp('lua_ls')
      setup_lsp('ruby_lsp')
      setup_lsp('rubocop')
      setup_lsp('ts_ls')
      setup_lsp('ltex', {
        cmd = { "ltex-ls" },
        filetypes = { "markdown", "text", "cff", "tex" },
        flags = { debounce_text_changes = 299 },
      })
      setup_lsp('astro')
      setup_lsp('rust_analyzer')

      lspconfig.solargraph.setup({
        capabilities = capabilities,
        cmd = {
          "asdf",
          "exec",
          "solargraph",
          "stdio",
        },
        settings = {
          solargraph = {
            autoformat = false,
            completion = true,
            diagnostic = true,
            folding = true,
            references = true,
            rename = true,
            symbols = true,
          },
        },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, {})
      vim.cmd([[
      autocmd BufNewFile,BufRead *.prawn set filetype=ruby
      ]])
    end,
    keys = {
      {"<leader>ls", "<cmd>LspStop<cr>"},
      {"<leader>lS", "<cmd>LspStart<cr>"},
    }
  },
  {
    "danarth/sonarlint.nvim",
    ft = "java",
    config = function()
      require('sonarlint').setup({
        server = {
          cmd = {
            'sonarlint-language-server',
            -- Ensure that sonarlint-language-server uses stdio channel
            '-stdio',
            '-analyzers',
            -- paths to the analyzers you need, using those for python and java in this example
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          },
          -- All settings are optional
          settings = {
            -- The default for sonarlint is {}, this is just an example
            sonarlint = {
              rules = {
                ['typescript:S101'] = { level = 'on', parameters = { format = '^[A-Z][a-zA-Z0-9]*$' } },
                ['typescript:S103'] = { level = 'on', parameters = { maximumLineLength = 180 } },
                ['typescript:S106'] = { level = 'on' },
                ['typescript:S107'] = { level = 'on', parameters = { maximumFunctionParameters = 7 } }
              }
            }
          }
        },
        filetypes = {
          -- Tested and working
          'python',
          'cpp',
          -- Requires nvim-jdtls, otherwise an error message will be printed
          'java',
        }
      })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.disable({ "rubocop" })
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.erb_format,
          null_ls.builtins.formatting.erb_lint,
        },
      })
    end,
    keys = {
      { "<leader>lf", vim.lsp.buf.format },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
