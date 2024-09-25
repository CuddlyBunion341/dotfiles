vim.g.mapleader = " "
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.autowrite = true
vim.opt.shortmess:append("A") -- https://stackoverflow.com/questions/1098159/vim-stop-existing-swap-file-warnings
vim.opt.autowriteall = true
vim.opt.list = true
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "Q", ":quit<cr>")
vim.keymap.set("n", "<leader>Q", ":q!<cr>")
vim.keymap.set("n", "<leader>W", ":wq<cr>")
vim.keymap.set("n", "<leader>q", ":quitall<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")
vim.keymap.set("n", "<leader>s", ":w<cr>")
vim.keymap.set("n", "g=", "ggVG=<C-o>")
vim.keymap.set("n", "zt", "<cmd>%s/\t/  /g<cr><C-o>")
vim.keymap.set("n", "vag", "ggVG")
vim.keymap.set("n", "dag", "ggVGd")
vim.keymap.set("n", "cag", "ggVGc")
vim.keymap.set("n", "gJ", "Jx")
vim.api.nvim_set_keymap('n', '<Delete>', 'qq', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<PageUp>', 'q', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<PageDown>', '@q', { noremap = true, silent = true })

-- tabs
vim.keymap.set("n", "<C-t>", ":tabnew<cr>", { noremap = true })
vim.keymap.set("n", "<C-]>", ":tabnext<cr>", { noremap = true })
vim.keymap.set("n", "<C-[>", ":tabprevious<cr>", { noremap = true })

-- terminal
vim.keymap.set("n", "<C-`>", ":vert terminal<cr>", { noremap = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true })

-- Function to toggle terminal on the right
function toggle_terminal()
  local term_bufnr = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(bufnr, 'buftype') == 'terminal' then
      term_bufnr = bufnr
      break
    end
  end

  if term_bufnr then
    -- If terminal is open, close it
    vim.api.nvim_buf_delete(term_bufnr, { force = true })
  else
    -- If terminal is not open, open it in a vertical split
    vim.cmd('vsplit | terminal')
  end
end

-- Map Ctrl + . to toggle terminal
vim.keymap.set("n", "<C-.>", toggle_terminal, { noremap = true, silent = true })

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', '<C-k>', ':wincmd k<cr>', { silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<cr>', { silent = true })
vim.keymap.set('n', '<C-h>', ':wincmd h<cr>', { silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<cr>', { silent = true })
vim.keymap.set('n', '<C-e>', ':wincmd =<cr>', { silent = true })
vim.keymap.set('n', '<leader>v', ':wincmd v<cr>', { silent = true})
vim.keymap.set('n', '<leader>V', ':wincmd s<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>o', function()
  -- Get the current line content
  local line = vim.api.nvim_get_current_line()

  -- Extract the string (either single-quoted or double-quoted)
  local str = line:match("'(.-)'") or line:match('"(.-)"')

  if str then
    -- Construct the GitHub URL
    local url = "https://github.com/" .. str

    -- Use the open shell command to open the URL
    os.execute("open " .. url)
  else
    print("No valid string found on the current line.")
  end
end)

-- vim.api.nvim_set_keymap('n', '@', '@q', {noremap = true})

vim.keymap.set('n', 'L', ':Lazy<cr>')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = "plugins" }
}

local opts = { defaults = { lazy = true }, change_detection = { notify = false } }

require("lazy").setup(plugins, opts)

-- highlighted yank

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})

-- hybrid line numbers

local numbertoggle_group = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd(
{'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter'},
{
  group = numbertoggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= 'i' then
      vim.wo.relativenumber = true
    end
  end
}
)

vim.api.nvim_create_autocmd(
{'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave'},
{
  group = numbertoggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end
}
)
