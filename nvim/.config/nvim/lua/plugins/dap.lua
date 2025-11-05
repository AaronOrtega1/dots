return {
  { -- Debugger for neomin
    'mfussenegger/nvim-dap',
    desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',

    dependencies = {
      'rcarriga/nvim-dap-ui',
      { -- virtual text for the debugger
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      require 'plugins.config.python-dap',
    },
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Condition [B]reakpoint',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[B]reakpoint Toggle',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Run/[C]ontinue',
      },
      {
        '<leader>da',
        function()
          require('dap').continue { before = get_args }
        end,
        desc = 'Run with [A]rgs',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to [C]ursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = '[G]o to Line (No Execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step [I]nto',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = '[j]/Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = '[k]/Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run [L]ast',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step [O]ut',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step [O]ver',
      },
      {
        '<leader>dP',
        function()
          require('dap').pause()
        end,
        desc = '[P]ause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle [R]EPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = '[S]ession',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = '[T]erminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = '[W]idgets',
      },
    },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      local ok, mason_dap = pcall(require, 'mason-nvim-dap')
      if ok then
        mason_dap.setup {
          automatic_installation = true,
          ensure_installed = {},
        }
      end

      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      local dap_signs = {
        Stopped = { '', 'DiagnosticWarn' },
        Breakpoint = { '', 'DiagnosticError' },
        BreakpointCondition = { '', 'DiagnosticInfo' },
        LogPoint = { '.>', 'DiagnosticHint' },
        Rejected = { '', 'DiagnosticError' },
      }

      for name, sign in pairs(dap_signs) do
        vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2], numhl = sign[2] })
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require 'dap.ext.vscode'
      local json = require 'plenary.json'
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap [U]I" },
      { "<leader>de", function() require("dapui").eval() end, desc = "[E]val", mode = {"n", "x"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = 'mason.nvim',
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      automatic_installation = true,
      handlers = {},
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
