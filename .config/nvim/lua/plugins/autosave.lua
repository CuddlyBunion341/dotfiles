return {
	"Pocco81/auto-save.nvim",
	lazy = true,
	config = function()
		require("auto-save").setup({
			debounce_delay = 50,
			-- condition = function(buf)
			--   local fn = vim.fn
			--   local utils = require("auto-save.utils.data")
			--
			--   if
			--     fn.getbufvar(buf, "&modifiable") == 1 and
			--     utils.not_in(fn.getbufvar(buf, "&filetype"), {"oil"}) then
			--     return true
			--   end
			--   return false
			-- end,
		})
	end,
}
