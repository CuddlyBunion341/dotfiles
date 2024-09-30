return  {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({});
  end,
  keys = {
    { "<leader>Rf",function() require("grug-far").open() end},
    { "<leader>Rw", function() 
      require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
    end
  }
}
}
