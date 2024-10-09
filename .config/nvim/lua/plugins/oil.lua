return {
	-- "stevearc/oil.nvim", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
	"jelmansouri/oil.nvim", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
  branch = "feat/scratch-preview", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false, -- nvim /dir/name does not work otherwise
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
			watch_for_changes = false,
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
				["gs"] = "actions.change_sort",
				["<C-o>"] = {
					"actions.open_cmdline",
					opts = {
						modify = ":! open",
					},
					desc = "Open file",
				},
        ["K"] = "actions.preview_scroll_up",
        ["J"] = "actions.preview_scroll_down",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
			},
      lsp_file_methods = {
        enabled = false,
      }
		})
	end,
	keys = {
		{ mode = "n", "-", "<cmd>Oil<cr>" },
	},
}
