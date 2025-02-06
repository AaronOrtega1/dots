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
    ui = { enble = false },
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/127.0.0.1/",
      },
      {
        name = "test-nvim",
        path = "~/Documents/NVIM-vault/",
      },
    },

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "markdown",
    -- Deshabilitar metadatos
    disable_frontmatter = true,

    -- Completion
    completion = {
      -- Set to false to disable
      nvim_cmp = false,

      -- Trigger completion at 2 chars
      min_chars = 2,
    },

    -- Templates
    templates = {
      folder = "5-Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    daily_notes = {
      -- Daily notes directory
      folder = "6-Journal",
      -- File name format
      date_format = "%Y-%m-%d",
      -- Template
      template = "5-Templates/Daily Note Template",
    },

    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title has " ", replace it with "-"
        title = string.gsub(title, " ", "-")
        -- If title is given, transform it into valid file name.
        return tostring(os.time()) .. "-" .. title
        -- return title
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      if note.metadata then
        return note.metadata
      end
      return {}
    end,

    mappings = {
      -- Obsidian Follow
      ["<leader>gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
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
      img_folder = "3-Resources/Assets",
    },
  },
}
