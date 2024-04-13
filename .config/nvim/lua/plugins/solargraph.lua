return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        solargraph = {
          settings = {
            solargraph = {
              autoformat = true,
              -- bundlerPath = "bundle",
              diagnostics = true,
              completion = true,
              formatting = true,
              definitions = true,
            },
          },
        },
      },
    },
  },
}
