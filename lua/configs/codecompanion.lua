local M = {
  adapters = {
    http = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://127.0.0.1:11434",
          },
          schema = {
            model = {
              default = "gemma4:e4b",
            },
            temperature = {
              default = 0.1,
            },
            num_ctx = {
              default = 32768,
            },
          },
        })
      end,
    },
  },
  interactions = {
    chat = {
      adapter = {
        name = "ollama",
        model = "gemma4:e4b",
      },
      slash_commands = {
        ["buffer"] = {
          opts = {
            provider = "telescope",
          },
        },
        ["file"] = {
          opts = {
            provider = "telescope",
          },
        },
        ["help"] = {
          opts = {
            provider = "telescope",
          },
        },
      },
      opts = {
        completion_provider = "cmp",
      },
    },
    inline = {
      adapter = {
        name = "ollama",
        model = "gemma4:e4b",
      },
    },
  },
  display = {
    action_palette = {
      provider = "telescope",
    },
    chat = {
      auto_scroll = true,
      show_settings = true,
    },
  },
  opts = {
    log_level = "ERROR",
    send_code = true,
  },
}

return M