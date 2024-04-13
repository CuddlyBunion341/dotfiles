return {
  {
    "akinsho/bufferline.nvim",
    config = {
      options = {
        separator_style = "thin",
        always_show_bufferline = false,
        color_icons = false,
        show_buffer_icons = false,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
      },
    },
  },
}
