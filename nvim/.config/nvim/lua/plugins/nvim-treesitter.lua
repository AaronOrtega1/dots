return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    -- [[ Configure Treesitter ]]
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'css',
        'javascript',
        'typescript',
        'python',
        'java',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'ninja',
        'rst',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = false },
    },
  },
  { -- Autoclose tags in HTML and JSX
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
