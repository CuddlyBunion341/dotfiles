-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = 'nvim %{expand("%:p")}'

-- require("telescope").setup({
--   defaults = {
--     vimgrep_arguments = {
--       "rg",
--       "--color=never",
--       "--no-heading",
--       "--with-filename",
--       "--line-number",
--       "--column",
--       "--smart-case",
--     },
--     prompt_position = "bottom",
--     prompt_prefix = "> ",
--     initial_mode = "insert",
--     layout_strategy = "horizontal",
--     layout_config = {
--       horizontal = {
--         mirror = false,
--       },
--       vertical = {
--         mirror = false,
--       },
--     },
--     file_sorter = require("telescope.sorters").get_fuzzy_file,
--     file_ignore_patterns = {},
--     generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--     path_display = true,
--     winblend = 0,
--     selection_strategy = "reset",
--     sorting_strategy = "descending",
--     scroll_strategy = "cycle",
--     color_devicons = true,
--     use_less = true,
--     set_env = { ["COLORTERM"] = "truecolor" },
--   },
-- })
--
-- -- nnoremap <leader>fr :exec("Telescope live_grep grep_string=" . system("bundle exec rails routes | awk 'NR>1{ print $2 }' | rg . | tr '\n' ' '"))<CR>
-- the abve but in lua
-- vim.keymap.nnoremap("<leader>yu", function()
--   vim.cmd(
--     "Telescope live_grep grep_string="
--       .. vim.fn.system("bundle exec rails routes | awk 'NR>1{ print $2 }' | rg . | tr '\n' ' '")
--   )
-- end)
