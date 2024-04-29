return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    event = "VeryLazy",
    config = function()
      require("autoclose").setup()
    end,
  },
  {
    "nat-418/boole.nvim",
    lazy = false,
    config = function()
      require("boole").setup({
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x>",
        },
        additions = {
          { "Foo", "Bar" },
          { "tic", "tac", "toe" },
        },
        allow_caps_additions = {
          { "enable", "disable" },
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  {
    "machakann/vim-highlightedyank",
    lazy = false
  }
}
