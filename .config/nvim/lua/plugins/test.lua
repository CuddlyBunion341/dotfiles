return {
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"olimorris/neotest-rspec",
		},
		opts = {
			adapters = {
				["neotest-rspec"] = {
					rspec_cmd = function()
						return vim.tbl_flatten({
							"bundle",
							"exec",
							"rspec",
						})
					end,
				},
			},
		},
	},
}
