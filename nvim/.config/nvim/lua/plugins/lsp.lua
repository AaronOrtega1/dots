-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap for LSP diagnosis
    keys[#keys + 1] = { "<leader>cl", false }
  end,
}
