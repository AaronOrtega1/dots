return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local icons = {
      diagnostics = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      },
      git = {
        added = ' ',
        modified = ' ',
        removed = ' ',
      },
    }

    require('lualine').setup {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = icons.diagnostics,
            update_in_insert = false,
            always_visible = true,
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          {
            'filename',
            path = 1, -- relative path
            symbols = { modified = ' ', readonly = ' ', unnamed = '' },
          },
        },
        lualine_x = {
          {
            function()
              local ok, dap = pcall(require, 'dap')
              if ok and dap.status() ~= '' then
                return '  ' .. dap.status()
              end
              return ''
            end,
            cond = function()
              return package.loaded['dap']
            end,
            color = { fg = '#c678dd' },
          },
          {
            'diff',
            symbols = icons.git,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },
      extensions = { 'neo-tree', 'fzf' },
    }
  end,
}
