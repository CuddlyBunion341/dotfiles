return {
	"RRethy/nvim-treesitter-endwise",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup {
			endwise = {
				enable = true,
			},
		}
	end,
}
