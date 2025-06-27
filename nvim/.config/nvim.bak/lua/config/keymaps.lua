local keymap = vim.keymap
local opts = { noremap = true }

keymap.set("n", "<Leader>;", ":", { noremap = true, desc = "Enter Command Line" })

-- Save all file with <C-s>
keymap.set("n", "<C-s>", ":wa<Return>", { noremap = true, desc = "Save all files", silent = true })

-- Toggle folding with za in normal mode
keymap.set("n", "za", "za", opts)

keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Save all files", silent = true })
