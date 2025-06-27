local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local input = require("obsidian.util").input
local obsidian = require("obsidian")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Define las plantillas disponibles y su destino
local templates = {
  { name = "Project", template = "project2.md", target_dir = "00-Projects" },
  { name = "Area", template = "area2.md", target_dir = "01-Areas" },
  { name = "Resource", template = "resource2.md", target_dir = "02-Resources" },
  { name = "Pending", template = "pending2.md", target_dir = "02-Resources" },
  { name = "Zettelkasten", template = "note2.md", target_dir = "04-Zettelkasten" },
}

M.custom_new_from_template = function()
  pickers
    .new({}, {
      prompt_title = "Select type of note",
      finder = finders.new_table({
        results = templates,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<CR>", function()
          local selection = action_state.get_selected_entry().value
          actions.close(prompt_bufnr)

          -- Ejecuta la lógica después de cerrar Telescope
          vim.schedule(function()
            vim.ui.input({ prompt = "Title of the note" }, function(title)
              if not title or title == "" then
                vim.notify("Invalid title", vim.log.levels.ERROR)
                return
              end

              local client = obsidian.get_client()

              -- Generar ID en formato {timestamp}-slug
              -- local suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              -- local note_id = tostring(os.time()) .. "-" .. suffix

              local note = client:create_note({
                title = title,
                dir = selection.target_dir,
                template = selection.template,
                tags = { selection.name:lower() },
              })

              client:open_note(note)
            end)
          end)
        end)

        return true
      end,
    })
    :find()
end

return M
