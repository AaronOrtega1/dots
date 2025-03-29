return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "stevearc/conform.nvim", -- Para formateo
      "mfussenegger/nvim-dap", -- Para debugging
      "L3MON4D3/LuaSnip", -- Para snippets
    },
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        tsserver = {},
        html = {},
        cssls = {},
        tailwindcss = {
          filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
            "templ",
            "markdown",
            "astro",
            "php",
            "blade",
          },
          init_options = {
            userLanguages = {
              html = "html",
              javascript = "javascript",
              javascriptreact = "javascriptreact",
              typescript = "typescript",
              typescriptreact = "typescriptreact",
            },
          },
          handlers = {
            ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
              vim.schedule(function()
                local response = vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
              end)
            end,
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "tw`([^`]*)",
                  'tw="([^"]*)',
                  'tw={"([^"}]*)',
                  "tw\\.\\w+`([^`]*)",
                  "tw\\(.*?\\)`([^`]*)",
                },
              },
              validate = true,
            },
          },
        },
        eslint = {},
      },
      setup = {
        mason = {
          ensure_installed = {
            -- Python
            "pyright",
            "black",
            "isort",
            "debugpy",
            "ruff-lsp",
            -- JS/TS
            "typescript-language-server",
            "eslint-lsp",
            "prettier",
            -- HTML/CSS/Tailwind
            "html-lsp",
            "css-lsp",
            "tailwindcss-language-server",
            -- Otros
            "luacheck",
            "shellcheck",
            "shfmt",
            "js-debug-adapter",
          },
        },
      },
    },
  },
}
