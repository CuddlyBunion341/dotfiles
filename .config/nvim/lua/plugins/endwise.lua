return {
  {
    "RRethy/nvim-treesitter-endwise",
    setup = function()
      -- Requires nvim-treesitter installed
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
}
