local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local date = function()
  return os.date("%Y-%m-%d %H:%M:%S%z")
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  pattern = { "python" },
  callback = function()
    vim.keymap.set("n", "<leader>cl", function()
      local var = vim.fn.expand("<cword>")
      if var ~= "" then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local indent = vim.api.nvim_get_current_line():match("^%s*") or ""
        local debug_line = indent .. 'print(f"[L#{' .. row .. "}] " .. var .. ": { " .. var .. ' }")'
        vim.api.nvim_buf_set_lines(0, row, row, false, { debug_line })
      end
    end, { buffer = true, desc = "Python debug print" })
  end,
})

local snippets = {
  -- Snippet 'header'
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

  -- Snippet 'docstring'
  s(
    {
      trig = "docs",
      dscr = "Python docstring",
      wordTrig = true,
    },
    fmta(
      [[
    """<>
    
    Args:
        <>

    Returns:
        <>
    """
    <>
    ]],
      {
        i(1, "Brief description"),
        i(2, "param: Description"),
        i(3, "Description of return value"),
        i(0),
      }
    )
  ),

  -- Snippet 'print'
  s({
    trig = "print",
    dscr = "Print value of some variable",
  }, fmta('print(f"the value of <> is {<>}")', { i(1), i(2) })),

  -- Snippet 'import alias'
  s({
    trig = "impa",
    dscr = "import FOO as BAR",
    wordTrig = true,
  }, fmta("import <> as <>", { i(1, "FOO"), i(2, "BAR") })),

  -- Snippet 'main function'
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
