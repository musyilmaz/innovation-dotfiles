require("atlas.core")
require("atlas.lazy")

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "n:i", "v:s" },
  desc = "Disable diagnostics in insert and select mode",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "i:n" },
  desc = "Enable diagnostics in insert and select mode",
  callback = function()
    vim.diagnostic.enable(true)
  end,
})
