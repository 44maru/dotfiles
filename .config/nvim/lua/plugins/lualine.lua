return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
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

