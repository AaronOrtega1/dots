return {
  -- Auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-omni",
      "saadparwaiz1/cmp_luasnip", -- Necesario para integración con LuaSnip
    },
    config = function()
      require("plugins.config.cmp")
    end,
  },
}
