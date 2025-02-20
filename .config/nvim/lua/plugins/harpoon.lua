return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>e", function() harpoon:list():remove() end, { noremap = true, silent = true })
    -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Tab>", function() harpoon:list():next() end)
    vim.keymap.set("n", "<SC-Tab>", function() harpoon:list():prev() end)
  end
}
