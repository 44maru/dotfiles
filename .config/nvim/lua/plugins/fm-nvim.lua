return {
	"is0n/fm-nvim",
	keys = {
		{ "<F2>", ":Lazygit<CR>" },
	},
	config = function()
		require("fm-nvim").setup({
			ui = {
				float = {
					width = 1.0,
					height = 1.0,
				},
			},
		})
	end,
}
