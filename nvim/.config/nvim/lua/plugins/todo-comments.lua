return {
  "folke/todo-comments.nvim",
  opts = {
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#F38BA8" },
      warning = { "DiagnosticWarn", "WarningMsg", "#F9E2AF" },
      info = { "DiagnosticInfo", "#89B4FA" },
      hint = { "DiagnosticHint", "#A6E3A1" },
      default = { "Identifier", "#CBA6F7" },
      test = { "Identifier", "#F5C2E7" },
    },
  },
}
