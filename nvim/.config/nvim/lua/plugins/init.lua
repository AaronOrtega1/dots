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
    opts = {},
  },
}
