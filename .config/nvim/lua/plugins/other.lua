return {
  -- default settings

  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup({
        mappings = {
          -- builtin mappings
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
          -- custom mapping
          {
            pattern = "/app/.+(.*)_controller.rb",
            target = "/spec/request/%1_spec.rb",
            transformer = "lowercase",
          },
        },
        transformers = {
          -- defining a custom transformer
          lowercase = function(inputString)
            return inputString:lower()
          end,
        },
        style = {
          -- How the plugin paints its window borders
          -- Allowed values are none, single, double, rounded, solid and shadow
          border = "solid",

          -- Column seperator for the window
          seperator = "|",

          -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
          width = 0.7,

          -- min height in rows.
          -- when more columns are needed this value is extended automatically
          minHeight = 2,
        },
      })

      vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true })

      -- Context specific bindings
      vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true })
    end,
  },
}
