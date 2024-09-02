return {
  { "tpope/vim-rails", lazy = false },
  {
    "sato-s/telescope-rails.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>rs", "<cmd>Telescope rails specs<cr>",       desc = "Telescope rails specs" },
      { "<leader>rc", "<cmd>Telescope rails controllers<cr>", desc = "Telescope rails controllers" },
      { "<leader>rm", "<cmd>Telescope rails models<cr>",      desc = "Telescope rails models" },
      { "<leader>rv", "<cmd>Telescope rails views<cr>",       desc = "Telescope rails views" },
      { "<leader>ri", "<cmd>Telescope rails migrations<cr>",  desc = "Telescope rails migrations" },
      { "<leader>rl", "<cmd>Telescope rails libs<cr>",        desc = "Telescope rails libs" },
    },
  },
  {
    "Einenlum/yaml-revealer",
    ft = "yaml"
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()

    require('nvim-ts-autotag').setup({
      aliases = {
        ["erb"] = "html"
      },
      opts = {
        -- Defaults
        enable_close = true,      -- Auto close tags
        enable_rename = true,     -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ["html"] = {
          enable_close = false
        }
      }
    })
    end
  },
  {
    "rgroli/other.nvim",
    lazy = false,
    keys = {
      { "<leader>ll",  "<cmd>:Other<CR>",       desc = "Other" },
      { "<leader>ltn", "<cmd>:OtherTabNew<CR>", desc = "OtherTabNew" },
      { "<leader>lp",  "<cmd>:OtherSplit<CR>",  desc = "OtherSplit" },
      { "<leader>lv",  "<cmd>:OtherVSplit<CR>", desc = "OtherVSplit" },
      { "<leader>lc",  "<cmd>:OtherClear<CR>",  desc = "OtherClear" },
      { "<leader>lt",  "<cmd>:Other test<CR>",  desc = "Other test" },
    },
    config = function()
      require("other-nvim").setup({
        mappings = {
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
        },
      })
    end,
  },
  {
    "slim-template/vim-slim",
    ft = "slim",
  },
}
