local pick = require("mini.pick")
local extra = require("mini.extra")

local map = vim.keymap.set

-- Editor keymaps
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Mini.pick keymaps
map("n", "<leader>sh", pick.builtin.help, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", extra.pickers.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", pick.builtin.files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sw", pick.builtin.grep, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", pick.builtin.grep_live, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", extra.pickers.diagnostic, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", pick.builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", extra.pickers.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", pick.builtin.buffers, { desc = "[ ] Find existing buffers" })

map("n", "<leader>ss", function()
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

map("n", "grr", function()
  extra.pickers.lsp({ scope = "references" })
end, { desc = "[G]oto [R]eferences" })

map("n", "gri", function()
  extra.pickers.lsp({ scope = "implementation" })
end, { desc = "[G]oto [I]mplementation" })

map("n", "grd", function()
  extra.pickers.lsp({ scope = "definition" })
end, { desc = "[G]oto [D]efinition" })

map("n", "gO", function()
  extra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "Open Document Symbols" })

map("n", "gW", function()
  extra.pickers.lsp({ scope = "workspace_symbol" })
end, { desc = "Open Workspace Symbols" })

map("n", "grt", function()
  extra.pickers.lsp({ scope = "type_definition" })
end, { desc = "[G]oto [T]ype Definition" })

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf

    map("n", "grn", vim.lsp.buf.rename, {
      buffer = buf,
      desc = "[R]e[n]ame",
    })

    map({ "n", "x" }, "gra", vim.lsp.buf.code_action, {
      buffer = buf,
      desc = "[G]oto Code [A]ction",
    })

    map("n", "grD", vim.lsp.buf.declaration, {
      buffer = buf,
      desc = "[G]oto [D]eclaration",
    })

    map("n", "<leader>e", function()
      vim.diagnostic.open_float(nil, { focus = false })
    end, {
      buffer = buf,
      desc = "Show Line Diagnostics",
    })

    map("n", "[e", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, {
      buffer = buf,
      desc = "Previous Error",
    })

    map("n", "]e", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, {
      buffer = buf,
      desc = "Next Error",
    })

    map("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
    end, {
      buffer = buf,
      desc = "[T]oggle Inlay [H]ints",
    })

    map("i", "<C-k>", vim.lsp.buf.signature_help, {
      buffer = buf,
      desc = "LSP Signature Help",
    })
  end,
})

vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", {
  desc = "Alias to :checkhealth vim.lsp",
})

-- vim: ts=2 sts=2 sw=2 et
