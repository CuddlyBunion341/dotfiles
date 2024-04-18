return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          cmd = { "ltex-ls" },
          filetypes = { "markdown", "text", "cff", "tex" },
          flags = { debounce_text_changes = 299 },
        },
      },
    },
  },
}
