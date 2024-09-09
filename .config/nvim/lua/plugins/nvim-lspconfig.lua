return {
  "neovim/nvim-lspconfig",
  init = function()
    -- Alt+nのキーバインドを無効化
    -- デフォルトではNext Referenceが発動する
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<M-n>", false }
  end,
}
