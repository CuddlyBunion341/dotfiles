return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "m4xshen/autoclose.nvim",
    event = "VeryLazy",
  },
  {
    "nat-418/boole.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "Foo",    "Bar" },
        { "tic",    "tac",     "toe" },
        { "->",     "<--" },
        { "++",     "--" },
        { "light",  "dark" },
        { "public", "private", "protected" },
        { "if",     "unless" },
        { "width",  "height" },
        { "let",    "const" },
      },
      allow_caps_additions = {
        { "enable", "disable" },
      },
    }
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy"
  },
  {
    "machakann/vim-highlightedyank",
    lazy = false,
    config = function()
      vim.g.highlightedyank_highlight_duration = 100
    end
  },
  { "tpope/vim-repeat", lazy = false },
}
