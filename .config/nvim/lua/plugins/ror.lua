return {
  {
    "weizheheng/ror.nvim",
    config = function()
      require("ror").setup()
      vim.keymap.set("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
      -- vim.keymap.sot("n", "<Leader>fv", ":lua require('ror.commands').find_view()<CR>", { silent = true })
    end,
  },
}
