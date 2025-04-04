return {
  -- LUALINE
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status")

      lualine.setup({
        options = {
          icons_enables = true,
          theme = "tokyonight",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      })
    end,
  },

  -- BUFFERLINE
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
          diagnostics_indicator = function(count, level, _, _)
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

  -- NVIM-TREE
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local nvimtree = require("nvim-tree")
      local keymap = vim.keymap

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
      vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

      nvimtree.setup({
        view = {
          width = 35,
          relativenumber = true,
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "",
                arrow_open = "",
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".DS_Store", "node_modules" },
        },
        git = {
          ignore = false,
        },
      })

      keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
    end,
  },

  -- Maximizer
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<cr>", desc = "Maximize/minimize a split" },
    },
  },
}
