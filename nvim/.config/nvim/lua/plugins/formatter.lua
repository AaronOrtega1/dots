return {
  { -- Linting
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },  -- 'eslint_d' is faster than 'eslint'
        typescript = { "eslint_d" },
        python = { "pylint" },
      },
    },
  },
  { -- Formateo (compatible with LazyVim)
    "stevearc/conform.nvim",
    event = "LazyFile",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },  -- 'prettierd' is faster than 'prettier'
        typescript = { "prettierd" },
        python = { "black" },
        html = { "prettierd" },
        css = { "prettierd" },
        lua = { "stylua" },  -- Added since LazyVim expects this
      },
    },
  },
}
