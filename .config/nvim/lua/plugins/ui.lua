return {
  {
    "rcarriga/nvim-notify",
    opts = {
      level = 3,
      render = "minimal",
      stages = "static",
    },
  },
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
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    opts = function(_, opts)
      opts.endwise = { enable = true }
      opts.indent = { enable = true, disable = { "yaml", "ruby" } }
      opts.ensure_installed = {
        "bash",
        "embedded_template",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      }
    end,
  },
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = function()
      local logo = table.concat({
        "  ██████   █████                   █████   █████  ███                   ",
        " ░░██████ ░░███                   ░░███   ░░███  ░░░                    ",
        "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████    ",
        "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███   ",
        "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███   ",
        "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███   ",
        "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████  ",
        " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░   ",
      }, "\n")
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
    --stylua: ignore
    local config = {
      evaluate_single = true,
      header = logo,
      items = {
        new_section("Find file",       "Telescope find_files",                                   "Telescope"),
        new_section("Recent files",    "Telescope oldfiles",                                     "Telescope"),
        new_section("Grep text",       "Telescope live_grep",                                    "Telescope"),
        new_section("Config",          "lua require('lazyvim.util').telescope.config_files()()", "Config"),
        new_section("Extras",          "LazyExtras",                                             "Config"),
        new_section("Lazy",            "Lazy",                                                   "Config"),
        new_section("New file",        "ene | startinsert",                                      "Built-in"),
        new_section("Quit",            "qa",                                                     "Built-in"),
        new_section("Session Restore", [[lua require("persistence").load()]],                    "Session"),
        new_section("VimBeGood",       "VimBeGood",                                              "Training"),
        new_section("Tutor",           "Tutor",                                                  "Training"),
        new_section("Peed Styper",      "Speedtyper",                                             "Training"),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(pad .. "░ ", false),
        starter.gen_hook.aligning("center", "center"),
      },
    }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
