return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "Open a horizontal terminal at the Desktop directory" }
    },
    opts = {
      float_opts = {
        width = 300,
        height = 300,
      },
    },
  },
}
