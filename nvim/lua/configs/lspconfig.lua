require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {
    filetypes = { "html" },
  },
  cssls = {},
  tailwindcss = {
    filetypes = {
      "html",
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "heex",
      "eex",
      "elixir",
      "eelixir",
    },
    settings = {},
  },
  ts_ls = {},
  tofu_ls = {
    filetypes = { "terraform", "terraform-vars", "tofu", "tf", "tfvars" },
  },
  -- expert = {},
  elixirls = {
    cmd = { "elixir-ls" },
    filetypes = { "elixir", "eelixir", "heex", "eex" },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>fp", ":Elixir from-pipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":Elixir to-pipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<space>em", ":Elixir alias-refactor<cr>", { buffer = true, noremap = true })
    end,
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        suggestSpecs = true,
        fetchDeps = true,
        enableTestLenses = true,
        signatureAfterComplete = true,
      },
    },
  },
  terraform_ls = {},
  gopls = {},
  svelte = {},
  astro = {},
  yamlls = {},
  jsonls = {},
}
for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- read :h vim.lsp.config for changing options of lsp servers
