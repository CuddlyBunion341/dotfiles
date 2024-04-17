return {
  {
    "tpope/vim-dispatch",
  },
  {
    "NvChad/nvim-colorizer.lua",
    setup = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
          cmp_docs = { always_update = true },
        },
      })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "dstein64/vim-startuptime",
  },
}
