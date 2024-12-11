return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim", },
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      },
      previewers = {
        qflist = {
          updatetime = 25,
          layout_config = {
            width = 0.75,
            height = 0.75,
          }
        }
      },
    }

    require("telescope").load_extension("ui-select")
    local harpoon = require('harpoon')
    harpoon:setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        layout_strategy = "center",
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
  end,
  keys = {
    { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>" },
    { "<leader>e", "<cmd>Telescope find_files hidden=false<cr>" },
    { "<leader>w", "<cmd>Telescope live_grep<cr>" },
    { "<leader>r", function()
      local current_word = vim.fn.expand("<cword>")
      require("telescope.builtin").grep_string({ search = current_word })
    end },
    { "<leader>cc", "<cmd>Telescope git_commits<cr>" },
    { "<leader>ac", "<cmd>Telescope find_files prompt_title=Controllers cwd=app/controllers/ hidden=true<cr>" },
    { "<leader>ah", "<cmd>Telescope find_files prompt_title=Controllers cwd=app/helpers/ hidden=true<cr>" },
    { "<leader>am", "<cmd>Telescope find_files prompt_title=Models cwd=app/models/ hidden=true<cr>" },
    { "<leader>at", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/ hidden=true<cr>" },
    { "<leader>af", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/factories hidden=true<cr>" },
    { "<leader>av", "<cmd>Telescope find_files prompt_title=Views cwd=app/views hidden=true<cr>" },
    { "<leader>l", "<cmd>Telescope lsp_document_symbols"}
  }
}
