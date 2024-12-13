return {
  "tpope/vim-fugitive",
  config = function()
    require("vim-fugitive").setup()
  end,
  commands = {
    { "G", "<cmd>Git<cr>" },
    { "Gblame", "<cmd>Git blame<cr>" },
    { "Gdiff", "<cmd>Git diff<cr>" },
    { "Glog", "<cmd>Git log<cr>" },
    { "Gstatus", "<cmd>Git status<cr>" },
  },
}
