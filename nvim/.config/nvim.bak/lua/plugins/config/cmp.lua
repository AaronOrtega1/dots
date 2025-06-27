local cmp = require("cmp")
local lspkind = require("lspkind")
-- Función para obtener colores del tema
local get_theme_colors = function()
  local colors = vim.api.nvim_get_hl_by_name("Normal", true)
  local comment_fg = vim.api.nvim_get_hl_by_name("Comment", true).foreground or colors.foreground
  local string_fg = vim.api.nvim_get_hl_by_name("String", true).foreground or colors.foreground
  local keyword_fg = vim.api.nvim_get_hl_by_name("Keyword", true).foreground or colors.foreground
  local warning_fg = vim.api.nvim_get_hl_by_name("WarningMsg", true).foreground or colors.foreground

  return {
    abbr = colors.foreground,
    deprecated = warning_fg,
    match = string_fg,
    menu = comment_fg,
    kind = keyword_fg,
  }
end

-- Aplicar colores dinámicos
local apply_cmp_highlights = function()
  local colors = get_theme_colors()

  vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = colors.abbr })
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = colors.deprecated, strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colors.match })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.match, underline = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = colors.menu, italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKind", { fg = colors.kind })
end

-- Ejecutar al cargar y al cambiar colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_cmp_highlights,
})

apply_cmp_highlights() -- Aplicar al iniciar
cmp.setup({
  snippet = {
    expand = function(args)
      -- Para usuarios de luasnip (recomendado en LazyVim)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
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

-- Configuración específica para archivos tex
cmp.setup.filetype("tex", {
  sources = cmp.config.sources({
    { name = "omni" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 2 },
    { name = "path" },
  }),
})
