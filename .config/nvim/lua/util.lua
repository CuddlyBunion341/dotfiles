local function get_current_line()
  return vim.api.nvim_get_current_line()
end

local function extract_attribute_name(line)
  return line:match("%s*(%w+)%s*;")
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

local numbertoggle_group = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = numbertoggle_group,
  pattern = "*",
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = numbertoggle_group,
  pattern = "*",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

function toggle_terminal()
  local term_bufnr = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      term_bufnr = bufnr
      break
    end
  end

  if term_bufnr then
    vim.api.nvim_buf_delete(term_bufnr, { force = true })
  else
    vim.cmd("vsplit | terminal")
  end
end

vim.keymap.set("n", "<C-.>", toggle_terminal, { noremap = true, silent = true })
