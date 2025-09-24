return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})
  end,
  keys = {
    {
      "<C-f>",
      function()
        require("grug-far").open()
      end,
      desc = "Find and replace",
    },
    {
      "<leader>sp",
      function()
        require("grug-far").open()
      end,
      desc = "Find and replace",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Find and replace word under cursor",
    },
  },
}
