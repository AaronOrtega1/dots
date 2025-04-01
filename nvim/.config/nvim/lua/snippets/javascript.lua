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
