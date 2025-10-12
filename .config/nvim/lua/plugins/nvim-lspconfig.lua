return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "VonHeikemen/lsp-zero.nvim",
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },
  keys = {
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp info" },
    { "<leader>ll", "<cmd>LspLog<cr>", desc = "Lsp log" },
  },
  config = function()
    -- Setup mason-lspconfig with v2.0 API
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
      automatic_enable = true, -- This automatically enables installed servers
    })

    -- Setup LSP capabilities for autocompletion
    local lspconfig = require("lspconfig")
    local lspconfig_defaults = lspconfig.util.default_config
    lspconfig_defaults.capabilities =
      vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Configure ruby-lsp using the new vim.lsp.config API
    vim.lsp.config("ruby-lsp", {
      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
        settings = {
          formatter = {
            enabled = false,
          },
        },
      },
    })

    -- herb?
    vim.lsp.config("herb_ls", {
      cmd = { "herb-language-server", "--stdio" },
      filetypes = { "erb" },
    })

    -- LSP keymaps and autocmds
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature help" })
        vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename symbol" })
        vim.keymap.set({ "n", "x" }, "<leader>F", function()
          vim.lsp.buf.format({ async = true }) -- TODO: add desc
        end, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
  end,
}
