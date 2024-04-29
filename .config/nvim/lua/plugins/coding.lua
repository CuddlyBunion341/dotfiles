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
}
