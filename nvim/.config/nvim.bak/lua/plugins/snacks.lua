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
