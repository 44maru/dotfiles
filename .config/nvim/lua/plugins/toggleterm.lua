return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Open a horizontal terminal" }
      --{ "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "Open a float terminal" }
    },
    opts = {
      float_opts = {
        width = 200,
        height = 40,
      },
    },
  },
}
