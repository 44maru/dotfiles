return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Telescope)" },
		{
			"<leader>FF",
			"<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>",
			desc = "Find Files including hidden files(Telescope)",
		},
		{ "<leader>G", "<cmd>Telescope live_grep<cr>", desc = "Grep files (Telescope)" },
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
