-- [[ Basic Autocommands ]]
local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup('aarondev_' .. name, { clear = true })
end

-- Disable autoformat for markdown files
autocmd({ 'FileType' }, {
  group = augroup 'markdown',
  pattern = { 'markdown' },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Underline misspelled words en/es
autocmd('FileType', {
  group = augroup 'markdown_spell',
  pattern = { 'markdown' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en,es'
  end,
})

-- Python print
autocmd({ 'FileType', 'BufEnter', 'BufWinEnter' }, {
  group = augroup 'python',
  pattern = { 'python' },
  callback = function()
    vim.keymap.set('n', '<leader>cl', function()
      local var = vim.fn.expand '<cword>'
      if var ~= '' then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local indent = vim.api.nvim_get_current_line():match '^%s*' or ''
        local debug_line = indent .. 'print(f"[L#{' .. row .. '}] ' .. var .. ': { ' .. var .. ' }")'
        vim.api.nvim_buf_set_lines(0, row, row, false, { debug_line })
      end
    end, { buffer = true, desc = 'Python debug print' })
  end,
})

-- Java print
autocmd({ 'FileType', 'BufEnter', 'BufWinEnter' }, {
  group = augroup 'javascript',
  pattern = { 'java' },
  callback = function()
    vim.keymap.set('n', '<leader>cl', function()
      local var = vim.fn.expand '<cword>'
      if var ~= '' then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local indent = vim.api.nvim_get_current_line():match '^%s*' or ''
        local debug_line = indent .. 'System.out.println("' .. var .. ' [L' .. row .. ']: " + ' .. var .. ');'
        vim.api.nvim_buf_set_lines(0, row, row, false, { debug_line })
      end
    end, { buffer = true, desc = '[C]print[L]n' })
  end,
})

-- javascript console.log
autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.keymap.set('n', '<leader>cl', function()
      local var = vim.fn.expand '<cword>'
      if var ~= '' then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local indent = vim.api.nvim_get_current_line():match '^%s*' or ''
        local debug_line = indent .. 'console.log(`[L#${' .. row .. '}] ' .. var .. ': `, ' .. var .. ');'
        vim.api.nvim_buf_set_lines(0, row, row, false, { debug_line })
      end
    end, { buffer = true, desc = '[C]onsole [L]og' })
  end,
})

-- Markdown bold
autocmd('FileType', {
  group = augroup 'markdown',
  pattern = 'markdown',
  callback = function()
    -- In visual mode, with words selected
    vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', {
      buffer = true,
      desc = 'Wrap selection with ** for bold',
    })

    -- In normal mode
    vim.keymap.set('n', '<C-b>', 'viwc**<C-r>"**<Esc>', {
      buffer = true,
      desc = 'Wrap word with ** for bold',
    })
  end,
})

-- Markdown italic
autocmd('FileType', {
  group = augroup 'markdown',
  pattern = 'markdown',
  callback = function()
    -- In visual mode, with words selected
    vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', {
      buffer = true,
      desc = 'Wrap selection with * for italic',
    })

    -- In normal mode
    vim.keymap.set('n', '<C-i>', 'viwc*<C-r>"*<Esc>', {
      buffer = true,
      desc = 'Wrap word with * for italic',
    })
  end,
})
