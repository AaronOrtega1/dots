return { -- Fully-featured REST Client Interface for Neovim.
  'mistweaverco/kulala.nvim',
  ft = 'http',
  keys = {
    { '<leader>Rb', "<cmd>lua require('kulala').scratchpad()<cr>", desc = 'Open scratchpad' },
    { '<leader>Rc', "<cmd>lua require('kulala').copy()<cr>", desc = 'Copy as [c]URL', ft = 'http' },
    { '<leader>RC', "<cmd>lua require('kulala').from_curl()<cr>", desc = 'Paste from curl', ft = 'http' },
    { '<leader>Re', "<cmd>lua require('kulala').set_selected_env()<cr>", desc = 'Set [E]nvironment', ft = 'http' },
    {
      '<leader>Rg',
      "<cmd>lua require('kulala').download_graphql_schema()<cr>",
      desc = 'Download [G]raphQL schema',
      ft = 'http',
    },
    { '<leader>Ri', "<cmd>lua require('kulala').inspect()<cr>", desc = '[I]nspect current request', ft = 'http' },
    { '<leader>Rn', "<cmd>lua require('kulala').jump_next()<cr>", desc = 'Jump to [n]ext request', ft = 'http' },
    { '<leader>Rp', "<cmd>lua require('kulala').jump_prev()<cr>", desc = 'Jump to [p]revious request', ft = 'http' },
    { '<leader>Rq', "<cmd>lua require('kulala').close()<cr>", desc = 'Close window', ft = 'http' },
    { '<leader>Rr', "<cmd>lua require('kulala').replay()<cr>", desc = '[R]eplay the last request' },
    { '<leader>Rs', "<cmd>lua require('kulala').run()<cr>", desc = '[S]end the request', ft = 'http' },
    { '<leader>RS', "<cmd>lua require('kulala').show_stats()<cr>", desc = 'Show stats', ft = 'http' },
    { '<leader>Rt', "<cmd>lua require('kulala').toggle_view()<cr>", desc = 'Toggle headers/body', ft = 'http' },
  },
  opts = {
    ui = {
      display_mode = 'float',
      icons = {
        inlay = {
          loading = '󰔟',
          done = '',
          error = '',
        },
      },
    },
  },
}
