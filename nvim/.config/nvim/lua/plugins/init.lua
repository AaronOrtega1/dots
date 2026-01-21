return {
  { -- Detect tabstop and shiftwidth automatically
    'NMAC427/guess-indent.nvim',
    opts = { show_debug = false },
  },
  { -- Autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  { -- Markdown
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    opts = {
      render_modes = true,
      code = { sign = false, border = 'thick' },
      heading = { sign = false },
      checkbox = {
        custom = {
          forwarded = { raw = '[>]', rendered = '󰛂 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          cancelled = { raw = '[-]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = '@markup.strikethrough' },
          incompleted = { raw = '[/]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          important = { raw = '[!]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
    },
  },
  { -- Raindow delimiters for easier understanding.
    'hiphish/rainbow-delimiters.nvim',
  },
}
