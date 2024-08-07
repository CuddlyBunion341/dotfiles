return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
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
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = false,
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		commands = {
			"CopilotChat",
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatClose",
			"CopilotChatToggle",
			"CopilotChatStop",
			"CopilotChatReset",
			"CopilotChatSave",
			"CopilotChatLoad",
			"CopilotChatDebugInfo",
			"CopilotChatModels",
			"CopilotChatExplain",
			"CopilotChatReview",
			"CopilotChatFix",
			"CopilotChatOptimize",
			"CopilotChatDocs",
			"CopilotChatTests",
			"CopilotChatFixDiagnostic",
			"CopilotChatCommit",
			"CopilotChatCommitStaged",
		},
		opts = {
			temperature = 0.3,
			mappings = {
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-m>",
				},
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				yank_diff = {
					normal = "gy",
				},
				show_diff = {
					normal = "gd",
				},
				show_system_prompt = {
					normal = "gp",
				},
				show_user_selection = {
					normal = "gs",
				},
			},
		},
		keys = {
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
			-- vim.api.nvim_create_autocmd("LspAttach", {
			--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
			--   callback = function(args)
			--     vim.api.nvim_create_autocmd("BufWritePre", {
			--       buffer = args.buf,
			--       callback = function()
			--         vim.lsp.buf.format({ async = false, id = args.data.client_id })
			--       end,
			--     })
			--   end,
			-- })

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			-- lspconfig.standardrb.setup({ capabilities = capabilities })
			-- lspconfig.rubocop.setup({ capabilities = capabilities })
			-- lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.ltex.setup({
				cmd = { "ltex-ls" },
				filetypes = { "markdown", "text", "cff", "tex" },
				flags = { debounce_text_changes = 299 },
			})
			lspconfig.astro.setup({})

			lspconfig.solargraph.setup({
				capabilities = capabilities,
				cmd = {
					"asdf",
					"exec",
					"solargraph",
					"stdio",
				},
				settings = {
					solargraph = {
						autoformat = false,
						completion = true,
						diagnostic = true,
						folding = true,
						references = true,
						rename = true,
						symbols = true,
					},
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, {})
			vim.cmd([[
      autocmd BufNewFile,BufRead *.prawn set filetype=ruby
      ]])
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.disable({ "rubocop" })
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
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- {
	--   "nvim-treesitter/nvim-treesitter-refactor",
	--   lazy = false,
	--   config = function()
	--     require("nvim-treesitter.configs").setup({
	--       refactor = {
	--         highlight_definitions = {
	--           enable = true,
	--           clear_on_cursor_move = true,
	--         },
	--         highlight_current_scope = { enable = false },
	--         smart_rename = {
	--           enable = true,
	--           -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
	--           keymaps = {
	--             smart_rename = "grr",
	--           },
	--         },
	--         navigation = {
	--           enable = true,
	--           -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
	--           keymaps = {
	--             goto_definition = "gnd",
	--             list_definitions = "gnD",
	--             list_definitions_toc = "gO",
	--             goto_next_usage = "<a-*>",
	--             goto_previous_usage = "<a-#>",
	--           },
	--         },
	--       },
	--     })
	--   end,
	-- },
	-- {
	--   "cuducos/yaml.nvim",
	--   ft = { "yaml" }, -- optional
	--   dependencies = {
	--     "nvim-treesitter/nvim-treesitter",
	--     "nvim-telescope/telescope.nvim", -- optional
	--   },
	-- }
}
