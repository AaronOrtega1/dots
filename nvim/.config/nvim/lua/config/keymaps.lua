-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true }
local opts_silent = { noremap = true }

keymap.set("n", "<Leader>;", ":", { noremap = true, desc = "Enter Command Line" })

-- Save all file with <C-s>
keymap.set("n", "<C-s>", ":wa<Return>", { noremap = true, desc = "Save all files", silent = true })

-- Toggle folding with za in normal mode
keymap.set("n", "za", "za", opts)
