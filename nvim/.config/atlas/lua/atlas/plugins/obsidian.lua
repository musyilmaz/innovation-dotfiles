return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/personal/Atlas/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/personal/Atlas/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "Obsidian",
        path = "~/Documents/personal/Obsidian",
      },
    },
  },
}
