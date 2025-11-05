return { -- show color swatches for #rrggbb, rgb(), named colors, inline styles, etc.
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      -- filetypes to attach to
      css = { css = true, names = true, RRGGBB = true, rgb_fn = true },
      html = { css = true, names = true, RRGGBB = true, rgb_fn = true },
      scss = { css = true, names = true, RRGGBB = true, rgb_fn = true },
      less = { css = true, names = true, RRGGBB = true, rgb_fn = true },
      javascript = { css = false }, -- JS/TS: don't highlight arbitrary numbers
      typescript = { css = false },
      -- you may also enable for filetypes you use for Tailwind (tsx/jsx)
      javascriptreact = { css = false },
      typescriptreact = { css = false },
      -- global options
      user_default_options = {
        RGB = true, -- #RGB hex
        RRGGBB = true, -- #RRGGBB hex
        names = true, -- "seagreen", "white", etc.
        rgb_fn = true, -- CSS rgb()/rgba() functions
        hsl_fn = true, -- CSS hsl()/hsla() functions
        css = true, -- enable all css features: rgb_fn, names, etc.
        css_fn = true, -- support parsing all CSS functions
        -- any other options here from colorizer docs
      },
      -- optionally attach on BufReadPost so big files are lighter initially
    }, {
      -- <second arg> is the filetypes list to attach to on setup — nil uses the keys above
    })
  end,
}
