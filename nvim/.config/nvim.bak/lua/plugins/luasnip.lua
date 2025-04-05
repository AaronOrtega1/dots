return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  dependencies = {
    "rafamadriz/friendly-snippets", -- Opcional: snippets predefinidos
  },
  config = function()
    local ls = require("luasnip")

    -- Configuración de auto_semicolon
    local extend_decorator = require("luasnip.util.extend_decorator")
    local function auto_semicolon(context)
      if type(context) == "string" then
        return { trig = ";" .. context }
      end
      return vim.tbl_extend("keep", { trig = ";" .. context.trig }, context)
    end

    extend_decorator.register(ls.s, {
      arg_indx = 1,
      extend = function(original)
        return auto_semicolon(original)
      end,
    })

    -- Cargar snippets específicos por tipo de archivo
    local ft_to_snippets = {
      python = require("snippets.python"),
      javascript = require("snippets.javascript"),
      javascriptreact = require("snippets.javascript"), -- Para archivos React (.jsx)
      typescript = require("snippets.javascript"), -- También para TypeScript
      typescriptreact = require("snippets.javascript"), -- Para archivos React con TypeScript (.tsx)
    }

    -- Cargar snippets personalizados
    for ft, snippets_data in pairs(ft_to_snippets) do
      ls.add_snippets(ft, snippets_data.snippets)
      if snippets_data.autosnippets and not vim.tbl_isempty(snippets_data.autosnippets) then
        ls.add_snippets(ft, snippets_data.autosnippets, { type = "autosnippets" })
      end
    end

    -- Cargar friendly-snippets (opcional)
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
  },
}
