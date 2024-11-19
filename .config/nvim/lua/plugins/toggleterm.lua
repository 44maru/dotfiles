return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Open a horizontal terminal" },
      { "<leader>t", "<c-\\><c-n><cmd>ToggleTerm<cr>",                   desc = "toggle terminal in terminal mode", mode = { "t" } },
    },
    opts = {
      float_opts = {
        width = 200,
        height = 40,
      },
    },
  },
}
