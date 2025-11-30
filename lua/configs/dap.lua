  local dap = require "dap"
  local dapui = require "dapui"

  -- require("dap-vscode-js").setup({
  --     debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  --     adapters = { "pwa-node", "pwa-chrome" },
  -- })
  require("dap-vscode-js").setup {
    debugger_path = "/Users/qc-bright/Project/vscode-js-debug/", -- Path to vscode-js-debug installation.
    adapters = {
      "chrome",
      "pwa-node",
      "pwa-chrome",
      "pwa-msedge",
      "node-terminal",
      "pwa-extensionHost",
      "node",
      "chrome",
      "dart",
    },
  }

  local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    },
  }

  dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = {
      vim.fn.stdpath "data" .. "/mason/packages/dart-debug-adapter/extension/out/dist/debug.js",
      "--observe",
    },
  }
  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug: npm run dev",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "/Users/qc-bright/.nvm/**" },
        internalConsoleOptions = "neverOpen",
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" }
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch current file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "/Users/qc-bright/.nvm/**" },
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Debug Chrome localhost:3000",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
      },
    }
  end

  dapui.setup {
    layouts = {
      {
        elements = {
          -- { id = 'repl', size = 0.01 },
          { id = "scopes", size = 0.6 },
          { id = "watches", size = 0.2 },
          { id = "breakpoints", size = 0.2 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = { "console" },
        size = 0.2,
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
    },
    floating = {
      max_height = 20, -- These can be integers or a float between 0 and 1.
      max_width = 100, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
        focus = { "<leader>df" },
      },
    },
  }

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
  vim.api.nvim_set_keymap(
    "n",
    "<leader>df",
    '<cmd>lua require("dapui").float_element()<CR>',
    { noremap = true, silent = true }
  )
