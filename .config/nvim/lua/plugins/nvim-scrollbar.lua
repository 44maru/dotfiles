return {
	{
		"petertriho/nvim-scrollbar",
		opts = function()
			local colors = require("tokyonight.colors").setup({
				style = "storm",
				on_colors = function(_) end,
				on_highlights = function(_, _) end,
			})
			return {
				handle = {
					color = colors.bg_highlight,
				},
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warn },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true, -- Requires gitsigns
					handle = true,
					search = true, -- Requires hlslens
					ale = true, -- Requires ALE
				},
			}
		end,
		dependencies = {
			"kevinhwang91/nvim-hlslens",
			"lewis6991/gitsigns.nvim",
		},
		wants = { "tokyonight.nvim" },
	},
}
