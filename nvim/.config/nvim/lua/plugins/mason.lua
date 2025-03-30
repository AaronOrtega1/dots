return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Recommended for formatters/linters
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",       -- Correct name for TypeScript/JavaScript (not "ts_ls")
        "html",
        "cssls",
        "tailwindcss",
        "pyright",
        "emmet_ls",
        "lua_ls",
      },
      automatic_installation = true,
    })

    -- Optional: Install formatters and linters
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "prettierd",
        "stylua",
        "black",
        -- Linters
        "eslint_d",
        "pylint",
      },
    })
  end
}
