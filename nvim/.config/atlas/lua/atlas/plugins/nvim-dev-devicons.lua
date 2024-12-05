return {
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
}
