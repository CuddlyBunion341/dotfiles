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
    config = function()
      require("boole").setup({
        allow_caps_additions = {
          { "enable", "disable" },
          { "foo",    "bar" },
        },
      })
    end,
  },
}
