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
					-- plantuml sequence
					{ "->", "<--" },
					{ "++", "--" },
				},
				allow_caps_additions = {
					{ "enable", "disable" },
				},
			})
		end,
	},
	-- {
	-- 	"monaqa/dial.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		local augend = require("dial.augend")
	--
	-- 		vim.keymap.set("n", "<C-a>", function()
	-- 			require("dial.map").manipulate("increment", "normal")
	-- 		end)
	-- 		vim.keymap.set("n", "<C-x>", function()
	-- 			require("dial.map").manipulate("decrement", "normal")
	-- 		end)
	-- 		vim.keymap.set("n", "g<C-a>", function()
	-- 			require("dial.map").manipulate("increment", "gnormal")
	-- 		end)
	-- 		vim.keymap.set("n", "g<C-x>", function()
	-- 			require("dial.map").manipulate("decrement", "gnormal")
	-- 		end)
	-- 		vim.keymap.set("v", "<C-a>", function()
	-- 			require("dial.map").manipulate("increment", "visual")
	-- 		end)
	-- 		vim.keymap.set("v", "<C-x>", function()
	-- 			require("dial.map").manipulate("decrement", "visual")
	-- 		end)
	-- 		vim.keymap.set("v", "g<C-a>", function()
	-- 			require("dial.map").manipulate("increment", "gvisual")
	-- 		end)
	-- 		vim.keymap.set("v", "g<C-x>", function()
	-- 			require("dial.map").manipulate("decrement", "gvisual")
	-- 		end)
	--
	-- 		require("dial.config").augends:register_group({
	-- 			default = {
	-- 				augend.constant.new({
	-- 					elements = { "true", "false" },
	-- 					word = true,
	-- 					cyclic = true,
	-- 				}),
	-- 				augend.constant.new({
	-- 					elements = { "->", "<--" },
	-- 					word = true,
	-- 					cyclic = true,
	-- 				}),
	-- 				augend.constant.new({
	-- 					elements = { "++", "--" },
	-- 					word = true,
	-- 					cyclic = true,
	-- 				}),
	-- 				augend.constant.new({
	-- 					elements = { "&&", "||" },
	-- 					word = false,
	-- 					cyclic = true,
	-- 				}),
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"machakann/vim-highlightedyank",
		lazy = false,
	},
	{
		"tpope/vim-repeat",
		lazy = false,
	},
}
