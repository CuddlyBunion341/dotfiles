return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			constrain_cursor = "name",
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			watch_for_changes = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-n>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-m>"] = {
					"actions.select",
					opts = { horizontal = true },
					desc = "Open the entry in a horizontal split",
				},
				["<C-T>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-p>"] = "actions.preview",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["<C-~>"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["<C-o>"] = {
					"actions.open_cmdline",
					opts = {
						modify = ":! open",
					},
					desc = "Open file",
				},
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
			},
		})
	end,
	keys = {
		{ mode = "n", "-", "<cmd>Oil<cr>" },
	},
}
