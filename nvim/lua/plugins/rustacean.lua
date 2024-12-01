local map = vim.keymap.set
return {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    init = function()
    end,
    config = function(_, opts)
      local dap = require "dap"
      dap.configurations.rust = {
        {
          type = "lldb",
          request = "launch",
          name = "Rust App",
          program = vim.fn.getcwd() .. "/target/debug/app", 
        },
      }
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode-14", -- adjust as needed
        name = "lldb",
      }
    end,
  }
