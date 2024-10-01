return {
  "folke/flash.nvim",
  keys = {
    { "s", false },
    {
      "<space>",
      mode = { "n", "x", "o" },
      function()
        local gi = vim.go.ignorecase
        local gs = vim.go.smartcase
        vim.go.ignorecase = true
        vim.go.smartcase = false
        require("flash").jump()
        vim.go.ignorecase = gi
        vim.go.smartcase = gs
      end,
      desc = "Flash",
    },
  },
}
