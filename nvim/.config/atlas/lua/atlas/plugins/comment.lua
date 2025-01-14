return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      comment.setup({
        padding = true,
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "fangjunzhou/comment-divider.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cdb", "<CMD>CommentDividerBox<CR>" },
      { "<leader>cdl", "<CMD>CommentDividerLine<CR>" },
    },
  },
}
