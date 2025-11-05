return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local map = vim.keymap.set
    local harpoon = require 'harpoon'
    local ignore_wk = { desc = 'which_key_ignore' }

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    map('n', '<leader>a', function()
      harpoon:list():add()
    end, ignore_wk)
    map('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    map('n', '<leader>1', function()
      harpoon:list():select(1)
    end, ignore_wk)
    map('n', '<leader>2', function()
      harpoon:list():select(2)
    end, ignore_wk)
    map('n', '<leader>3', function()
      harpoon:list():select(3)
    end, ignore_wk)
    map('n', '<leader>4', function()
      harpoon:list():select(4)
    end, ignore_wk)

    map('n', '<leader>xa', function()
      require('harpoon'):list():clear()
    end, { desc = 'Clear Harpoon List' })

    -- Toggle previous & next buffers stored within Harpoon list
    map('n', '<C-p>', function()
      harpoon:list():prev()
    end)
    map('n', '<C-n>', function()
      harpoon:list():next()
    end)
  end,
}
