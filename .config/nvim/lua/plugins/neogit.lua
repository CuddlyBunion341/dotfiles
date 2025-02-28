return {
	"NeogitOrg/neogit",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>g", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
	config = function()
		require("neogit").setup({
			graph_style = "unicode",
		})
	end,
}
