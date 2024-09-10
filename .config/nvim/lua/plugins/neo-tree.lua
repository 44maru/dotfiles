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
    close_if_last_window = true,
    window = {
      mappings = {
        ["o"] = "open",
      },
    },
  },
}
