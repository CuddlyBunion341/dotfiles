# Nvim Config

This is my own nvim config.

It is strongly opinionated and tailored to my own needs.
    
## Overview

I have been using Neovim as my primary editor for a while now and I have been customizing it to my own needs, adding and removing plugins, and tweaking settings to make it more efficient and productive.
The entry point for the configuration is `init.lua`, which loads the rest of the configuration. The configuration is split into some files under the `lua` directory. Lazy plugins can also be found there.

### Repository Files

Here are some of the key files in the repository:

- `./lua/util.lua`: Contains utility functions used across the configuration.
- `./lua/theme.lua`: Contains theme settings and customizations.
- `./lua/settings.lua`: Contains general settings for Neovim.

### Plugins

I am using the lazyvim plugin manager to manage plugins.
[Lazyvim](https://github.com/folke/lazy.nvim) is a plugin manager that loads plugins lazily, only when they are needed.


#### File Exploring
- **bufexplorer**: Buffer explorer / picker.
- **Nvim-tree**: A file explorer tree.

#### Autocompletion
- **nvim-cmp**: Autocompletion framework.
- **LuaSnip**: Snippet engine.
- **cmp-buffer**: Buffer source for nvim-cmp.
- **cmp-cmdline**: Cmdline source for nvim-cmp.
- **cmp-nvim-lsp**: LSP source for nvim-cmp.
- **cmp-path**: Filepath source for nvim-cmp.
- **cmp_luasnip**: LuaSnip source for nvim-cmp.
- **friendly-snippets**: Preconfigured snippets for nvim-cmp.

#### Navigation
- **vim-tmux-navigator**: Seamless navigation between tmux panes and vim splits.
- **vim-visual-multi**: Multiple cursors plugin.
- **nvim-surround**: Surroundings operations (add, change, delete).
- **nvim-treesitter-textobjects**: Advanced textobjects based on treesitter.
- **nvim-treesitter-endwise**: Endwise motion based on treesitter.

#### FZF (Fuzzy Finder)
- **telescope.nvim**: Highly extendable fuzzy finder over lists.

#### Git
- **gitsigns.nvim**: Git signs (add, change, delete) in the sign column.
- **lazygit.nvim**: Terminal UI for git commands.
- **diffview.nvim**: Side-by-side diff viewer for git in Neovim.

#### Other
- **copilot.vim**: AI pair programming assistant.
- **neotest-rspec**: RSpec test runner.
- **nvim-lspconfig**: Quickstart configurations for the Nvim LSP client.
- **nvim-treesitter**: Parser generator tool and an incremental parsing library.
- **nvim-spectre**: Search and replace tool.
- **auto-session**: Automatic session save and restore.
- **autoclose.nvim**: Auto close pairs of brackets and quotes.
- **markdown.nvim**: Markdown support.
- **plantuml-previewer.vim**: PlantUML previewer.
- **solarized.nvim**: Solarized color scheme.
- **tokyodark.nvim**: Tokyo Night color scheme.

