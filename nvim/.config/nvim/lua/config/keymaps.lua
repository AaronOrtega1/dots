local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Cambiar búsqueda de archivos
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Buscar archivo en CWD" })
vim.keymap.set(
  "n",
  "<leader>fF",
  "<cmd>Telescope find_files cwd=function() return vim.fn.getcwd(vim.fn.finddir('.git', vim.fn.getcwd() .. ';')) end<CR>",
  { desc = "Buscar archivo en root" }
)

-- Cambiar búsqueda de palabras
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Buscar palabra en CWD" })
vim.keymap.set(
  "n",
  "<leader>sG",
  "<cmd>Telescope live_grep cwd=function() return vim.fn.getcwd(vim.fn.finddir('.git', vim.fn.getcwd() .. ';')) end<CR>",
  { desc = "Buscar palabra en root" }
)

-- toggle folds
vim.api.nvim_set_keymap("n", "za", "za", { noremap = true, silent = true })

-- dismiss noice
vim.api.nvim_set_keymap("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { noremap = true, silent = true })
