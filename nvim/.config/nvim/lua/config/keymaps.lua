local map = vim.keymap.set
local ignore_wk = { desc = 'which_key_ignore' }

-- [[ Basic Keymaps ]]

map('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <Esc> in normal mode
-- map('n', '<leader>e', ':Ex<CR>', { desc = 'which_key_ignore', silent = true }) -- Open Netrw
map('n', '<leader>;', ':', ignore_wk) -- Easy way to input commands
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>wa<cr><esc>', { desc = 'Save Files' }) -- Save files
map('n', '<leader>qq', '<cmd>qa<cr>', ignore_wk) -- Quit all
map('n', '<leader>wd', '<C-W>c', { desc = '[W]indow [D]elete' }) -- Delete window

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = '[L]azy' }) -- lazy

-- Better moving lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Center cursor when jumping
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- better indenting
map('x', '<', '<gv')
map('x', '>', '>gv')

map('x', '<leader>p', [["_dP]], ignore_wk) -- Paste over a selection without losing your current yank.

-- OIL (trying)
map('n', '<leader>e', function()
  require('oil').open_float(vim.fn.expand '%:p:h')
end, { desc = '[E]xplorer', silent = true })
