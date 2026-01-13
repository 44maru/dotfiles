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

		---------------------------------------
		-- yamlファイルの場合にカーソル位置からroot方向にたどって
		-- nameキーがあれば、lualineにその値を表示
		---------------------------------------
		local disabled = vim.env.NVIM_LUALINE_DISABLE_YAML_CONTEXT_NAME ~= nil
		local ts = vim.treesitter

		-- mapping / sequence 配下から name を探す（再帰）
		local function find_name(node, bufnr)
			if not node then
				return nil
			end

			if node:type() == "block_mapping_pair" then
				local key = node:child(0)
				local value = node:child(2)
				if key and value then
					if ts.get_node_text(key, bufnr) == "name" then
						return ts.get_node_text(value, bufnr)
					end
				end
			end

			for _, child in ipairs(node:named_children()) do
				local found = find_name(child, bufnr)
				if found then
					return found
				end
			end

			return nil
		end

		-- lualine component
		local function yaml_queue_name()
			local bufnr = 0
			local node = ts.get_node()

			if not node then
				return ""
			end

			-- カーソル位置から親を辿り、各階層で name を探索
			local current = node
			while current do
				local name = find_name(current, bufnr)
				if name then
					return name
				end
				current = current:parent()
			end

			return ""
		end

		-- lualine に追加
		if not disabled then
			opts.sections.lualine_c = opts.sections.lualine_c or {}
			table.insert(opts.sections.lualine_c, yaml_queue_name)
		end
	end,
}
