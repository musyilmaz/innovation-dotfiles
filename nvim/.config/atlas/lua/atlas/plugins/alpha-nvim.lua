return {
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
