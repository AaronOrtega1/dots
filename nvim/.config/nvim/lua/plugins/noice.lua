return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>n", "", desc = "[N]oice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "[N]oice [L]ast Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "[N]oice [H]istory" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "[N]oice [A]ll" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "[D]ismiss All" },
    { "<leader>nt", function() require("noice").cmd("pick") end, desc = "[N]oice [P]icker" },
  },
  config = function(_, opts)
    if vim.o.filetype == 'lazy' then
      vim.cmd [[messages clear]]
    end
    require('noice').setup(opts)
  end,
}
