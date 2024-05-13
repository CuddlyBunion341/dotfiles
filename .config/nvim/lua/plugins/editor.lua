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
      vim.o.timeoutlen = 300
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
      "s1n7ax/nvim-window-picker"
    },
    keys = {
      { "<leader>e", "<cmd>Neotree position=float reveal toggle<cr>", desc = "Neotree" },
    },
    config = function()
      require("neo-tree").setup({
        sources = { "filesystem", "document_symbols" },
        window = {
          mappings = {
            ["<space>"] = "none",
            ["Y"] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.setreg("+", path, "c")
              end,
              desc = "Copy Path to Clipboard",
            },
            ["O"] = {
              function(state)
                require("lazy.util").open(state.tree:get_node().path, { system = true })
              end,
              desc = "Open with System Application",
            },
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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "vimdoc", "ruby", "bibtex", "yaml" },
        ignore_install = { "latex" }, -- highlighting by vimtex
        auto_install = false,
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
  },
  { "folke/trouble.nvim" },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" }
    }
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
    keys = {
      { "so", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" }
    }
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require('nvim-highlight-colors').setup({})
    end
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({})
    end,
    keys = {
      { "<leader>1",  function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon file 1" },
      { "<leader>2",  function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon file 2" },
      { "<leader>3",  function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon file 3" },
      { "<leader>4",  function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon file 4" },
      { "<leader>5",  function() require("harpoon.ui").nav_file(5) end,         desc = "Harpoon file 5" },
      { "<leader>6",  function() require("harpoon.ui").nav_file(6) end,         desc = "Harpoon file 6" },
      { "<leader>7",  function() require("harpoon.ui").nav_file(7) end,         desc = "Harpoon file 7" },
      { "<leader>8",  function() require("harpoon.ui").nav_file(8) end,         desc = "Harpoon file 8" },
      { "<leader>9",  function() require("harpoon.ui").nav_file(9) end,         desc = "Harpoon file 9" },
      { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon toggle quick menu" },
      { "<leader>H",  function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
    }
  },
}
