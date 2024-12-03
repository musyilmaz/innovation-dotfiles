return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {},
    config = function()
      local bufferline = require("bufferline")

      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.minimal,
          numbers = "ordinal",
          indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "icon",
          },
          diagnostics = "nvim_lsp",
          diagnostics_update_on_event = true,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          separator_style = "thick",
        },
      })
    end,
  },
}
