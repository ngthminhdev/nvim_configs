-- configs/dap.lua

local dap = require('dap')
local dapui = require('dapui')

-- -- Dart
-- dap.adapters.dart = {
--     type = 'executable',
--     command = '/home/ngthminhdev/fvm/versions/2.8.1/bin/dart',
--     -- command = '${workspaceFolder}/.fvm/flutter_sdk',
--     args = { 'debug_adapter' }
-- }
--
-- -- Flutter
-- dap.adapters.flutter = {
--     type = 'executable',
--     -- command = '/home/ngthminhdev/fvm/versions/2.8.1/bin/flutter',
--     command = '/home/ngthminhdev/fvm/versions/3.24.3/bin/flutter',
--     args = { 'debug_adapter' }
-- }
--
--
-- dap.configurations.dart = {
--     {
--         type = "flutter",
--         request = "launch",
--         name = "[Development] KPOS",
--         args = {
--             "--flavor", "development",
--         },
--         dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
--         flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--         platform = "android", -- Chỉ định platform (android hoặc ios)
--         autoReload = {
--             enable = true,
--         },
--     },
--     {
--         type = "flutter",
--         request = "launch",
--         name = "[Local] KPOS",
--         args = {
--             "--flavor", "local",
--         },
--         dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
--         flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--         platform = "android", -- Chỉ định platform (android hoặc ios)
--         autoReload = {
--             enable = true,
--         },
--     },
--     {
--         type = "flutter",
--         request = "launch",
--         name = "[Staging] KPOS",
--         args = {
--             "--flavor", "local",
--         },
--         dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
--         flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
--         program = "${workspaceFolder}/lib/main_staging.dart",
--         cwd = "${workspaceFolder}",
--         platform = "android", -- Chỉ định platform (android hoặc ios)
--     },
--     {
--         type = "flutter",
--         request = "launch",
--         name = "[Production] KPOS",
--         args = {
--             "--flavor", "local",
--         },
--         dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
--         flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
--         program = "${workspaceFolder}/lib/main_production.dart",
--         cwd = "${workspaceFolder}",
--         platform = "android", -- Chỉ định platform (android hoặc ios)
--     },
--     {
--         type = "dart",
--         request = "launch",
--         name = "Launch dart",
--         dartSdkPath = "/snap/bin/dart",
--         flutterSdkPath = "/snap/bin/flutter",
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--     },
--     {
--         type = "flutter",
--         request = "launch",
--         name = "Launch flutter",
--         dartSdkPath = '/home/ngthminhdev/fvm/versions/3.24.3/bin/dart',
--         flutterSdkPath = '/home/ngthminhdev/fvm/versions/3.24.3/bin/flutter',
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--     },
-- }

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug: npm run debug",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "debug" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
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

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end
--
-- dap.defaults.dart.exception_breakpoints = { "uncaught" }
--
dap.listeners.after.event_breakpoint['dart-debug'] = function(session, body)
    -- Tự động cập nhật ID breakpoint
    if body.reason == 'changed' and body.breakpoint.id then
        for _, bp in pairs(session.breakpoints) do
            if bp.line == body.breakpoint.line then
                bp.id = body.breakpoint.id
            end
        end
    end
end
