-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set up autocmd to disable Copilot in specific directories
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local current_path = vim.fn.expand("%:p:h") -- Get current file's directory
    local target_path = "/home/aarondev/Documents/Code/PersonalProjects/JobSeek/70leetCodeProblems"

    -- Check if current path is within the target directory
    if string.find(current_path, target_path, 1, true) then
      vim.g.copilot_enabled = false -- Disable Copilot
      print("Copilot disabled")
    else
      vim.g.copilot_enabled = true -- Re-enable elsewhere
    end
  end,
})
