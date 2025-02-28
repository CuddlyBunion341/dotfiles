return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
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
      defaults = {
        file_ignore_patterns = { ".git/" }, -- Ignore the .git directory
        mappings = {
          n = {
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
          }
        }
      }
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
    { "<C-p>",     "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-b>",     "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
    { "<leader>C",     "<cmd>Telescope commands<cr>", desc = "Find commands" },
    { "<C-s>",     "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols" },
    { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files" },
    -- { "<leader>e", "<cmd>Telescope find_files hidden=false<cr>", desc = "Find all files" },
    { "<leader>w", "<cmd>Telescope live_grep<cr>", desc = "Find substring" },
    { "<leader>r", function()
      local current_word = vim.fn.expand("<cword>")
      require("telescope.builtin").grep_string({ search = current_word })
    end },
    { "<leader>cc", "<cmd>Telescope git_commits<cr>", desc = "Find git commits" },
    { "<leader>ac", "<cmd>Telescope find_files prompt_title=Controllers cwd=app/controllers/ hidden=true<cr>", desc = "Find Rails controllers" },
    { "<leader>ah", "<cmd>Telescope find_files prompt_title=Controllers cwd=app/helpers/ hidden=true<cr>", desc = "Find Rails helpers" },
    { "<leader>am", "<cmd>Telescope find_files prompt_title=Models cwd=app/models/ hidden=true<cr>", desc = "Find Rails models" },
    { "<leader>at", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/ hidden=true<cr>", desc = "Find Rails specs" },
    { "<leader>af", "<cmd>Telescope find_files prompt_title=Specs cwd=spec/factories hidden=true<cr>", desc = "Find Rails factories" },
    { "<leader>av", "<cmd>Telescope find_files prompt_title=Views cwd=app/views hidden=true<cr>", desc = "Find Rails views" },
    { "<leader>l",  "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols" },
  }
}
