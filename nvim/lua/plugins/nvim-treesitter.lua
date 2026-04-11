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

