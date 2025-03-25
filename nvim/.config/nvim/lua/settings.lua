vim.g.mapleader = " "
vim.g.maplocalleader = ","
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
vim.opt.autowriteall = true
vim.opt.list = false -- whitespace
vim.o.clipboard = "unnamedplus"
vim.o.timeoutlen = 200
-- vim.opt.cmdheight = 0

-- keyap to toggle line numbers (set nonumber and set norelativenumber)
-- vim.keymap.set("n", "<C-u>", ":set invnumber<cr>:set invrelativenumber<cr>")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")

-- tabs
-- vim.keymap.set("n", "<C-t>", ":tabnew<cr>", { noremap = true })
-- vim.keymap.set("n", "<C-]>", ":tabnext<cr>", { noremap = true })
-- vim.keymap.set("n", "<C-[>", ":tabprevious<cr>", { noremap = true })

-- terminal
vim.keymap.set("n", "<C-`>", ":vert terminal<cr>", { noremap = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true })

-- move
vim.api.nvim_set_keymap("x", "<C-j>", ":move '>+<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
vim.api.nvim_set_keymap("n", "<C-k>", ":move -2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
vim.api.nvim_set_keymap("n", "<C-j>", ":move +<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.api.nvim_set_keymap("x", "<C-k>", ":move -2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })

-- saving / quitting

vim.keymap.set("n", "Q", ":quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<cr>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>W", ":wq<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>q", ":quitall<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>s", ":w<cr>", { desc = "Save" })

-- formatting

vim.keymap.set("n", "g=", "ggVG=<C-o>", { desc = "Fix indentation in file" })
vim.keymap.set("n", "zt", "<cmd>%s/\t/  /g<cr><C-o>", { desc = "Replace tabs with spaces" })
vim.keymap.set("n", "vag", "ggVG", { desc = "Visual select file contents" })
vim.keymap.set("n", "dag", "ggVGd", { desc = "Delete file contents" })
vim.keymap.set("n", "yag", "ggVGy", { desc = "Format paragraph" })
vim.keymap.set("n", "cag", "ggVGc", { desc = "Format paragraph" })
vim.keymap.set("n", "gJ", "Jx")

-- macro

vim.api.nvim_set_keymap("n", "<Delete>", "qq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<PageUp>", "q", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<PageDown>", "@q", { noremap = true, silent = true })

-- suppression

vim.opt.shortmess:append("A") -- https://stackoverflow.com/questions/1098159/vim-stop-existing-swap-file-warnings

-- commands

vim.keymap.set("n", "<leader>L", ":Lazy<cr>")
vim.keymap.set("n", "cp", "cp :let @+=expand('%:p')<cr>")
vim.keymap.set("n", "cm", ":cnext<cr>")
vim.keymap.set("n", "cl", ":cprev<cr>")

-- splits

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { silent = true })
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { silent = true })
vim.keymap.set("n", "<C-e>", ":wincmd =<cr>", { silent = true })
vim.keymap.set("n", "<leader>v", ":wincmd v<cr>", { silent = true })
vim.keymap.set("n", "<leader>V", ":wincmd s<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>o", function()
	-- get the current line content
	local line = vim.api.nvim_get_current_line()

	-- extract the string (either single-quoted or double-quoted)
	local str = line:match("'(.-)'") or line:match('"(.-)"')

	if str then
		-- Construct the GitHub URL
		local url = "https://github.com/" .. str

		-- use the open shell command to open the URL
		os.execute("open " .. url)
	else
		print("No valid string found on the current line.")
	end
end)
