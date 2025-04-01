local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local date = function()
  return os.date("%Y-%m-%d %H:%M:%S%z")
end

local snippets = {
  s(
    {
      trig = "head",
      dscr = "Python source file header",
      wordTrig = true,
    },
    fmta(
      [[
      """
      Description: <>
      Author: <>
      Created: <>
      """
      <>
      ]],
      {
        i(1),
        i(2, "Francisco Aarón Ortega Anguiano <aaron.ortega15@outlook.es>"),
        f(date),
        i(0),
      }
    )
  ),

  s({
    trig = "print",
    dscr = "Print value of some variable",
  }, fmta('print("<>".format(<>))', { i(1), i(2) })),

  s({
    trig = "impa",
    dscr = "import FOO as BAR",
    wordTrig = true,
  }, fmta("import <> as <>", { i(1, "FOO"), i(2, "BAR") })),

  s(
    {
      trig = "main",
      dscr = "Main function boilerplate",
      wordTrig = true,
    },
    fmta(
      [[
      def main():
          <>

      if __name__ == "__main__":
          main()
      ]],
      { i(0) }
    )
  ),

  -- Snippet 'sol'
  s({
    trig = "sol",
    dscr = "solution",
    wordTrig = true,
  }, t("solution = Solution()")),
}

local autosnippets = {}

return {
  snippets = snippets,
  autosnippets = autosnippets,
}
