local mason_path = "$HOME/.local/share/nvim/mason"
local map = vim.keymap.set
return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    lazy = false,
    config = function()
      -- This will load fzy_native and have it override the default file sorter
      -- You dont need to set any of these options. These are the default ones. Only
      -- the loading is important
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension('fzf')
      local mappings = {
        ["<leader>gd"] = { "<cmd>Telescope lsp_definitions<cr>", "goto def" },
        ["<leader>tt"] = { "<cmd>Telescope diagnostics<cr>", "goto def" },
        ["<leader>tr"] = { "<cmd>Telescope lsp_references<cr>", "goto def" },
        -- find
        ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
        ["<leader>fs"] = { "<cmd> w <CR>", "Save file" },
        ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
        ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

        -- git
        ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

        -- pick a hidden term
        ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

        -- theme switcher
        ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

        ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
      }
      for k, v in pairs(mappings) do
        map("n", k, v[1], {desc = v[2]})
      end
    end
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/orgfiles/review.org',
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
    },
    config = function ()
        require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
        require("csharp").setup()
    end
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvimtree"),
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
        "html", "css", "terraform", "nix",
        "fsharp"
  		},
  	},
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup {
        auto_load = true,
        close_on_bdelete = true,
        syntax = false,
        update_on_change = true,
        app = "browser",
        filetype = { "markdown" },
      }
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "michaelb/sniprun",
    build = "sh install.sh",
    lazy = false,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function(_, opts)
      local rainbow_delimiters = require "rainbow-delimiters"
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        nextls = { enable = false },
        credo = { enable = false },
        elixirls = {
          cmd = "/home/em/.local/share/nvim/mason/bin/elixir-ls",
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            enableTestLenses = true,
            suggestSpecs = false,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {"gleam-lang/gleam.vim"},
  {
    "ionide/Ionide-vim",
    ft = { "fsharp" },
    config = function()
      require("ionide").setup {}
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc", "yaml", "yml" },
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
          },
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "svelte", "vue", "astro", "xml", "markdown" },
    config = function()
      require("nvim-ts-autotag").setup {
        autotag = {
          enable = true,
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "aserowy/tmux.nvim",
    lazy = false,
    config = function()
      require("tmux").setup()
    end,
  },
  { "dhruvasagar/vim-table-mode" },
  {
    "rcarriga/nvim-dap-ui",
    ft = { "typescript", "typescriptreact", "python", "elixir", "cs", "fs", "rust", "go" },
    dependencies = { "folke/neodev.nvim", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
      local dapui = require "dapui"
      dapui.setup()
      local dap = require "dap"
      dap.listeners.before.attach["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end

      -- require("nvim-dap-virtual-text").setup {
      --   -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
      --   display_callback = function(variable)
      --     local name = string.lower(variable.name)
      --     local value = string.lower(variable.value)
      --     if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
      --       return "*****"
      --     end
      --
      --     if #variable.value > 15 then
      --       return " " .. string.sub(variable.value, 1, 15) .. "... "
      --     end
      --
      --     return " " .. variable.value
      --   end,
      -- }

      local elixir_ls_debugger = "/home/em/.local/share/nvim/mason/bin/elixir-ls-debugger"
      if elixir_ls_debugger ~= "" then
        dap.adapters.mix_task = {
          type = "executable",
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = "mix_task",
            name = "phoenix server",
            task = "phx.run",
            request = "launch",
            projectDir = "${workspaceFolder}",
            debugAutoInterpretAllModules = false,
            debugInterpretModulesPatterns = { "FsWeb.*", "Fs.*", "Ash.*" },
            exitAfterTaskReturns = false,
          },
        }
      end

      map("n", "<leader>dui", require("dapui").toggle)
      map("n", "<leader>ic", require("dap").continue)
      map("n", "<leader>io", require("dap").step_over)
      map("n", "<leader>ii", require("dap").step_into)
      map("n", "L", require("dap").step_over)
      map("n", "J", require("dap").step_into)
      map("n", "<leader>iO", require("dap").step_out)
      map("n", "<leader>b", require("dap").toggle_breakpoint)
      map("n", "<leader>gb", require("dap").run_to_cursor)
      map("n", "<leader>B", function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end)
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "python" },
    config = function()
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
      local dap = require "dap"
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django",
        program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
        args = { "runserver" },
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = { "golang" },

    config = function()
      require("dap-go").setup {
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = "dlv",
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port
          port = "${port}",
          -- additional args to pass to dlv
          args = {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          build_flags = "",
        },
      }
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "typescript", "typescriptreact" },
    dependencies = { "mfussenegger/nvim-dap" },

    config = function()
      require("dap-vscode-js").setup {
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = "/home/em/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "chrome" }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      }
      local dap_utils = require "dap.utils"

      for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact", "" } do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            command = "pnpm turbo devnew",
            name = "NPM Run Dev",
            request = "launch",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Program (pwa-node, select pid)",
            cwd = vim.fn.getcwd(),
            processId = dap_utils.pick_process,
            skipFiles = { "<node_internals>/**" },
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with Localhost",
            url = "http://localhost:4321",
            webRoot = "${workspaceFolder}/apps/poc",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
          },
        }
      end
    end,
  },
  {
    "microsoft/vscode-js-debug",
    ft = { "typescript", "typescriptreact" },
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "fatih/vim-go",
    ft = "go",
    config = function() end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {}
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
    dependencies = { "kkharji/sqlite.lua" },
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    lazy = false,
    config = function()
      require("telescope").load_extension "emoji"
    end,
  },
  -- {
  --   "barrett-ruth/import-cost.nvim",
  --   build = "sh install.sh npm",
  --   ft = { "typescript", "typescriptreact" },
  --   keys = {
  --     { "<leader>tic", "import-cost" },
  --   },
  --   config = function()
  --     require("import-cost").setup {}
  --   end,
  -- },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    dependencies = { "kristijanhusak/vim-dadbod-completion", "tpope/vim-dadbod" },
    config = function()
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufEnter", {
        callback = function()
          require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
        end,
      })
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    event = "BufRead",
    config = function()
      if vim.g.vscode then
      else
        require("headlines").setup()
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest",
      "Issafalcon/neotest-dotnet",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-python",
      "jfpedroza/neotest-elixir",
    },
    ft = { "go", "typescriptreact", "javascriptreact" },
    init = function()
      local ntest_run = "<cmd>lua require('neotest').run.run"
      local mappings = {
        ["<leader>rt"] = { ntest_run .. "()<CR>", "Test nearest" },
        ["<leader>rT"] = { ntest_run .. "({strategy='dap'})<CR>", "Debug nearest" },
        ["<leader>Rt"] = { ntest_run .. "({vim.fn.expand('%')})<CR>", "Test file" },
        ["<leader>RT"] = { ntest_run .. "({vim.fn.expand('%'),strategy = 'dap'})<CR>", "Debug file" },
        ["<leader>rr"] = { ntest_run .. "_last()<CR>", "Run last" },
        ["<leader>RR"] = { ntest_run .. "({strategy='dap'})<CR>", "Debug last" },
        ["<leader>rw"] = { "<cmd>lua require('neotest').watch.toggle()<CR>", "Debug last" },
      }
      for k, v in pairs(mappings) do
        map("n", k, v[1], {desc = v[2]})
      end
    end,
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup {
        adapters = {
          require "neotest-go",
          require "neotest-vitest",
          require "neotest-dotnet" {
            dap_adapter = "lldb",
          },
          require "neotest-elixir" {
            mix_task = "test",
          },
          require "neotest-rust" {},

          require "neotest-python" {
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false, console = "integratedTerminal" },
            -- Command line arguments for runner
            -- Can also be a function to return dynamic values
            args = { "--log-level", "DEBUG" },
            -- Runner to use. Will use pytest if available by default.
            -- Can be a function to return dynamic value.
            runner = "pytest",
            -- Custom python path for the runner.
            -- Can be a string or a list of strings.
            -- Can also be a function to return dynamic value.
            -- If not provided, the path will be inferred by checking for
            -- virtual envs in the local directory and for Pipenev/Poetry configs
            python = "./venv/bin/python",
            -- Returns if a given file path is a test file.
            -- NB: This function is called a lot so don't perform any heavy tasks within it.
            -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
            -- instances for files containing a parametrize mark (default: false)
            pytest_discover_instances = true,
          },
        },
      }
    end,
  },
  { "github/copilot.vim", event = "BufEnter" },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
}
