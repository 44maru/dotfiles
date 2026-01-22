return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary", -- 最新機能が入っている方を使う
	dependencies = {
		{ "zbirenbaum/copilot.lua" }, -- Copilot 本体
		{ "nvim-lua/plenary.nvim" },
	},
	opts = {
		-- Copilot Chat のオプション（省略可）
	},
	cmd = { "CopilotChat", "CopilotChatToggle" }, -- コマンドで起動
	keys = {
		{ "<leader>cc", "<cmd>CopilotChatToggle<CR>", mode = "v", desc = "CopilotChat トグル" },
		{
			"zq",
			function()
				require("CopilotChat.integrations.telescope").pick(require("CopilotChat.select").visual)
			end,
			mode = "v",
			desc = "CopilotChat: 選択したコードに質問（Telescope）",
		},
	},
}
