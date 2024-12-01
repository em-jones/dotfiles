-- load defaults i.e lua_lsp
if vim.g.vscode then
else
  require("nvchad.configs.lspconfig").defaults()

  local lspconfig = require "lspconfig"
  
  -- EXAMPLE
  local servers = { "html", "cssls", "nixd" }
  local nvlsp = require "nvchad.configs.lspconfig"
  local on_attach = nvlsp.on_attach
  local on_init = nvlsp.on_init
  local capabilities = nvlsp.capabilities

  -- if you just want default config for the servers then put them in a table
  local servers = { "html", "cssls", "clangd", "terraformls",  "templ", "nixd"  }
  lspconfig.pylsp.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          mypy = {
            enabled = true,
            live_mode= false

          }
        }
      }
    }
  }
  
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init,
    }
  end
  lspconfig.gleam.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init,
    filetypes = { "gleam" },
  }
  
  lspconfig.ts_ls.setup {
    filetypes = { "typescriptreact", "typescript", "svelte" },
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init
  }
  
  lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      userLanguages = {
        elixir = "html-eex",
        eelixir = "html-eex",
        heex = "html-eex",
      },
    },
    filetypes = {
      "html",
      "astro",
      "typescriptreact",
      "svelte",
      "vue",
      "css",
      "templ",
      "heex",
      "eex",
      "gleam",
      "elixir",
      "eelixir",
    },
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" }, -- class-variance-authority settings
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { 'class[:]\\s*"([^"]*)"' },
          },
        },
      },
    },
  }
  
  lspconfig.htmx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "astro", "templ", "heex", "eex", "gleam", "elixir" },
  }
  
  lspconfig.astro.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "astro" },
    init_options = {
      typescript = {
        tsdk = "/home/em/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
      },
    },
  }
  
  lspconfig.svelte.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init,
    filetypes = { "svelte" },
  }
  
  lspconfig.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = { "terraform", "terraform-vars" },
    cmd = { "terraform-ls", "serve" },
  }
  
  lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = { "go", "templ" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }
  
  -- lspconfig.omnisharp.setup {
  --   cmd = { "/home/em/.local/share/nvim/mason/bin/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  --   enable_editorconfig_support = true,
  --   enable_roslyn_analyzers = true,
  --   organize_imports_on_format = true,
  --   enable_import_completion = true,
  -- }
  
  lspconfig.jsonls.setup {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas,
        validate = { enable = true },
      },
    },
  }

  lspconfig.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      validate = true,
    },
  }
  lspconfig.ruff.setup {}

  lspconfig.emmet_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "svelte", "vue", "astro", "heex", "eex", "templ", "typescriptreact", "svelte" },
  }


end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
