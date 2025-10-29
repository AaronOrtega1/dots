-- LSP keymaps

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "<leader>cl", false },
        },
      },
    },
  },
}
