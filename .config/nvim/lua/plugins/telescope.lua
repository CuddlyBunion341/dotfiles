return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope File" },
      { "<leader>fc", "<cmd>Telescope find_files search_dirs={'~/.config/nvim/'}<cr>", desc = "Telescope Config" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Telescope Git File" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffer" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Telescope Grep" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Telescope Grep" },
      { "<leader>fr",
        function()
          local word = vim.fn.expand("<cword>")
          require("telescope.builtin").grep_string {
            search = word,
            only_sort_text = true,
            layout_strategy = "vertical",
            layout_config = {}
          }
        end,
        desc = "Telescope current word"
      },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Keymap" },
      { "<leader><leader>", "<cmd>Telescope commands<cr>", desc = "Telescope Command" },
    }
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
