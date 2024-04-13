return {
  "junkblocker/git-time-lapse",
  config = function()
    vim.keymap.set("n", "<Leader>gt", "<Plug>(git-time-lapse)", { noremap = false })
  end,
}
