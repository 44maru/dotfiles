return {
  "is0n/fm-nvim",
  keys = {
    { '<F1>', ':Lazygit<CR>' },
  },
  config = function()
    require('fm-nvim').setup {}
  end
}
