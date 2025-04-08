return {
  -- Conform | Formatter
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettierd", "prettier", stop_after_first = true },
          jsonc = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt", lsp_format = "fallback" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          async = false,
          lsp_format = "fallback",
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },

  -- Comment.nvim
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
        sticky = true,
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },

  -- TODO Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>tq",
        "<cmd>TodoQuickFix<cr>",
        desc = "TODO - Quickfix",
      },
      {
        "<leader>tt",
        "<cmd>TodoTelescope<cr>",
        desc = "TODO - Telescope",
      },
    },
    opts = {},
  },

  -- NVIM-AUTOPAIRS
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
        enable_check_bracket_line = false,
      })

      -- import nvim-autopairs completion functionality
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- import nvim-cmp plugin (completions plugin)
      local cmp = require("cmp")

      -- make autopairs and completion work together
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- SURROUND
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },

  -- Comment Divider
  {
    "fangjunzhou/comment-divider.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cdb", "<CMD>CommentDividerBox<CR>" },
      { "<leader>cdl", "<CMD>CommentDividerLine<CR>" },
    },
  },

  -- Chainsaw Console.logs
  {
    "chrisgrieser/nvim-chainsaw",
    event = "VeryLazy",
    opts = {
      marker = "❗",
      logStatements = {
        objectLog = {
          -- repurposing objectLog for debugging via AppleScript notification
          sh = [[osascript -e "display notification \"%s %s\" with title \"$%s\""]],
        },
      },
    },
    keys = {
      {
        "<leader>ll",
        function()
          require("chainsaw").variableLog()
        end,
        mode = { "n", "x" },
        desc = "󰸢 variable",
      },
      {
        "<leader>lo",
        function()
          require("chainsaw").objectLog()
        end,
        mode = { "n", "x" },
        desc = "󰸢 object",
      },
      {
        "<leader>lm",
        function()
          require("chainsaw").messageLog()
        end,
        desc = "󰸢 message",
      },
      {
        "<leader>lt",
        function()
          require("chainsaw").timeLog()
        end,
        desc = "󰸢 time",
      },
      {
        "<leader>lr",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "󰹝 remove logs",
      },
    },
    config = function()
      require("chainsaw").setup({
        logStatements = {
          variableLog = {
            javascript = 'console.log("{{marker}} {{filename}}:{{lnum}} -- {{var}}:", {{var}});',
          },
          objectLog = {
            javascript = 'console.log("{{marker}} {{filename}}:{{lnum}} -- {{var}}:", JSON.stringify({{var}}, null, 2))',
          },
        },
      })
    end,
  },

  -- LEAP.nvim
  {
    "ggandor/leap.nvim",
    config = function()
      local keymap = vim.keymap
      local keymap_opts = { noremap = true, silent = true }

      keymap.set("n", "s", "<Plug>(leap-anywhere)", keymap_opts)
    end,
  },
}
