return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			["*"] = {
				keys = {
					-- Alt+nのキーバインドを無効化
					-- デフォルトではNext Referenceが発動する
					{ "<M-n>", false },
				},
			},
		},
	},
}
