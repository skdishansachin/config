vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-mini/mini.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
})

require("plugins.nvim-treesitter")
require("plugins.mini")
require("plugins.blink")

-- vim: ts=2 sts=2 sw=2 et
