return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		event = "VeryLazy",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"nat-418/boole.nvim",
		event = "VeryLazy",
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
				additions = {
					{ "Foo", "Bar" },
					{ "tic", "tac", "toe" },
					{ "->", "<--" },
					{ "++", "--" },
					{ "light", "dark" },
					{ "public", "private", "protected" },
					{ "if", "unless" },
					{ "width", "height" },
					{ "let", "const" },
				},
				allow_caps_additions = {
					{ "enable", "disable" },
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
    event = "VeryLazy"
	},
	{
		"machakann/vim-highlightedyank",
		lazy = false,
    config = function()
      vim.g.highlightedyank_highlight_duration = 100
    end
	},
	{ "tpope/vim-repeat", lazy = false },
}
