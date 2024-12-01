local options = {
  lsp_fallback = true,

  formatters = {},
  formatters_by_ft = {
    lua = { "stylua" },
    elixir = { "mix" },
    rust = { "rustfmt" },
    python = {"ruff"},

    javascript = { "deno" },
    -- css = { "prettier" },
    -- html = { "prettier" },

    sh = { "shfmt" },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 200,
    lsp_format = "fallback",
  },
}
return options
