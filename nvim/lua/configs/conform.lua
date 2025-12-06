local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    astro = { "biome-check" },
    -- css = { "biome-check" },
    html = { "biome-check" },
    typescript = { "biome-check" },
    javascript = { "biome-check" },
    javascriptreact = { "biome-check" },
    typescriptreact = { "biome-check" },
    markdown = { "markdownlint-cli2", "prettierd" },
    json = { "deno_fmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
