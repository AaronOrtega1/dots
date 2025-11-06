-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- [[ Load configs (keymaps, options, autocmds) ]]
require 'config'

-- [[ Install `lazy.nvim` plugin manager and install plugins ]]
require 'aarondev'
