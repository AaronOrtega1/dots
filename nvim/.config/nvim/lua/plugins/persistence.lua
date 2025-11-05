return { -- Session manager
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore [s]ession" },
    { "<leader>qS", function() require("persistence").select() end,desc = "Select [S]ession" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore [L]ast Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "[D]on't Save Current Session" },
  },
}
