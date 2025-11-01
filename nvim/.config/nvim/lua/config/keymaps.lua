vim.keymap.set("n", "<Leader>;", ":", { noremap = true, desc = "Enter Command Line" })

-- Save all file with <C-s>
vim.keymap.set("n", "<C-s>", ":wa<Return>", { noremap = true, desc = "Save all files", silent = true })

-- Toggle folding with za in normal mode
vim.keymap.set("n", "za", "za", { noremap = true })

-- Esc from Insert mode with jj
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Escape insert mode", silent = true })

-- Center cursor when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Center cursor when <C-d>", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Center cursor when <C-d>", silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better moving lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection down", silent = true })

-- Paste without losing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
