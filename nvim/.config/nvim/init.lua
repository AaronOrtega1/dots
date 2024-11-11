-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.fn.exists("g:vscode") == 0 then
  vim.lsp.buf.clear_references()
end
