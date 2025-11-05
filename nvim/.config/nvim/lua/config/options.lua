-- [[ Setting options ]]
local opts = vim.o
local global = vim.g

-- Line numbers and relative numbers by default
opts.number = true
opts.relativenumber = true

-- Tab config
opts.tabstop = 2
opts.softtabstop = 2
opts.shiftwidth = 2
opts.expandtab = true

-- Enable mouse mode
opts.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opts.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  opts.clipboard = 'unnamedplus'
end)

-- Enable break indent
opts.breakindent = true
opts.linebreak = true

-- Save undo history
opts.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opts.ignorecase = true
opts.smartcase = true

-- Keep signcolumn on by default
-- opts.signcolumn = 'no'

-- Decrease update time
opts.updatetime = 50

-- Decrease mapped sequence wait time
opts.timeoutlen = 300

-- Configure how new splits should be opened
opts.splitright = true
opts.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opts.list = false

-- Preview substitutions live, as you type!
opts.inccommand = 'split'

-- Show which line your cursor is on
opts.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opts.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
opts.confirm = true

-- autoread
opts.autoread = true

opts.jumpoptions = 'view'
opts.termguicolors = true -- True color support

-- [[ Global options ]]

-- Nerd font integration
global.have_nerd_font = true
-- Auto format
global.autoformat = true
