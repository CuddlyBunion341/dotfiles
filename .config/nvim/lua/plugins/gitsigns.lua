return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function()
    require("gitsigns").setup({
      numhl = true,
      attach_to_untracked = true,
      update_debounce = 5,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
      end,
    })
  end,
  keys = {
    -- Navigation
    { "]c", function() if vim.wo.diff then vim.cmd("normal! ]c") else require("gitsigns").next_hunk() end end, mode = "n", desc = "Next Git hunk" },
    { "[c", function() if vim.wo.diff then vim.cmd("normal! [c") else require("gitsigns").prev_hunk() end end, mode = "n", desc = "Previous Git hunk" },

    -- Actions
    { "<leader>hs", ":Gitsigns stage_hunk<CR>", mode = "n", desc = "Stage Hunk" },
    { "<leader>hr", ":Gitsigns reset_hunk<CR>", mode = "n", desc = "Reset Hunk" },
    { "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "Stage Hunk" },
    { "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "Reset Hunk" },
    { "<leader>hS", ":Gitsigns stage_buffer<CR>", mode = "n", desc = "Stage Buffer" },
    { "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", mode = "n", desc = "Undo Stage Hunk" },
    { "<leader>hR", ":Gitsigns reset_buffer<CR>", mode = "n", desc = "Reset Buffer" },
    { "<leader>hp", ":Gitsigns preview_hunk<CR>", mode = "n", desc = "Preview Hunk" },
    { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, mode = "n", desc = "Blame Line" },
    { "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", mode = "n", desc = "Toggle Blame" },
    { "<leader>hd", ":Gitsigns diffthis<CR>", mode = "n", desc = "Diff This" },
    { "<leader>hD", function() require("gitsigns").diffthis("~") end, mode = "n", desc = "Diff This ~" },
    { "<leader>td", ":Gitsigns toggle_deleted<CR>", mode = "n", desc = "Toggle Deleted" },

    -- Text object
    { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Select Hunk" },
  },
}
