return {
	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({})
		end,
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor()
				end,
				desc = "Refactor",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>" },
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "solargraph" },
			})
		end,
	},
	{
		"nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.solargraph.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.erb_format,
					null_ls.builtins.formatting.erb_lint,
				},
			})
		end,
		keys = {
			{ "<leader>gf", vim.lsp.buf.format },
		},
	},
}
