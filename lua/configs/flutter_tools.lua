-- configs/flutter-tools.lua

local status, flutter_tools = pcall(require, "flutter-tools")
if not status then
  return
end

flutter_tools.setup {
  ui = {
    border = "rounded",
    notification_style = 'plugin',
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    }
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = {}
  },
  -- flutter_path = "/snap/bin/flutter", -- Customize this if needed
  flutter_path = "/home/ngthminhdev/fvm/versions/2.8.1/bin/flutter", -- Customize this if needed
  flutter_lookup_cmd = nil, -- Customize this if needed
  fvm = false,
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "ErrorMsg",
    prefix = "//",
    enabled = true,
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit",
  },
  dev_tools = {
    autostart = false,
    auto_open_browser = false,
  },
  outline = {
    open_cmd = "30vnew",
    auto_open = false,
  },
  lsp = {
    color = {
      enabled = true,
      background = true,
      virtual_text = true,
      virtual_text_str = "■",
    },
    on_attach = require("configs.lspconfig").on_attach,
    capabilities = require("configs.lspconfig").capabilities,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
      renameFilesWithClasses = "prompt",
      enableSnippets = true,
    },
  },
}

