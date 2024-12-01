require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "tofu_ls", "terraform_ls", "gopls", "svelte" }
vim.lsp.enable(servers)
vim.lsp.config("tofu_ls", {
  filetypes = { "terraform", "terraform-vars", "tofu", "tf", "tfvars" },
})
vim.lsp.config("html", {
  filetypes = { "html" },
})
vim.lsp.config("tailwindcss", {
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
})
vim.lsp.config("emmet_ls", {
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
})
vim.lsp.config("elixirls", {
  cmd = { "/home/em/.local/share/nvim/mason/bin/elixir-ls" },
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
})
vim.lsp.enable "elixirls"

-- read :h vim.lsp.config for changing options of lsp servers
