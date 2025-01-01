return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/127.0.0.1/",
      },
      {
        name = "test-nvim",
        path = "~/Documents/test-nvim/",
      },
    },

    -- Completion
    completion = {
      -- Set to false to disable
      nvim_cmp = true,

      -- Trigger completion at 2 chars
      min_chars = 2,
    },

    -- Templates
    templates = {
      folder = "5 - Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    daily_notes = {
      -- Daily notes directory
      folder = "6 - Daily Notes",
      -- File name format
      date_format = "%Y-%m-%d",
      -- Template
      template = "5 - Templates/Daily Note Template",
    },

    -- URL
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart({"open", url})  -- Mac OS
      vim.fn.jobstart({ "xdg-open", url }) -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      -- vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    -- Specify how to handle attachments.
    attachments = {
      -- Folder where attachments are stored.
      img_folder = "3 - Resources/Assets",
    },
  },
}
