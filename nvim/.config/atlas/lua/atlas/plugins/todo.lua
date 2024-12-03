return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ht", "<cmd>Trouble todo<cr>", desc = "Todo (Trouble)" },
    { "<leader>hs", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
  },
  opts = {},
}
