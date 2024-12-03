return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ht", "<cmd>TodoQuickFix<cr>", desc = "Todo - Quickfix" },
    { "<leader>hs", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
  },
  opts = {},
}
