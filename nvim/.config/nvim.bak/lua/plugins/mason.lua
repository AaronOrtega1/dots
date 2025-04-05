return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "vim-language-server",
        "bash-language-server",
        "pyright",
        "ruff-lsp",
        "clangd",
        "typescript-language-server",
        "eslint-lsp",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        "json-lsp",
        "prettier",
        "marksman",
        "yaml-language-server",
        "prisma-language-server",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = true, -- Instala automáticamente los LSP configurados
    },
  },
}
