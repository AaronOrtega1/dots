local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt -- Cambiado a fmt en lugar de fmta
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

local date = function()
  return os.date("%Y-%m-%d %H:%M:%S%z")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.keymap.set("n", "<leader>cl", function()
      local var = vim.fn.expand("<cword>")
      if var ~= "" then
        -- Get current position and indentation
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line = vim.api.nvim_get_current_line()
        local indent = current_line:match("^%s*") or ""

        -- Create debug line with proper indentation and line number
        local debug_line = indent .. "console.log(`[L#${" .. row .. "}] " .. var .. ": `, " .. var .. ");"

        -- Insert new line below with debug statement
        vim.api.nvim_buf_set_lines(0, row, row, false, { debug_line })

        -- Move cursor back to original position (optional)
        vim.api.nvim_win_set_cursor(0, { row, 0 })
      end
    end, { buffer = true, desc = "Insert debug console.log below" })
  end,
})

local snippets = {
  -- Usando fmt en lugar de fmta para evitar problemas con <>
  s(
    {
      trig = "head",
      dscr = "JavaScript file header",
    },
    fmt(
      [[
      /**
       * Description: {}
       * Author: {}
       * Created: {}
       */
      
      {}
      ]],
      {
        i(1, "File description"),
        i(2, "Francisco Aarón Ortega Anguiano <aaron.ortega15@outlook.es>"),
        f(date),
        i(0),
      }
    )
  ),

  s({
    trig = "clg",
    dscr = "Console log value",
  }, fmt('console.log("{}: ", {});', { i(1, "label"), i(2, "value") })),

  -- Arrow function corregida
  s(
    {
      trig = "afn",
      dscr = "Arrow function",
    },
    fmt(
      [[
      const {} = ({}) => {{
        {}
      }};
      ]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(0),
      }
    )
  ),
}

local autosnippets = {}

return {
  snippets = snippets,
  autosnippets = autosnippets,
}
