return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'nvim-mini/mini.icons', opts = {} },
  lazy = false,
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
    },
    float = {
      padding = 2,
      max_width = 0.8,
      max_height = 0.8,
      border = 'rounded',
      win_options = { winblend = 0 },
    },
    keymaps = {
      ['q'] = { 'actions.close', mode = 'n' },
      ['<esc>'] = { 'actions.close', mode = 'n' },
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['<C-a>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-r>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    },
    use_default_keymaps = false,
  },
}
