return {
  { "tpope/vim-unimpaired",        lazy = false },
  { "christoomey/vim-system-copy", lazy = false },
  { "folke/neoconf.nvim",          cmd = "Neoconf" },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
          },
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Apps",
            group = "DiagnosticHint",
            action = "Telescope app",
            key = "a",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = "Telescope dotfiles",
            key = "d",
          },
          {
            desc = " Restore Session",
            group = "Number",
            action = "require('persistence').load()",
            key = "r"
          }
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'adelarsq/image_preview.nvim',
    event = 'VeryLazy',
    config = function()
      require("image_preview").setup()
    end
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    config = function()
      -- vim.cmd.colorscheme("oxocarbon")
    end,
  },
  -- TODO: fix
  {
    "max397574/better-escape.nvim",
    lazy = false,
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "jj" },
        timeout = 100,
        clear_empty_lines = false,
        keys = function()
          return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
        end,
      })
    end,
  },
  {
    "jsit/toast.vim",
    lazy = false,
    config = function()
      -- vim.cmd "set background=light"
      -- vim.cmd.colorscheme "toast"
    end,
  },
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
      vim.o.timeoutlen = 200
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
      "s1n7ax/nvim-window-picker",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree position=float reveal toggle<cr>", desc = "Neotree" },
    },
    config = function()
      require("neo-tree").setup({
        sources = { "filesystem", "document_symbols" },
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
          },
        },
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
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
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
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 142,
        preview_split = "right",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Oil" },
    },
  },
  {
    "FeiyouG/commander.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>f",  "<CMD>Telescope commander<CR>", mode = "n" },
      { "<leader>fc", "<CMD>Telescope commander<CR>", mode = "n" },
    },
    config = function()
      require("commander").setup({
        components = {
          "DESC",
          "KEYS",
          "CAT",
        },
        sort_by = {
          "DESC",
          "KEYS",
          "CAT",
          "CMD",
        },
        integration = {
          telescope = {
            enable = true,
          },
          lazy = {
            enable = true,
            set_plugin_name_as_cat = true,
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = "*",
    lazy = false,
    config = function() end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    config = {
      exclude = {
        filetypes = {
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          "Dashboard",
        },
      },
    },
    keys = {
      {
        "<leader>ibl",
        "<cmd>IBLToggleScope<cr>",
      },
    },
  },
  {
    "jlanzarotta/bufexplorer",
    lazy = false,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("spectre").setup()
    end,
    keys = {
      {
        mode = "n",
        "<leader>S",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Spectre",
      },
      {
        mode = "n",
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current word",
      },
      {
        mode = "v",
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        desc = "Search current word",
      },
      {
        mode = "n",
        "<leader>sp",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
    },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    keys = {
      {
        "<leader>j",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
      },
      {
        "<leader>k",
        function()
          require("trouble").previous({ skip_groups = true, jump = true })
        end,
      },
    },
  },
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
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = function()
      require("toggleterm").setup({
        float_opts = {
          border = "curved",
        },
      })

      opts = {}
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    end,
    keys = {
      { "!", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal" },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
    keys = {
      { "so", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" },
    },
  },
  -- {
  --   "brenoprata10/nvim-highlight-colors",
  --   event = "VeryLazy",
  --   config = function()
  --     require('nvim-highlight-colors').setup({})
  --   end
  -- },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({})
    end,
    keys = {
      {
        "<leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Harpoon file 4",
      },
      {
        "<leader>5",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        desc = "Harpoon file 5",
      },
      {
        "<leader>6",
        function()
          require("harpoon.ui").nav_file(6)
        end,
        desc = "Harpoon file 6",
      },
      {
        "<leader>7",
        function()
          require("harpoon.ui").nav_file(7)
        end,
        desc = "Harpoon file 7",
      },
      {
        "<leader>8",
        function()
          require("harpoon.ui").nav_file(8)
        end,
        desc = "Harpoon file 8",
      },
      {
        "<leader>9",
        function()
          require("harpoon.ui").nav_file(9)
        end,
        desc = "Harpoon file 9",
      },
      {
        "<leader>hh",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon toggle quick menu",
      },
      {
        "<leader>H",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon add file",
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
    lazy = false,
  },
  { "echasnovski/mini.ai", version = false, lazy = false },
}
