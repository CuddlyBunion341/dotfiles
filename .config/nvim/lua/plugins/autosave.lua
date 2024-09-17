return {
  "Pocco81/auto-save.nvim",
  lazy = false,
  config = function()
    require("auto-save").setup({
      debounce_delay = 50
    })
  end,
}
