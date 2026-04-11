vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("plugins")
require("options")
require("keymaps")

vim.lsp.enable({ "lua_ls", "ty", "rust_analyzer", "roslyn", "clangd", "ts_ls", "gopls", "zls" })

vim.cmd("colorscheme tokyonight-night")

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many", max_width = 80, wrap = true },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
