if vim.g.vscode then
  vim.opt.clipboard = "unnamedplus"
  vim.o.cmdheight = 10
  return
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
