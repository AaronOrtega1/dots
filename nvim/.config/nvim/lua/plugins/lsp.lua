-- LSP Plugins
return {
  { -- Configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('aarondev-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end
          map('gd', vim.lsp.buf.definition, 'Goto [D]efinition')
          map('gr', vim.lsp.buf.references, 'Goto [R]eferences')
          map('gi', vim.lsp.buf.implementation, 'Goto [I]mplementation')
          map('gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
          map('gy', vim.lsp.buf.type_definition, 'Goto T[y]pe Definition')
          map('K', function()
            return vim.lsp.buf.hover()
          end, '[K]Hover')
          map('<leader>ca', vim.lsp.buf.code_action, 'Goto Code [A]ction', { 'n', 'x' })

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('aarondev-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('aarondev-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'aarondev-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- Enable the following language servers
      local servers = {
        -- Python
        pyright = {},
        -- JavaScript/TypeScript
        ts_ls = {},
        -- HTML
        html = {},
        -- CSS
        cssls = {},
        -- Tailwind
        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = { ['typescript'] = 'javascript', ['typescriptreact'] = 'html', ['svelte'] = 'html' },
              lint = { cssConflict = 'warning' },
            },
          },
        },
        -- Java
        jdtls = {},
        -- Bash/Shell
        bashls = {},
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }
      -- Ensure the servers and tools above are installed
      local mason_packages = {
        pyright = 'pyright',
        ts_ls = 'typescript-language-server',
        html = 'html-lsp',
        cssls = 'css-lsp',
        jdtls = 'jdtls',
        bashls = 'bash-language-server',
        lua_ls = 'lua-language-server',
      }
      local ensure_installed = {}
      for lsp_name, mason_name in pairs(mason_packages) do
        if servers[lsp_name] then
          table.insert(ensure_installed, mason_name)
        end
      end
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'prettier', -- JS, HTML, CSS formatter
        'black', -- Python formatter
        'google-java-format', -- Java formatter
        'shfmt', -- Bash formatter
        'tailwindcss', -- Tailwind to colorize
        'markdownlint', -- Obsidian note taking
        'docker-language-server', -- Docker files
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (aarondev config populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
