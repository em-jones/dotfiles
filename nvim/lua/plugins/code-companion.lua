return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "ravitemer/mcphub.nvim",
  },
  opts = {
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = os.getenv "CLAUDE_CODE_OAUTH_TOKEN",
            },
          })
        end,
      },
    },
    rules = {
      default = {
        description = "Rules for general coding tasks.",
        files = {
          "rules",
          ".specify/memory",
          { path = "CLAUDE.md", parser = "claude" },
        },
        is_preset = true,
      },
    },
    interactions = {
      chat = {
        adapter = "anthropic",
        model = "claude-haiku-4-5-20251001",
      },
    },
    opts = {
      chat = {
        enabled = true,
        default_rules = "default",
      },
      log_level = "DEBUG",
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
}
