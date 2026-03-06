return {
	{
		"atusy/qfscope.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			local qfs_actions = require("qfscope.actions")

			opts.defaults = opts.defaults or {}
			opts.defaults.mappings = opts.defaults.mappings or {}
			opts.defaults.mappings.i = opts.defaults.mappings.i or {}

			opts.defaults.mappings.i["<c-f>g"] = qfs_actions.qfscope_search_filename
			opts.defaults.mappings.i["<c-f>f"] = qfs_actions.qfscope_grep_filename
			opts.defaults.mappings.i["<c-f>l"] = qfs_actions.qfscope_grep_line
			opts.defaults.mappings.i["<c-f>t"] = qfs_actions.qfscope_grep_text
		end,
	},
}
