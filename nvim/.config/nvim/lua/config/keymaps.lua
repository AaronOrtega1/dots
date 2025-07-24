local keymap = vim.keymap
local opts = { noremap = true }

keymap.set("n", "<Leader>;", ":", { noremap = true, desc = "Enter Command Line" })

-- Save all file with <C-s>
keymap.set("n", "<C-s>", ":wa<Return>", { noremap = true, desc = "Save all files", silent = true })

-- Toggle folding with za in normal mode
keymap.set("n", "za", "za", opts)
-- Esc from Insert mode with jj
keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Escape insert mode", silent = true })

-- Center cursor line when using <C-d>/<C-u>
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Center cursor when <C-d>", silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Center cursor when <C-d>", silent = true })

-- Better indenting in visual mode
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
