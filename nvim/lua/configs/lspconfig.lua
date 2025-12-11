require("nvchad.configs.lspconfig").defaults()
local elixir_lsp = os.getenv "ELIXIR_LSP" or "expert"
local removed_lsp = elixir_lsp == "expert" and "elixirls" or "expert"
local servers = {
  html = {
    filetypes = { "html" },
  },
  fish_ls = {},
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
  expert = {
    cmd = { "expert", "--stdio" },
    root_markers = { ".git", "mix.exs" },
    filetypes = { "elixir", "eelixir", "heex" },
  },
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
  pyright = {},
  vale_ls = {},
}
for name, opts in pairs(servers) do
  if name == removed_lsp then
    goto continue
  end
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
  ::continue::
end

-- read :h vim.lsp.config for changing options of lsp servers
