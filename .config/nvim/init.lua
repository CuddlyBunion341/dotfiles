-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'
