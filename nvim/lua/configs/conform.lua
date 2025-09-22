local options = {
  formatters_by_ft = {
    astro = { "prettier" },
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 300,
    lsp_fallback = true,
  },
}

return options
