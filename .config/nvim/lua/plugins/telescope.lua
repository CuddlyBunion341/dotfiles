return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>" },
    { "<leader>w", "<cmd>Telescope live_grep<cr>" },
    { "<leader>r", function()
      local current_word = vim.fn.expand("<cword>")
      require("telescope.builtin").grep_string({ search = current_word })
    end },
    { "<leader>c", "<cmd>Telescope git_commits<cr>" },
    { "<leader>ac", "<cmd>Telescope find_files cwd=app/controllers/ hidden=true<cr>" },
    { "<leader>am", "<cmd>Telescope find_files cwd=app/models/ hidden=true<cr>" },
    { "<leader>as", "<cmd>Telescope find_files cwd=app/services/ hidden=true<cr>" },
    { "<leader>at", "<cmd>Telescope find_files cwd=spec/ hidden=true<cr>" },
  }
}
