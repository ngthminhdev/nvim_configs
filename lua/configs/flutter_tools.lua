local M = {}

function M.setup()
  -- Tự động detect Flutter SDK path
  local function get_flutter_sdk()
    local search_from = vim.api.nvim_buf_get_name(0)
    if search_from == "" then
      search_from = vim.fn.getcwd()
    else
      search_from = vim.fs.dirname(search_from)
    end

    local fvm_flutter = vim.fs.find(".fvm/flutter_sdk", {
      upward = true,
      path = search_from,
      type = "directory",
    })[1]

    if fvm_flutter and vim.fn.isdirectory(fvm_flutter) == 1 then
      return vim.fs.normalize(fvm_flutter)
    end

    -- Fallback: dùng flutter từ PATH
    local flutter_path = vim.fn.exepath "flutter"
    if flutter_path ~= "" then
      return vim.fn.fnamemodify(flutter_path, ":h:h") -- Remove /bin/flutter
    end

    return nil
  end

  require("flutter-tools").setup {
    fvm = true,
    debugger = {
      enabled = true,
      run_via_dap = true,
      register_configurations = function(paths)
        local dap = require "dap"
        dap.adapters.dart = {
          type = "executable",
          command = paths.flutter_bin,
          args = { "debug_adapter" },
        }
        dap.configurations.dart = {
          {
            type = "dart",
            request = "launch",
            name = "Launch Flutter App",
            dartSdkPath = paths.dart_sdk,
            flutterSdkPath = paths.flutter_sdk,
            program = "${workspaceFolder}/lib/main.dart",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            logOutput = "std",
            showDebugOutput = true,
          },
          {
            type = "dart",
            request = "attach",
            name = "Attach to Flutter Process",
            dartSdkPath = paths.dart_sdk,
            flutterSdkPath = paths.flutter_sdk,
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            logOutput = "std",
            showDebugOutput = true,
          },
        }
      end,
    },
    flutter_path = nil, -- auto detect from FVM or PATH
    flutter_lookup_cmd = nil,
    widget_guides = { enabled = true },
    closing_tags = {
      highlight = "Comment",
      prefix = "// ",
      enabled = true,
    },
    lsp = {
      color = { enabled = true, background = true, virtual_text = true },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
          analysisExcludedFolders = {
            vim.fn.expand "$HOME/.pub-cache",
            vim.fn.expand "$HOME/fvm",
          },
          updateImportsOnRename = true,
          lineLength = 120,
        },
      },
      on_attach = function(client, bufnr)
        -- Flutter specific keymaps
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<cr>", opts)
        vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", opts)
        vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<cr>", opts)
        vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<cr>", opts)
        vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<cr>", opts)
        vim.keymap.set("n", "<leader>fo", "<cmd>FlutterOutlineToggle<cr>", opts)
        vim.keymap.set("n", "<leader>fl", "<cmd>FlutterLogClear<cr>", opts)
      end,
    },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    dev_log = {
      enabled = true,
      notify_errors = true,
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
  }

  -- Manual setup DAP configurations cho Dart (fallback nếu register_configurations chưa chạy)
  local dap = require "dap"
  local flutter_sdk = get_flutter_sdk()

  if flutter_sdk then
    dap.adapters.dart = {
      type = "executable",
      command = flutter_sdk .. "/bin/flutter",
      args = { "debug_adapter" },
    }

    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch Flutter App",
        dartSdkPath = flutter_sdk .. "/bin/cache/dart-sdk",
        flutterSdkPath = flutter_sdk,
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        logOutput = "std",
        showDebugOutput = true,
      },
      {
        type = "dart",
        request = "attach",
        name = "Attach to Flutter Process",
        dartSdkPath = flutter_sdk .. "/bin/cache/dart-sdk",
        flutterSdkPath = flutter_sdk,
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        logOutput = "std",
        showDebugOutput = true,
      },
      {
        type = "dart",
        request = "launch",
        name = "Launch Dart CLI",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        logOutput = "std",
        showDebugOutput = true,
      },
    }
  end
end

return M
