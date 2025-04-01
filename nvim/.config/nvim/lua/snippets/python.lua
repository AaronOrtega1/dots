local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local date = function()
  return os.date("%Y-%m-%d %H:%M:%S%z")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.keymap.set("n", "<leader>cl", function()
      local var = vim.fn.expand("<cword>")
      if var ~= "" then
        -- Obtener posición actual
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()

        -- Insertar nueva línea debajo
        vim.api.nvim_buf_set_lines(0, row, row, false, { "" })

        -- Mover cursor a la nueva línea
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })

        -- Expandir el snippet
        ls.snip_expand(ls.parser.parse_snippet("", 'print("' .. var .. ': ", ' .. var .. ")"))
      end
    end, { buffer = true, desc = "Insert console.log below" })
  end,
})

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
