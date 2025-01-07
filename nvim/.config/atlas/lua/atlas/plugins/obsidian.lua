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
  keys = {
    {
      "<leader>nn",
      "<cmd>ObsidianNew<cr>",
      desc = "Obsidian New Note",
    },
    {
      "<leader>nt",
      "<cmd>ObsidianToday<cr>",
      desc = "Obsidian Today",
    },
    {
      "<leader>ny",
      "<cmd>ObsidianYesterday<cr>",
      desc = "ObsidianYesterday",
    },
  },
  opts = {
    workspaces = {
      {
        name = "Obsidian",
        path = "~/Documents/personal/musyilmaz",
      },
    },
    notes_subdir = "00 - Inbox",
    new_notes_location = "notes_subdir",
    log_level = vim.log.levels.INFO,
    templates = {
      folder = "Templates",
    },
    daily_notes = {
      folder = "10 - Daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-note", os.date("%Y-%m"), os.date("%B-%Y") },
      template = "daily-note-template.md",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    picker = {
      name = "telescope.nvim",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },
  },
}
