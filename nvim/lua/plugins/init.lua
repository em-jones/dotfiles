-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local disabled_in_vs_code = require("custom.util").disabled_in_vs_code
return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require("devcontainer").setup {
        attach_mounts = {
          enabled = true,
          options = { "readonly" },
        },
        neovim_data = {
          enabled = true,
        },
        neovim_state = {
          enabled = true,
        },
      }
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    cmd = "MCPHub", -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "nvim/cmp",
    enabled = false,
  },
  -- {
  --   "synic/refactorex.nvim",
  --   ft = "elixir",
  --   ---@module "refactorex.nvim"
  --   ---@type refactorex.Config
  --   opts = {
  --     auto_update = true,
  --     pin_version = nil,
  --   }
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    cond = disabled_in_vs_code,
    config = function()
      require("bqf").setup {
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      }
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    cond = disabled_in_vs_code,
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
    "rmagatti/goto-preview",
    cond = disabled_in_vs_code,
    config = function()
      require("goto-preview").setup {
        width = 120, -- Width of the floating window
        height = 25, -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cond = disabled_in_vs_code,
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    cond = disabled_in_vs_code,
    ft = { "rust" },
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "ray-x/go.nvim",
    cond = disabled_in_vs_code,
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "mrcjkb/rustaceanvim",
    cond = disabled_in_vs_code,
    version = "^4", -- Recommended
    ft = { "rust" },
    init = function() end,
    config = function(_, opts)
      local dap = require "dap"
      dap.defaults.elixir.exception_breakpoints = {}
      dap.configurations.rust = {
        {
          type = "lldb",
          request = "launch",
          name = "Rust App",
          program = vim.fn.getcwd() .. "/target/debug/app", -- NOTE: Adapt path to manage.py as needed
        },
      }
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode-14", -- adjust as needed
        name = "lldb",
      }
    end,
  },
  {
    "saecki/crates.nvim",
    cond = disabled_in_vs_code,
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "ionide/Ionide-vim",
    cond = disabled_in_vs_code,
    ft = { "fsharp" },
    config = function()
      require("ionide").setup {}
    end,
  },
  {
    "gleam-lang/gleam.vim",
    cond = disabled_in_vs_code,
  },
  {
    "evanleck/vim-svelte",
    cond = disabled_in_vs_code,
    ft = { "svelte" },
    dependencies = { "pangloss/vim-javascript", "othree/html5.vim" },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "benfowler/telescope-luasnip.nvim",
    cond = disabled_in_vs_code,
    config = function()
      require("telescope").load_extension "luasnip"
    end,
  },
  { "github/copilot.vim", event = "BufEnter", cond = disabled_in_vs_code },
  {
    "allaman/kustomize.nvim",
    cond = disabled_in_vs_code,
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    config = function()
      require("kustomize").setup {
        enable_lua_snip = true,
      }
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cond = disabled_in_vs_code,
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
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      local hop = require "hop"
      hop.setup()
      if vim.g.vscode then
        local opts = { silent = true, noremap = false }
        local keymap = vim.api.nvim_set_keymap
        hop.setup {
          keys = "etovxqpdygfblzhckisuran",
        }
        local directions = require("hop.hint").HintDirection
        vim.keymap.set("", "s", function()
          hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
        end, { remap = true })
        vim.keymap.set("", "S", function()
          hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
        end, { remap = true })
        vim.keymap.set("", "t", function()
          hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
        end, { remap = true })
        vim.keymap.set("", "T", function()
          hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
        end, { remap = true })
      else
        vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    cond = disabled_in_vs_code,
    event = "BufRead",
    config = function()
      require("headlines").setup()
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    cond = disabled_in_vs_code,
    config = function()
      require("telescope").load_extension "frecency"
      require("telescope").load_extension "projects"
    end,
    dependencies = { "kkharji/sqlite.lua" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cond = disabled_in_vs_code,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
  {
    "b0o/schemastore.nvim",
    cond = disabled_in_vs_code,
    ft = { "json", "jsonc", "yaml", "yml" },
  },

  {
    "aserowy/tmux.nvim",
    cond = disabled_in_vs_code,
    lazy = false,
    config = function()
      require("tmux").setup()
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    cond = disabled_in_vs_code,
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
    cond = disabled_in_vs_code,
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    cond = disabled_in_vs_code,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = disabled_in_vs_code,
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
    "nvim-treesitter/nvim-treesitter",
    cond = disabled_in_vs_code,
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gotmpl",
        "yaml",
        "json",
        "vim",
        "lua",
        "html",
        "helm",
        "heex",
        "css",
        "javascript",
        "typescript",
        "terraform",
        "elixir",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    "ravsii/nvim-dap-envfile",
    version = "*", -- use latest stable release
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    cond = disabled_in_vs_code,
    ft = { "typescript", "typescriptreact", "python", "elixir", "cs", "fs", "rust", "go" },
    dependencies = { "folke/neodev.nvim", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      vim.fn.sign_define("DapBreakpoint", {
        text = "", -- Nerdfont icon or any character
        texthl = "DapBreakpointSymbol", -- Custom highlight group for the icon
        linehl = "DapBreakpoint", -- Custom highlight group for the entire line
        numhl = "DapBreakpoint", -- Custom highlight group for the line number
      })
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
      local dapui = require "dapui"
      dapui.setup()

      local dap = require "dap"
      dap.set_log_level "DEBUG"

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      require("nvim-dap-virtual-text").setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }
      local elixir_ls_debugger = vim.fn.expand "~/.local/share/nvim/mason/bin/elixir-ls-debugger"

      if elixir_ls_debugger ~= "" then
        dap.adapters.mix_task = {
          type = "executable",
          command = elixir_ls_debugger,
        }
      end

      vim.keymap.set("n", "<leader>dui", require("dapui").toggle)
      vim.keymap.set("n", "<leader>dc", require("dap").continue)
      vim.keymap.set("n", "<leader>do", require("dap").step_over)
      vim.keymap.set("n", "<leader>di", require("dap").step_into)
      vim.keymap.set("n", "L", require("dap").step_over)
      vim.keymap.set("n", "J", require("dap").step_into)
      vim.keymap.set("n", "<leader>iO", require("dap").step_out)
      vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
      vim.keymap.set("n", "<leader>gb", require("dap").run_to_cursor)
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)
      vim.keymap.set("n", "<leader>B", function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end)
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    cond = disabled_in_vs_code,
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
    "mxsdev/nvim-dap-vscode-js",
    cond = disabled_in_vs_code,
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
    cond = disabled_in_vs_code,
    ft = { "typescript", "typescriptreact" },
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "fatih/vim-go",
    cond = disabled_in_vs_code,
    ft = "go",
    config = function() end,
  },
  {
    "danymat/neogen",
    cond = disabled_in_vs_code,
    config = function()
      require("neogen").setup {}
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
}
