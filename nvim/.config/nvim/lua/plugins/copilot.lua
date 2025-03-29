return {
  {
    "github/copilot.vim",
    cond = function()
      return not string.find(vim.fn.getcwd(), "70leetCodeProblems")
    end,
  },
}
