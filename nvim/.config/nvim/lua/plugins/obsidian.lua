return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  event = 'VeryLazy',
  init = function()
    local cwd = vim.loop.cwd()
    if cwd then
      local workspaces = {
        vim.fn.expand '~/Documents/127.0.0.1',
        vim.fn.expand '~/Documents/test-nvim',
      }
      for _, path in ipairs(workspaces) do
        if cwd:find(path, 1, true) then
          vim.schedule(function()
            require('lazy').load { plugins = { 'obsidian.nvim' } }
          end)
          break
        end
      end
    end
  end,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = '127.0.0.1',
        path = '~/Documents/127.0.0.1/',
      },
      {
        name = 'test',
        path = '~/Documents/test-nvim/',
      },
    },
    templates = {
      folder = '06-Scrolls',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },
    legacy_commands = false,
    frontmatter = {
      enabled = false,
    },
    daily_notes = {
      folder = '05-Codex',
      date_format = '%Y-%m-%d',
      template = 'codexEntry.md',
    },
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
  },
  config = function(_, opts)
    require('obsidian').setup(opts)
    local custom_obsidian = require 'plugins.config.obsidian'
    vim.keymap.set('n', '<leader>on', custom_obsidian.create_new_note, { desc = 'Obsidian [N]ote', silent = true })
    vim.keymap.set('n', '<leader>od', ':Obsidian today<CR>', { desc = 'Obsidian Today [D]aily Note', silent = true })
    vim.keymap.set('n', '<leader>ob', ':Obsidian backlinks<CR>', { desc = 'Obsidian [B]acklinks', silent = true })
    vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>', { desc = 'Obsidian [T]ags', silent = true })
    vim.keymap.set('n', '<leader>oo', ':Obsidian open<CR>', { desc = 'Obsidian [O]pen', silent = true })
    vim.keymap.set('n', '<leader>ct', function()
      local line = vim.api.nvim_get_current_line()
      if line:match '^- %[[ x]%]' then
        local new_line = line:gsub('%- %[([ x])%]', function(match)
          return match == ' ' and '- [x]' or '- [ ]'
        end)
        vim.api.nvim_set_current_line(new_line)
      end
    end, { desc = 'Checklist [T]oggle' })
  end,
}
