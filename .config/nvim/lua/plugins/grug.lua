return  {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({});
  end,
  keys = {
    { "<leader>sp",function() require("grug-far").open() end},
    { "<leader>sw", function()
      require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
    end
  }
}
}
