return {
  -- COLORSCHEME || TOKYONIGHT - STORM
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },

  -- BUFFER DELETE
  {
    "famiu/bufdelete.nvim",
  },

  -- COLORIZER
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- CUSTOM DEV ICONS
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local devicons = require("nvim-web-devicons")

      devicons.setup({
        override = {
          gql = {
            icon = "",
            color = "#e535ab",
            cterm_color = "199",
            name = "GraphQL",
          },
          rust = {
            icon = "",
            color = "#ffffff",
            name = "rust",
          },
        },
        color_icons = true,
        default = true,
        strict = true,
      })
    end,
  },

  -- ALPHA NVIM

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")

      startify.section.header.val = {
        "  █████╗ ████████╗██╗      █████╗ ███████╗ ",
        " ██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝ ",
        " ███████║   ██║   ██║     ███████║███████╗ ",
        " ██╔══██║   ██║   ██║     ██╔══██║╚════██║ ",
        " ██║  ██║   ██║   ███████╗██║  ██║███████║ ",
        " ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝ ",
      }

      startify.section.top_buttons.val = {
        startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      }

      startify.file_icons.provider = "devicons"

      alpha.setup(startify.opts)

      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
