return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })

      telescope.load_extension("fzf")

      local keymap = vim.keymap

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
      keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>")
      keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
    end,
  },
}
