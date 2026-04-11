require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.completion").setup()
require("mini.snippets").setup()
require("mini.pick").setup({
  source = {
    show = require("mini.pick").default_show,
  },
  window = {
    config = function()
      local height = math.floor(vim.o.lines * 0.50)
      return {
        relative = "editor",
        anchor = "SW",
        row = vim.o.lines - 1,
        col = 0,
        width = vim.o.columns,
        height = height,
      }
    end,
  },
})
require("mini.extra").setup()
