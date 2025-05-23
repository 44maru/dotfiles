-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- mapleaderの設定は、options.luaに記述する必要がある(lazy.luaがロードされる前にやる必要がある)
--vim.g.mapleader = ";"

vim.keymap.set("i", "<C-j>", "<ESC>")

-- flashのキーバインド無効化
vim.cmd([[
  unmap s
  unmap t
  unmap <c-e>
]])

vim.cmd("source ~/.nvimrc")

-- paste from register 0
vim.keymap.set("n", "!", '"0p')
vim.keymap.set("v", "!", '"0p')

vim.keymap.set("n", "<M-m>", "<cmd>Maximize<CR>")
vim.keymap.set("n", "<Leader>s", "<cmd>lua require('flash').jump()<CR>")
vim.keymap.set("n", "<Leader>n", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<Leader>w", "<cmd>WinResizerStartResize<cr>")
vim.keymap.set("n", "<M-o>", "<cmd>SymbolsOutline<cr>")
--vim.keymap.set("n", "?", "<Cmd>lua require('which-key').show(' ', {mode = 'v', auto = true})<CR>")
vim.keymap.set("n", "<C-k>", function()
  require("telescope.builtin").lsp_definitions({ reuse_win = true })
end)
vim.keymap.set("n", "<Leader>G", "<cmd>Telescope live_grep<cr>")
-- 下記はなぜかleaderをつけないと利かない
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
vim.keymap.set("n", "<Leader>gr", "<cmd>Telescope lsp_references<cr>")
vim.keymap.set("n", "<Leader>gi", function()
  require("telescope.builtin").lsp_implementations({ reuse_win = true })
end)
-- renameに関してはデフォルトで以下のkeymapが設定されている
-- { "<leader>cr", vim.lsp.buf.rename, desc - "Rename", has = "rename" }
