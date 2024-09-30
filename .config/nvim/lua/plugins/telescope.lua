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
    { "<leader>ac", "<cmd>Telescope find_files prompt_title=Controllers cwd=app/controllers/ hidden=true<cr>" },
    { "<leader>am", "<cmd>Telescope find_files prompt_title=Models cwd=app/models/ hidden=true<cr>" },
    { "<leader>at", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/ hidden=true<cr>" },
    { "<leader>af", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/factories hidden=true<cr>" },
    { "<leader>av", "<cmd>Telescope find_files prompt_title=Views cwd=app/views hidden=true<cr>" },
  }
}
