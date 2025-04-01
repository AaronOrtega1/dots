return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  opts = function(_, opts)
    local ls = require("luasnip")

    local extend_decorator = require("luasnip.util.extend_decorator")
    -- Create trigger transformation function
    local function auto_semicolon(context)
      if type(context) == "string" then
        return { trig = ";" .. context }
      end
      return vim.tbl_extend("keep", { trig = ";" .. context.trig }, context)
    end
    -- Register and apply decorator properly
    extend_decorator.register(ls.s, {
      arg_indx = 1,
      extend = function(original)
        return auto_semicolon(original)
      end,
    })
    local s = extend_decorator.apply(ls.s, {})

    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmta = require("luasnip.extras.fmt").fmta
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    local function clipboard()
      return vim.fn.getreg("+")
    end

    -- Define languages for code blocks
    local languages = {
      "python",
      "html",
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "markdown",
      "txt",
      "json",
      "yaml",
    }

    -- Generate snippets for all languages
    local snippets = {}

    -- Python source file header
    table.insert(
      snippets,
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
            f(function()
              return os.date("%Y-%m-%d %H:%M:%S%z")
            end),
            i(0),
          }
        )
      )
    )

    -- Python print statement
    table.insert(
      snippets,
      s({
        trig = "print",
        dscr = "Print value of some variable",
      }, fmta('print("<>".format(<>))', { i(1), i(2) }))
    )

    -- Python import as
    table.insert(
      snippets,
      s({
        trig = "impa",
        dscr = "import FOO as BAR",
        wordTrig = true,
      }, fmta("import <> as <>", { i(1, "FOO"), i(2, "BAR") }))
    )

    -- Python main function
    table.insert(
      snippets,
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
      )
    )

    return opts
  end,
}
