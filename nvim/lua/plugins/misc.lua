return {
  {
    -- "stevearc/oil.nvim", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
    "jelmansouri/oil.nvim", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
    branch = "feat/scratch-preview", -- revert to original repository once https://github.com/stevearc/oil.nvim/issues/435 is resolved
    dependencies = {
      { "nvim-mini/mini.icons", opts = {} },
      { "refractalize/oil-git-status.nvim" },
    },
    lazy = true, -- nvim /dir/name does not work otherwise
    cmd = { "Oil" },
    config = function()
      require("oil").setup({
        columns = {},
        win_options = {
          signcolumn = "yes:2",
        },
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = true,
        watch_for_changes = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-p>"] = "actions.preview",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["gs"] = "actions.change_sort",
          ["<C-o>"] = {
            "actions.open_cmdline",
            opts = {
              modify = ":! open",
            },
            desc = "Open file",
          },
          ["K"] = "actions.preview_scroll_up",
          ["J"] = "actions.preview_scroll_down",
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
        },
        lsp_file_methods = {
          enabled = true,
        },
      })
    end,
  },
  { "mg979/vim-visual-multi", lazy = false },
}
