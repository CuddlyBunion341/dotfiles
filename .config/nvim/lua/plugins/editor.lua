return {
  { "christoomey/vim-system-copy", lazy = false },
  { "folke/neoconf.nvim",          cmd = "Neoconf" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 0
    end,
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree position=float reveal toggle<cr>", desc = "Neotree" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["<space>"] = "none"
          }
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "RRethy/nvim-treesitter-endwise"
    },
    setup = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "help", "ruby", "bibtex", "latex" },
        auto_install = true,
        endwise = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Oil" },
    },
  },
  {
    "jlanzarotta/bufexplorer",
    lazy = false
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('spectre').setup()
    end,
    keys = {
      { mode = 'n', '<leader>S',  '<cmd>lua require("spectre").toggle()<CR>',                             desc = "Toggle Spectre" },
      { mode = 'n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',      desc = "Search current word" },
      { mode = 'v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',                   desc = "Search current word" },
      { mode = 'n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search on current file" },
    }
  }
}
