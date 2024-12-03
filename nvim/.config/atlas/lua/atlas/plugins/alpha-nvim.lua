return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        "  █████╗ ████████╗██╗      █████╗ ███████╗ ",
        " ██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝ ",
        " ███████║   ██║   ██║     ███████║███████╗ ",
        " ██╔══██║   ██║   ██║     ██╔══██║╚════██║ ",
        " ██║  ██║   ██║   ███████╗██║  ██║███████║ ",
        " ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝ ",
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
      }

      alpha.setup(dashboard.opts)

      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
