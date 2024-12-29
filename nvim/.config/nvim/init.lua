if vim.g.vscode then
  vim.g.clipboard = {
    name = "vscode-clipboard",
    copy = {
      ["+"] = { "call VSCodeNotify('editor.action.clipboardCopyAction')" },
      ["*"] = { "call VSCodeNotify('editor.action.clipboardCopyAction')" },
    },
    paste = {
      ["+"] = { "call VSCodeNotify('editor.action.clipboardPasteAction')" },
      ["*"] = { "call VSCodeNotify('editor.action.clipboardPasteAction')" },
    },
    cache_enabled = 0,
  }
  vim.o.cmdheight = 10
  return
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
