local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local lspconfig = require("lspconfig")

-- Configuración común para todos los LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- required by nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Configuración de autocomandos para LSP (igual que antes)
-- ... [mantén toda la parte de LspAttach autocmd igual] ...

-- Configuración específica para cada LSP
require("mason-lspconfig").setup_handlers({
  -- Configuración por defecto para todos los LSP
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,

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
      capabilities = merged_capability,
      settings = {
        pyright = {
          disableOrganizeImports = true,
          disableTaggedHints = false,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "standard",
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              deprecateTypingAliases = false,
            },
            inlayHints = {
              callArgumentNames = "partial",
              functionReturnTypes = true,
              pytestParameters = true,
              variableTypes = true,
            },
          },
        },
      },
    })
  end,

  -- Cambiado de ruff_lsp a ruff
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
