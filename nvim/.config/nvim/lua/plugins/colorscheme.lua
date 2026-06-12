function ColorMyPencils(color)
  color = color or 'rose-pine-moon'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return { -- Colorscheme
  { -- CATPPUCCIN MOCHA
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        float = {
          transparent = true,
        },
        lsp_styles = {
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        integrations = {
          fidget = true,
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          fzf = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          mini = true,
          navic = { enabled = true, custom_bg = 'lualine' },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          snacks = true,
          telescope = true,
          treesitter_context = true,
          which_key = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  { -- KANAGAWA DRAGON
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      transparent = true,
      theme = 'dragon',

      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
              bg = 'none',
              bg_dim = 'none',
            },
          },
        },
      },
    },
  },
}
