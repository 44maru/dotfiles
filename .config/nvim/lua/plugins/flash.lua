return {
  "folke/flash.nvim",
  keys = {
    { "s", false },
    {
      "<space>",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
