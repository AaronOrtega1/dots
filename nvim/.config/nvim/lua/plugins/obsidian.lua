return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "127.0.0.1",
        path = "~/Documents/127.0.0.1/",
      },
      {
        name = "test",
        path = "~/Documents/test-nvim/",
      },
    },

    templates = {
      folder = "06-Scrolls",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    disable_frontmatter = true,
    -- notes_subdir = "02-Library",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "05-Codex",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "codexEntry.md",
    },

    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    -- new_notes_location = "notes_subdir",

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Load custom function from other file.
    local custom_obsidian = require("plugins.config.obsidian")
    vim.keymap.set("n", "<leader>on", custom_obsidian.create_new_note, { desc = "[O]bsidian [N]ote" })
    vim.keymap.set("n", "<leader>od", ":ObsidianDailies<CR>", { desc = "[O]bsidian [D]aily Note" })
    vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" })
    vim.keymap.set("n", "<leader>ot", ":ObsidianTags<CR>", { desc = "[O]bsidian [T]ags" })
  end,
}
