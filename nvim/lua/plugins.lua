vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/saghen/blink.cmp",
})

require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
    "xml",
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = { enable = true, disable = { "xml" } },
})

require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.completion").setup()
require("mini.snippets").setup()
require("mini.pick").setup()
require("mini.extra").setup()

local pick = require("mini.pick")
local pickextra = require("mini.extra")

vim.keymap.set("n", "<leader>sh", pick.builtin.help, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sk", pick.builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", pick.builtin.files, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>ss", function()
  pick.start({
    source = {
      name = "Pickers",
      items = {
        "files",
        "grep_live",
        "buffers",
        "help",
        "oldfiles",
      },
      choose = function(item)
        pick.builtin[item]()
      end,
    },
  })
end, { desc = "[S]earch [S]elect Picker" })

-- vim.keymap.set("n", "<leader>sw", grep_word, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sw", pick.builtin.grep, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>sd", function()
  pick.builtin.diagnostic()
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader><leader>", pick.builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "grr", function()
  pickextra.pickers.lsp({ scope = "references" })
end, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gri", function()
  pickextra.pickers.lsp({ scope = "implementation" })
end, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "grd", function()
  pickextra.pickers.lsp({ scope = "definition" })
end, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gO", function()
  pickextra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "Open Document Symbols" })
vim.keymap.set("n", "gW", function()
  pickextra.pickers.lsp({ scope = "workspace_symbol" })
end, { desc = "Open Workspace Symbols" })
vim.keymap.set("n", "grt", function()
  pickextra.pickers.lsp({ scope = "type_definition" })
end, { desc = "[G]oto [T]ype Definition" })

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = true },
    menu = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    -- implementation = "prefer_rust_with_warning",
    implementation = "prefer_rust",
  },
})

-- vim: ts=2 sts=2 sw=2 et
