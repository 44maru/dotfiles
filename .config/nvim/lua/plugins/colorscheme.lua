return {
	-- add gruvbox
	--{ "ellisonleao/gruvbox.nvim" },

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight-storm",
		},
	},
	{
		-- 下記pluginはハイライト設定を安全に適用するために「タイミング用ダミー枠として使用
		"nvim-lua/plenary.nvim",
		lazy = false,
		priority = 1001,
		config = function()
			vim.cmd([[
        highlight DiffAdd     guibg=#005500 guifg=NONE
        highlight DiffDelete  guibg=#330000 guifg=#FF5555
        highlight DiffChange  guibg=#555500 guifg=NONE
        highlight DiffText    guibg=#666600 guifg=NONE
      ]])
		end,
	},
}
