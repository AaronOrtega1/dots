-- Set up autocmd to disable Copilot in specific directories
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local current_path = vim.fn.expand("%:p:h") -- Get current file's directory
    local target_path = "/home/aarondev/Documents/Code/PersonalProjects/JobSeek"

    -- Check if current path is within the target directory
    if string.find(current_path, target_path, 1, true) then
      vim.g.copilot_enabled = false -- Disable Copilot
      print("Copilot disabled")
    else
      vim.g.copilot_enabled = true -- Re-enable elsewhere
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    require("luasnip.loaders.from_lua").load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })
  end,
})
