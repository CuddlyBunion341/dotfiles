return {
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyodark")
		end,
	},
	-- {
	-- 	"maxmx03/solarized.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme solarized")
	-- 		vim.cmd("set bg=light")
	-- 	end,
	-- },
}
