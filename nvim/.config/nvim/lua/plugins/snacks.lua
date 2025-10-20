return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[

 █████╗  █████╗ ██████╗  ██████╗ ███╗   ██╗██████╗ ███████╗██╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██╔═══██╗████╗  ██║██╔══██╗██╔════╝██║   ██║
███████║███████║██████╔╝██║   ██║██╔██╗ ██║██║  ██║█████╗  ██║   ██║
██╔══██║██╔══██║██╔══██╗██║   ██║██║╚██╗██║██║  ██║██╔══╝  ╚██╗ ██╔╝
██║  ██║██║  ██║██║  ██║╚██████╔╝██║ ╚████║██████╔╝███████╗ ╚████╔╝ 
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝  ╚═══╝  

[TIP: To exit Neovim, just power off your computer.]
        ]],
        keys = {
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        },
      },
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 30,
              min_width = 30,
              position = "right",
            },
          },
        },
      },
    },
  },
}
