local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      -- Para usuarios de luasnip (recomendado en LazyVim)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  apping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Esc>"] = cmp.mapping.close(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 900 },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  }),
  completion = {
    keyword_length = 1,
    completeopt = "menu,menuone,noselect",
  },
  view = {
    entries = "custom",
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[SNIP]",
        path = "[Path]",
        buffer = "[Buffer]",
      },
      maxwidth = 40,
      ellipsis_char = "...",
      -- Colores específicos para Catppuccin Mocha
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },
    }),
  },
  experimental = {
    ghost_text = true,
  },
})
-- Configuración específica para LuaSnip
require("luasnip").config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

-- Carga friendly-snippets con tus snippets personalizados
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "./lua/snippets" }, -- Asegúrate que esta ruta apunte a tu directorio de snippets
})

-- Configuración específica para archivos tex
cmp.setup.filetype("tex", {
  sources = cmp.config.sources({
    { name = "omni" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 2 },
    { name = "path" },
  }),
})
