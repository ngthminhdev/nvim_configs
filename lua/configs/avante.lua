local function tokens(num)
  return num * 1024
end

local M = {
  -- provider = "ollama",
  -- provider = "gemini",
  provider = "copilot",

  providers = {
    ollama = {
      endpoint = "http://127.0.0.1:11434",
      model = "gpt-oss:20b", -- dùng `ollama ls` để xem models có sẵn
      extra_request_body = {
        options = {
          num_ctx = tokens(32),
        },
      },
      stream = true,
    },
  },

  -- vendors = {
  --   deepseek = {
  --     -- nếu vendor này thực sự dùng cùng endpoint/compat của ollama,
  --     -- nên kế thừa từ "ollama" thay vì "openai"
  --     __inherited_from = "ollama",
  --     endpoint = "http://127.0.0.1:11434/v1",
  --     model = "deepseek-r1:14b",
  --     timeout = 30000,
  --     temperature = 0,
  --     max_completion_tokens = tokens(8),
  --     api_key_name = "",
  --     disable_tools = true,
  --   },
  -- },

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
