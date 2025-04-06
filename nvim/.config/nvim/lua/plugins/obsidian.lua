vim.api.nvim_create_user_command("NewProject", function(opts)
  local path = "00-Projects/"
  vim.cmd("ObsidianNewFromTemplate 00-Projects/" .. opts.args .. '"')
end, { nargs = 1 })
vim.api.nvim_create_user_command("NewArea", function(opts)
  vim.cmd("ObsidianNewFromTemplate 01-Areas/" .. opts.args .. '"')
end, { nargs = 1 })
vim.api.nvim_create_user_command("NewResource", function(opts)
  vim.cmd("ObsidianNewFromTemplate 02-Resources/" .. opts.args .. '"')
end, { nargs = 1 })
vim.api.nvim_create_user_command("NewNote", function(opts)
  vim.cmd("ObsidianNewFromTemplate 04-Zettelkasten/" .. opts.args .. '"')
end, { nargs = 1 })

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = "VeryLazy",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Keybinds PARA and Zettelkasten
      { "<leader>nn", ":NewNote ", desc = "obsidian [n]ote" },
      { "<leader>np", ":NewProject ", desc = "obsidian [p]roject" },
      { "<leader>na", ":NewArea ", desc = "obsidian [a]rea" },
      { "<leader>nr", ":NewResource ", desc = "obsidian [r]ersource" },
      -- Keybinds dailies
      { "<leader>nd", ":ObsidianToday<cr>", desc = "New [D]aily" },
      -- Keybinds navigation
      -- { "<leader>nb", ":ObsidianBacklinks<cr>", desc = "obsidian [b]acklinks" },
      -- { "<leader>nl", ":ObsidianLink<cr>", desc = "obsidian [l]ink selection" },
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/neo-test/",
          overrides = {
            notes_subdir = "04-Zettelkasten/",
            new_notes_location = "notes_subdir",
            daily_notes = {
              folder = "05-Journal",
            },
          },
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = false,
      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "04-Zettelkasten",
      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",

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

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,

      -- Optional, for templates (see below).
      templates = {
        folder = "06-Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
          a_year_ago = function()
            return os.date("%Y-%m-%d", os.time() - 365 * 86400)
          end,
          alias = function()
            local filename = vim.fn.expand("%:t")
            local without_extension = filename:gsub("%.md$", "")
            local only_title = without_extension:gsub("^%d+%-", "")
            return only_title
          end,
          cap_title = function()
            local filename = vim.fn.expand("%:t")
            local without_extension = filename:gsub("%.md$", "")
            local only_title = without_extension:gsub("^%d+%-", "")
            local cap = only_title
              :gsub("(%a)([%w_']*)", function(first, rest)
                return first:upper() .. rest:lower()
              end)
              :gsub("(%-)", " ")
              :gsub("%s+", " ")
            return cap
          end,
        },
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "05-Journal/",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "daily.md",
      },
      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "02-Resources/Assets",

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
        end,

        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
    },
  },
}
