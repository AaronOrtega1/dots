return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true

    -- Desactivar Copilot para archivos markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.b.copilot_enabled = false
      end,
    })

    -- Desactivar Copilot si estás en un path específico
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local path = vim.fn.getcwd() -- Obtiene el path actual
        if path:match("$HOME/Documents/Code/PersonalProjects/*") then
          vim.g.copilot_enabled = false
        else
          vim.g.copilot_enabled = true
        end
      end,
    })

    -- Mapeo para aceptar sugerencias
    vim.api.nvim_set_keymap("i", "<A-l>", "copilot#Accept()", { expr = true, silent = true })
  end,
}
