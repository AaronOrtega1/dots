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
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice [L]ast Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice [H]istory" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice [A]ll" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "[D]ismiss All" },
    { "<leader>nt", function() require("noice").cmd("pick") end, desc = "Noice [T]Picker" },
  },
  config = function(_, opts)
    if vim.o.filetype == 'lazy' then
      vim.cmd [[messages clear]]
    end
    require('noice').setup(opts)
  end,
}
