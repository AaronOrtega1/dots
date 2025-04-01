local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local lspconfig = require("lspconfig")

-- Configuración de diagnósticos (similar a LazyVim)
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Cambia el símbolo delante del error
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Configuración común para todos los LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- required by nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Mejora las capacidades con cmp_nvim_lsp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Configuración de autocomandos para LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Mapeos de teclado comunes
    local opts = { buffer = bufnr, silent = true }

    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

-- Configuración específica para cada LSP
require("mason-lspconfig").setup_handlers({
  -- Configuración por defecto para todos los LSP
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,

  --- #############################################
  --- PYTHON
  --- #############################################
  ["pyright"] = function()
    local new_capability = {
      textDocument = {
        publishDiagnostics = {
          tagSupport = {
            valueSet = { 2 },
          },
        },
        hover = {
          contentFormat = { "plaintext" },
          dynamicRegistration = true,
        },
      },
    }
    local merged_capability = vim.tbl_deep_extend("force", capabilities, new_capability)

    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportGeneralTypeIssues = "error",
              reportOptionalMemberAccess = "warning",
            },
          },
        },
      },
      on_attach = function(client, bufnr)
        -- Configuración adicional para Pyright
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })
  end,

  ["ruff"] = function()
    lspconfig.ruff.setup({
      init_options = {
        settings = {
          organizeImports = true,
        },
      },
      -- Deshabilitar hover ya que Pyright lo maneja mejor
      capabilities = {
        hoverProvider = false,
      },
    })
  end,

  --- #############################################
  --- FRONTEND
  --- #############################################
  ["ts_ls"] = function()
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })
  end,

  ["eslint"] = function()
    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })
  end,

  ["html"] = function()
    lspconfig.html.setup({
      capabilities = capabilities,
      filetypes = { "html", "templ" },
    })
  end,

  ["cssls"] = function()
    lspconfig.cssls.setup({
      capabilities = capabilities,
    })
  end,

  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "templ",
      },
      init_options = {
        userLanguages = {
          templ = "html",
        },
      },
    })
  end,

  ["emmet_ls"] = function()
    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { "html", "css", "javascriptreact", "typescriptreact", "templ" },
    })
  end,

  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,

  ["prismals"] = function()
    lspconfig.prismals.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Configuraciones específicas para Prisma
        client.server_capabilities.documentFormattingProvider = true
      end,
      settings = {
        prisma = {
          -- Opciones adicionales (opcional)
          prismaFmtBinPath = vim.fn.exepath("prisma-fmt"), -- Asegúrate de tener prisma-fmt instalado
        },
      },
    })
  end,

  --- #############################################
  --- OTROS LENGUAJES
  --- #############################################

  ["ltex"] = function()
    lspconfig.ltex.setup({
      filetypes = { "text", "plaintex", "tex", "markdown" },
      settings = {
        ltex = {
          language = "en",
        },
      },
      flags = { debounce_text_changes = 300 },
    })
  end,

  ["clangd"] = function()
    lspconfig.clangd.setup({
      filetypes = { "c", "cpp", "cc" },
      flags = {
        debounce_text_changes = 500,
      },
    })
  end,

  ["vimls"] = function()
    lspconfig.vimls.setup({
      flags = {
        debounce_text_changes = 500,
      },
    })
  end,

  ["bashls"] = function()
    lspconfig.bashls.setup({})
  end,

  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          hint = {
            enable = true,
          },
        },
      },
    })
  end,
})
