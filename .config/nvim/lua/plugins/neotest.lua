return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-rspec",
		"zidhuss/neotest-minitest",
		"rcasia/neotest-java",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-minitest"),
				require("neotest-rspec")({
          rspec_cmd = function()
            return { "mise", "exec", "--", "bundle", "exec", "rspec" }
          end
        }),
				["neotest-java"] = {
					ignore_wrapper = true,
				},
			},
		})
	end,
	keys = {
		{ "<leader>tt", "<cmd>Neotest run file<cr>", desc = "Test file" },
		{ "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run closest test" },
		{ "<leader>to", "<cmd>Neotest output<cr>", desc = "Test output" },
		{ "<leader>tO", "<cmd>Neotest output-panel<cr>", desc = "Test output panel" },
		{ "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop test" },
	},
}
