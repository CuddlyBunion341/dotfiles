return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope.nvim",
			"erlingur/telescope-rails-db-schema",
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("media_files")
			telescope.load_extension("rails_db_schema")
      telescope.setup({
        pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
			})
		end,
		keys = {
			{
				"<leader>f",
				"<cmd>Telescope find_files hidden=true<cr>",
				desc = "Telescope File",
			},
			{
				"<leader>tr",
				"<cmd>Telescope resume<cr>",
				desc = "Telescope Resume",
			},
			{
				"<leader>n",
				"<cmd>Telescope find_files search_dirs={'~/.config/nvim/'}<cr>",
				desc = "Telescope Config",
			},
			{
				"<leader>tg",
				"<cmd>Telescope git_files<cr>",
				desc = "Telescope Git File",
			},
			{
				"<leader>tb",
				"<cmd>Telescope buffers<cr>",
				desc = "Telescope Buffer",
			},
			{
				"<leader>tw",
				"<cmd>Telescope grep_string<cr>",
				desc = "Telescope Grep",
			},
			{
				"<leader>w",
				"<cmd>Telescope live_grep<cr>",
				desc = "Telescope Grep",
			},
			{
				"<leader>tq",
				"<cmd>Telescope quickfix<cr>",
				desc = "Telescope Quickfix",
			},
			{
				"<leader>r",
				function()
					local word = vim.fn.expand("<cword>")
					require("telescope.builtin").grep_string(
          -- require('telescope.themes').get_cursor({})
					--      {
					-- 	search = word,
					-- 	only_sort_text = true,
					-- 	layout_strategy = "vertical",
					-- }
          )
				end,
				desc = "Telescope grep current word",
			},
			{
				"<leader>R",
				function()
					local filename = vim.fn.expand("<cword>")
					require("telescope.builtin").find_files({
            prompt_prefix = "🔍",
						find_command = { "rg", "--files", "--hidden", "--ignore", "--glob", "!*.git/*" },
					})
				end,
				desc = "Telescope find file under cursor",
			},
			{
				"<leader>tg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				desc = "Telescope Grep Args",
			},
			{ "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Keymap" },
			{ "<leader><leader>", "<cmd>Telescope commands<cr>", desc = "Telescope Command" },
			{ "<leader>td", "<cmd>:Telescope rails_db_schema<CR>", desc = "Telescope Rails db schema" },
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = false,
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
