return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		local icons = LazyVim.config.icons
		opts.sections.lualine_c = {
			LazyVim.lualine.root_dir(),
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", path = 1 },
			{
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error,
					warn = icons.diagnostics.Warn,
					info = icons.diagnostics.Info,
					hint = icons.diagnostics.Hint,
				},
			},
			{
				"searchcount",
				color = { fg = "#FFFFFF", bg = "#FF1493", gui = "bold" },
			},
		}

		local function lsp_name()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			if #clients == 0 then
				return "No LSP" -- 歯車アイコン
			end
			local names = {}
			for _, client in pairs(clients) do
				table.insert(names, client.name)
			end
			return "LSP: " .. table.concat(names, ", ")
		end

		-- lualine_c セクションに追加（必要に応じて調整）
		table.insert(opts.sections.lualine_x, { lsp_name, icon = "" })
	end,
}
