local map = vim.keymap.set
local ignore_wk = { desc = 'which_key_ignore' }

-- [[ Basic Keymaps ]]

map('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <Esc> in normal mode
-- map('n', '<leader>e', ':Ex<CR>', { desc = 'which_key_ignore', silent = true }) -- Open Netrw
map('n', '<leader>;', ':', ignore_wk) -- Easy way to input commands
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>wa<cr><esc>', { desc = 'Save Files' }) -- Save files
map('n', '<leader>qq', '<cmd>qa<cr>', ignore_wk) -- Quit all
map('n', '<leader>wd', '<C-W>c', { desc = 'Window [D]elete' }) -- Delete window
map('i', 'jj', '<Esc>')

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

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = '[L]azy' }) -- lazy

-- Move Lines
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

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

-- Navigate to specific tmux window
vim.keymap.set('n', '<leader>t1', '<cmd>silent !tmux select-window -t 1<CR>', { desc = '[1] Tmux Notes Window' }) -- notes
vim.keymap.set('n', '<leader>t2', '<cmd>silent !tmux select-window -t 2<CR>', { desc = '[2] Tmux Code Window' }) -- code
vim.keymap.set('n', '<leader>t3', '<cmd>silent !tmux select-window -t 3<CR>', { desc = '[3] Tmux Commands Window' }) -- commands

vim.keymap.set('n', '<leader>th', '<cmd>silent !tmux select-window -t 1<CR>', { desc = '[h] Tmux Notes Window' }) -- notes
vim.keymap.set('n', '<leader>tj', '<cmd>silent !tmux select-window -t 2<CR>', { desc = '[j] Tmux Code Window' }) -- code
vim.keymap.set('n', '<leader>tk', '<cmd>silent !tmux select-window -t 3<CR>', { desc = '[k] Tmux Commands Window' }) -- commands
