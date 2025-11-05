return {
  {
    'folke/snacks.nvim',
    dependencies = {
      { 'nvim-mini/mini.icons' },
    },
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      notifier = { enabled = true },
      explorer = { enabled = false },
      picker = {
        enabled = true,
        -- sources = {
        --   explorer = {
        --     layout = {
        --       layout = {
        --         width = 30,
        --         min_width = 30,
        --         position = 'right',
        --       },
        --     },
        --   },
        -- },
      },

      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[

 █████╗  █████╗ ██████╗  ██████╗ ███╗   ██╗██████╗ ███████╗██╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██╔═══██╗████╗  ██║██╔══██╗██╔════╝██║   ██║
███████║███████║██████╔╝██║   ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║
██╔══██║██╔══██║██╔══██╗██║   ██║██║╚██╗██║██║  ██║██╔══╝  ╚██╗ ██╔╝
██║  ██║██║  ██║██║  ██║╚██████╔╝██║ ╚████║██████╔╝███████╗ ╚████╔╝ 
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝  ╚═══╝  

[TIP: To exit Neovim, just power off your computer.]
        ]],
          keys = {
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          },
        },
      },
    },
    keys = {
      {
        '<leader><space>',
        function()
          Snacks.picker.files()
        end,
        desc = '[F]ind [F]iles',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = '[F]ind [F]iles',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = '[F]ind [F]iles ([g]it-files)',
      },
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[F]ind [B]uffers',
      },
      {
        '<leader>fp',
        function()
          Snacks.picker.projects()
        end,
        desc = '[F]ind [P]rojects',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[S]earch [G]rep',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },

      -- {
      --   '<leader>e',
      --   function()
      --     Snacks.explorer()
      --   end,
      --   desc = '[E]xplorer',
      -- },
    },
  },
}
