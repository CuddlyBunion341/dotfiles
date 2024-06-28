vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.winbar = "%f"
vim.opt.laststatus = 3

vim.opt.spelllang = "de_ch"

vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>")
vim.keymap.set("n", "<leader>q!", "<cmd>qa!<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")
vim.api.nvim_set_keymap("n", "gw", 'diw"apviwo<esc>"bpviwo<esc>', { noremap = true, silent = true })

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<a-j>", "5jzz")
vim.keymap.set("n", "<a-k>", "5kzz")

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"
vim.opt.wildignore = {
  "*.docx",
  "*.jpg",
  "*.png",
  "*.gif",
  "*.pdf",
  "*.pyc",
  "*.exe",
  "*.flv",
  "*.img",
  "*.xlsx",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "sainnhe/sonokai", priority = 9999 },
	{
		"catppuccin/nvim",
		priority = 9999,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				show_end_of_buffer = true,
			})
		end,
	},
	{ import = "plugins" },
	{ import = "languages" },
}

local opts = {
	defaults = {
		lazy = true,
	},
}

require("lazy").setup(plugins, opts)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

vim.g.sonokai_better_performance = 1
vim.g.sonokai_style = "andromeda"
vim.cmd.colorscheme("catppuccin")

-- vim.api.nvim_command('highlight Normal guibg=NONE ctermbg=NONE')
-- vim.api.nvim_command('highlight NonText guibg=NONE ctermbg=NONE')
-- vim.api.nvim_command('highlight LineNr guibg=NONE ctermbg=NONE')
-- vim.api.nvim_command('highlight SignColumn guibg=NONE ctermbg=NONE')
-- vim.api.nvim_command('highlight VertSplit guibg=NONE ctermbg=NONE')
