return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lista de LSP servers que quieres instalar automáticamente
        "pyright",
        "ruff-lsp",
        "ltex-ls",
        "clangd",
        "vim-language-server",
        "bash-language-server",
        "lua-language-server",
        -- Puedes agregar más servidores aquí según tus necesidades
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
