return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "ruby", "javascript", "rust", "html", "embedded_template" },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "tab",
          node_decremental = "<S-tab>",
        },
      },
    }
  end,
}
