local function tokens(num)
  return num * 1024
end

local M = {
  provider = "deepseek_mini",
  -- auto_suggestions_provider = "",
  ollama = {
    endpoint = "http://127.0.0.1:11434",
    model = "qwen2.5-coder", -- "ollama ls" for available models
    options = {
      num_ctx = tokens(32),
    },
    stream = true,
  },
  vendors = {
    qwen = {
      __inherited_from = "openai",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "qwen2.5-coder:7b",
      timeout = 30000,
      temperature = 0,
      max_completion_tokens = tokens(16),
      api_key_name = "",
      disable_tools = true,
    },

    deepseek_mini = {
      __inherited_from = "openai",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "deepseek-r1:1.5b",
      timeout = 30000,
      temperature = 0,
      max_completion_tokens = tokens(8),
      api_key_name = "",
      disable_tools = true,
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },

    deepseek_coder = {
      __inherited_from = "openai",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "deepseek-coder:6.7b",
      timeout = 30000,
      temperature = 0,
      max_completion_tokens = tokens(8),
      api_key_name = "",
      disable_tools = true,
    },

    deepseek = {
      __inherited_from = "openai",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "deepseek-r1:7b",
      timeout = 30000,
      temperature = 0,
      max_completion_tokens = tokens(8),
      api_key_name = "",
      disable_tools = true,
    },

    gemma = {
      __inherited_from = "openai",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "gemma3:4b",
      timeout = 30000,
      temperature = 0,
      max_completion_tokens = tokens(8),
      api_key_name = "",
      disable_tools = true,
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
  },
  behaviour = {
    auto_suggestions = false,
  },
  file_selector = {
    provider = "telescope",
  },
  history = {
    max_tokens = 140000,
  },
}

return M
