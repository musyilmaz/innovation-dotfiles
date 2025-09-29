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

      -- Function to enable all LSP servers at once
      local function enable_lsp_servers()
        -- Configure all LSP servers using native vim.lsp.config
        vim.lsp.config("lua_ls", {
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

        vim.lsp.config("eslint", {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = lsp_eslint_settings,
        })

        vim.lsp.config("html", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("ts_ls", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("jsonls", {
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

        vim.lsp.config("cssls", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("tailwindcss", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("prismals", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("graphql", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("emmet_ls", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("astro", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("gopls", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        vim.lsp.config("rust_analyzer", {
          on_attach = on_attach,
          capabilities = capabilities,
        })

        -- Enable all configured LSP servers
        vim.lsp.enable({
          "lua_ls",
          "eslint",
          "html",
          "ts_ls",
          "jsonls",
          "cssls",
          "tailwindcss",
          "prismals",
          "graphql",
          "emmet_ls",
          "astro",
          "gopls",
          "rust_analyzer",
        })
      end

      -- Call the function to enable all LSP servers
      enable_lsp_servers()
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
