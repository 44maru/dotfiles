return {
	"declancm/windex.nvim",
	config = function()
		require("windex").setup({
			default_keymaps = false, -- Enable default keymaps.
			extra_keymaps = false, -- Enable extra keymaps.
			arrow_keys = false, -- Default window movement keymaps use arrow keys instead of 'h,j,k,l'.
		})
	end,
	keys = {
		{ "<leader>z", "<cmd>lua require('windex').toggle_maximize()<cr>", desc = "Toggle Maximize Window" },
		{ "<C-w>h", "<cmd>lua require('windex').switch_window('left')<cr>", desc = "Move Window Left" },
		{ "<C-w>j", "<cmd>lua require('windex').switch_window('down')<cr>", desc = "Move Window Down" },
		{ "<C-w>k", "<cmd>lua require('windex').switch_window('up')<cr>", desc = "Move Window Up" },
		{ "<C-w>l", "<cmd>lua require('windex').switch_window('right')<cr>", desc = "Move Window Right" },
	},
}
