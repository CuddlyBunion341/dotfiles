return {
  'akinsho/toggleterm.nvim', version = "*",
  lazy = false,
  config  = function()
    local Terminal  = require('toggleterm.terminal').Terminal
    local command = "git diff $(git show-branch -a | grep '*' | grep -v $(git rev-parse --abbrev-ref HEAD) | head -n1 | sed 's/^.*\\[\\(.*\\)\\].*/\\1/') | sed 's/[\\^~].*//'"

    local lazygit = Terminal:new({ cmd = command, hidden = true, direction = "float", close_on_exit = true })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
  end
}

