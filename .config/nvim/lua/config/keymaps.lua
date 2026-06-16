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
vim.keymap.set("n", "<M-o>", "<cmd>AerialToggle<cr>")
--vim.keymap.set("n", "?", "<Cmd>lua require('which-key').show(' ', {mode = 'v', auto = true})<CR>")
-- renameに関してはデフォルトで以下のkeymapが設定されている
-- { "<leader>cr", vim.lsp.buf.rename, desc - "Rename", has = "rename" }

-- lazygit起動時にtmuxペインを最大化(zoom)し、終了後も維持する
-- ・un-zoomは一切行わない（必ずzoom ONにするだけ）
-- ・tmux外では何もしない
local function ensure_tmux_zoom()
	if not vim.env.TMUX then
		return
	end
	-- リスト形式で渡すとシェル(zsh)を介さず直接tmuxを実行するため速い
	local zoomed = vim.trim(vim.fn.system({ "tmux", "display", "-p", "#{window_zoomed_flag}" }))
	if zoomed == "0" then
		vim.fn.system({ "tmux", "resize-pane", "-Z" })
	end
end

if vim.fn.executable("lazygit") == 1 then
	local function open_lazygit(opts)
		ensure_tmux_zoom() -- 起動前: 非最大化でも最大化する
		opts = vim.tbl_deep_extend("force", opts or {}, {
			win = {
				-- 終了後: nvimの再描画完了後に再度zoomを保証する
				on_close = function()
					vim.schedule(ensure_tmux_zoom)
				end,
			},
		})
		return Snacks.lazygit(opts)
	end

	vim.keymap.set("n", "<leader>gg", function()
		open_lazygit({ cwd = LazyVim.root.git() })
	end, { desc = "Lazygit (Root Dir, tmux zoom)" })
	vim.keymap.set("n", "<leader>gG", function()
		open_lazygit()
	end, { desc = "Lazygit (cwd, tmux zoom)" })
end
