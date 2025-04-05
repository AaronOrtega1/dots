return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = "VeryLazy",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/neo-test/",
        },
      },
      -- completion = {
      --   nvim_cmp = true,
      --   min_chars = 2,
      -- },
    },
  },
}
