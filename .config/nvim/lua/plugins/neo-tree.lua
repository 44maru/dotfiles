return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<M-n>",
      "<Cmd>Neotree reveal<CR>",
      desc = "Neotree reveal",
    },
  },
  opts = {
    window = {
      mappings = {
        ["o"] = "open",
      },
    },
  },
}
