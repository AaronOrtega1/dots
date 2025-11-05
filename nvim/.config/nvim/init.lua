-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
require 'config.options'

-- [[ Basic Keymaps ]]
require 'config.keymaps'

-- [[ Basic autocmds ]]
require 'config.autocmds'

-- [[ Install `lazy.nvim` plugin manager and install plugins ]]
require 'aarondev'
