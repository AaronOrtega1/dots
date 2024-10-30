return {
  "github/copilot.vim",
  config = function()
    -- Configuración opcional para Copilot
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<A-l>", "copilot#Accept()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
