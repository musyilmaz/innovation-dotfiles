local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "󰌵",
}

local diagnostic_error_colors = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticError",
  [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

local lsp_eslint_settings = {
  codeAction = {
    disableRuleComment = {
      enable = true,
      location = "separateLine",
    },
    showDocumentation = {
      enable = true,
    },
  },
  codeActionOnSave = {
    enable = false,
    mode = "all",
  },
  experimental = {
    useFlatConfig = false,
  },
  format = true,
  nodePath = "",
  onIgnoredFiles = "off",
  problems = {
    shortenToSingleLine = false,
  },
  quiet = false,
  rulesCustomizations = {},
  run = "onType",
  useESLintClass = false,
  validate = "on",
  workingDirectory = {
    mode = "location",
  },
}

local function virtual_text_format(diagnostic)
  return string.format("%s", diagnostic_signs[diagnostic.severity])
end

local function virtual_lines_format(diagnostic)
  return string.format(
    "%s %s (%s): %s",
    diagnostic_signs[diagnostic.severity],
    diagnostic.source,
    diagnostic.code,
    diagnostic.message
  )
end

local function on_attach_keymaps(_, bufnr)
  local keymap = vim.keymap
  local keymap_opts = { noremap = true, silent = true }

  keymap_opts.buffer = bufnr

  keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, keymap_opts)
  keymap.set("n", "<leader>gd", vim.lsp.buf.definition, keymap_opts)
  keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, keymap_opts)
  keymap.set("n", "<leader>go", vim.lsp.buf.type_definition, keymap_opts)
  keymap.set("n", "<leader>gr", vim.lsp.buf.references, keymap_opts)
  keymap.set("n", "<leader>gl", vim.diagnostic.open_float, keymap_opts)
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
end

return {
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      { "b0o/schemastore.nvim" },
      { "saghen/blink.cmp" },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = on_attach_keymaps
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      vim.diagnostic.config({
        virtual_text = {
          prefix = "",
          hl_mode = "blend",
          virt_text_pos = "right_align",
          format = virtual_text_format,
        },
        virtual_lines = {
          current_line = true,
          format = virtual_lines_format,
        },
        signs = {
          text = diagnostic_signs,
          linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
          },
          numhl = diagnostic_error_colors,
        },
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
        },
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              disable = { "missing-fields" },
            },
          },
        },
      })

      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = lsp_eslint_settings,
      })

      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas({}),
            validate = { enable = true },
          },
        },
      })

      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.prismals.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.graphql.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.emmet_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.astro.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },

  -- MASON
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "astro",
          "bashls",
          "cssls",
          "cssmodules_ls",
          "tailwindcss",
          "docker_compose_language_service",
          "dockerls",
          "gopls",
          "graphql",
          "html",
          "eslint",
          "ts_ls",
          "jsonls",
          "lua_ls",
          "prismals",
        },
        automatic_installation = true,
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "isort",
          "black",
          "eslint_d",
          "eslint",
        },
      })
    end,
  },
}
