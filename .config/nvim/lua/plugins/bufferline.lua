return {
  {
    "akinsho/bufferline.nvim",
    config = {
      options = {
        separator_style = "slope",
        always_show_bufferline = true,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "🔥" }),
          },
        },
      },
    },
  },
}
