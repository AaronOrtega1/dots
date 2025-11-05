local M = {}

local templates = {
  { name = 'Quest', template = 'quest.md', target_dir = '00-Quests' },
  { name = 'Domain', template = 'domain.md', target_dir = '01-Domain' },
  { name = 'Knowledge', template = 'knowledge.md', target_dir = '02-Library' },
  { name = 'Smithing', template = 'smithing.md', target_dir = '04-Forge' },
  { name = 'Pending', template = 'pending.md', target_dir = '02-Library' },
  { name = 'Tome', template = 'tome.md', target_dir = '02-Library' },
  { name = 'Training Session', template = 'training-sessions.md', target_dir = '08-Training-Sessions' },
  { name = 'Technique', template = 'techniques.md', target_dir = '02-Library' },
  { name = 'Algorithmic Grimoire Entry', template = 'algorithmic-grimoire.md', target_dir = '02-Library' },
  { name = 'AWS Question', template = 'awsQuestion.md', target_dir = '02-Library' },
}

local function get_obsidian()
  local ok, obsidian = pcall(require, 'obsidian')
  if not ok or not obsidian then
    vim.notify('obsidian.nvim not loaded', vim.log.levels.ERROR)
    return nil
  end
  return obsidian
end

M.create_new_note = function()
  local obsidian = get_obsidian()
  if not obsidian then
    return
  end

  local snacks_ok, picker = pcall(require, 'snacks.picker')
  if not snacks_ok then
    vim.notify('snacks.picker not available', vim.log.levels.ERROR)
    return
  end

  picker.select(templates, {
    prompt = 'Select a template:',
    format_item = function(item)
      return item.name
    end,
    kind = 'template',
  }, function(choice)
    if not choice then
      vim.notify('No template selected', vim.log.levels.WARN)
      return
    end

    vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
      if not title or title == '' then
        vim.notify('Note creation cancelled (no title)', vim.log.levels.WARN)
        return
      end

      -- Construct full relative path: "target_dir/title"
      local note_path = string.format('%s/%s', choice.target_dir, title)
      local create_cmd = string.format('Obsidian new_from_template %s %s', note_path, choice.template)

      -- Execute Obsidian command
      vim.cmd(create_cmd)

      vim.notify(string.format("Created note '%s' from template '%s'", note_path, choice.template), vim.log.levels.INFO)
    end)
  end)
end

return M
