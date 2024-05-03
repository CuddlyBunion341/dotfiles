return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    config = function()
      require("telescope").load_extension("lazygit")
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 1
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      vim.g.lazygit_config_file_path = ''
    end
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git" }
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require('gitsigns').setup({

        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)
        end
      })
    end,
    keys = {
      { "<leader>hs", function() require("gitsigns").stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, desc = "stage_hunk",               mode = "v" },
      { "<leader>hr", function() require("gitsigns").reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, desc = "reset_hunk",               mode = "v" },
      { "ih",         ":<C-U>Gitsigns select_hunk<CR>",                                                     mode = { "o", "x" } },
      { "<leader>hb", function() require("gitsigns").blame_line { full = true } end,                        desc = "blame_line" },
      { "<leader>hD", function() require("gitsigns").diffthis("~") end,                                     desc = "diffthis" },
      { "<leader>hs", function() require("gitsigns").stage_hunk() end,                                      desc = "stage_hunk" },
      { "<leader>hr", function() require("gitsigns").reset_hunk() end,                                      desc = "reset_hunk" },
      { "<leader>hS", function() require("gitsigns").stage_buffer() end,                                    desc = "stage_buffer" },
      { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end,                                 desc = "undo_stage_hunk" },
      { "<leader>hR", function() require("gitsigns").reset_buffer() end,                                    desc = "reset_buffer" },
      { "<leader>hp", function() require("gitsigns").preview_hunk() end,                                    desc = "preview_hunk" },
      { "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end,                       desc = "toggle_current_line_blame" },
      { "<leader>hd", function() require("gitsigns").diffthis() end,                                        desc = "diffthis" },
      { "<leader>td", function() require("gitsigns").toggle_deleted() end,                                  desc = "toggle_deleted" },
    }
  }
}
