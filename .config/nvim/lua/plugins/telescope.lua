return {
	"nvim-telescope/telescope.nvim",
	-- live grep時に長いファイルパスが見切れないように以下を設定
	--   * popup windowサイズの変更
	--   * ctrl+pでpreview表示のON/OFF
	--   * パスがおさまらない場合に先頭のDIRから１文字に省略
	opts = {
		defaults = {
			layout_config = {
				width = 0.95,
				height = 0.9,
				preview_width = 0.4,
			},
			mappings = {
				i = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview },
				n = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview },
			},
			path_display = function(_, path)
				local sep = "/"
				local parts = {}
				for part in path:gmatch("[^" .. sep .. "]+") do
					table.insert(parts, part)
				end
				if #parts <= 1 then
					return path
				end
				local max_width = math.floor(vim.o.columns * 0.95) - 15
				local result = table.concat(parts, sep)
				local i = 1
				while #result > max_width and i < #parts do
					parts[i] = parts[i]:sub(1, 1)
					result = table.concat(parts, sep)
					i = i + 1
				end
				return result
			end,
		},
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Telescope)" },
		{
			"<leader>FF",
			"<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>",
			desc = "Find Files including hidden files(Telescope)",
		},
		{ "<leader>G", "<cmd>Telescope live_grep<cr>", desc = "Grep files (Telescope)" },
		{
			-- 隠しファイルも対象にgrep
			"<leader>h",
			"<cmd>Telescope live_grep vimgrep_arguments={'rg','--color=never','--no-heading','--with-filename','--line-number','--column','--smart-case','--hidden'}<cr>",
			desc = "Telescope live_grep vimgrep_arguments={'rg','--color=never','--no-heading','--with-filename','--line-number','--column','--smart-case','--hidden'}",
		},
		{
			-- 下記はなぜかleaderをつけないと利かない
			"gr",
			"<cmd>Telescope lsp_references<cr>",
			desc = "Telescope lsp_references",
			mode = { "n" },
		},
		{ "<Leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope lsp_references", mode = { "n" } },
		{
			"<Leader>gi",
			function()
				require("telescope.builtin").lsp_implementations({ reuse_win = true })
			end,
			desc = "Telescope lsp_implementations",
			mode = { "n" },
		},
		{
			"<C-k>",
			function()
				require("telescope.builtin").lsp_definitions({ reuse_win = true })
			end,
			desc = "LSP definitions (Telescope)",
		},
	},
}
