-- init.lua
local is_vscode = vim.fn.exists("g:vscode") == 1 or os.getenv("VSCODE_NVIM") ~= nil

if not is_vscode then
  require("config.lazy")
else
  require("config.vscode")
end
