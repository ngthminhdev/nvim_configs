vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
-- Fold settings
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.foldlevel = 20

vim.opt.encoding = 'UTF-8'
vim.opt.number = true
-- vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.mouse = 'a'
vim.opt.completeopt = {'menuone', 'noselect'}
vim.highlight.priorities.semantic_tokens = 95

vim.o.swapfile = false
vim.opt.wrap = true

vim.g.python3_host_prog = vim.fn.getcwd() .. '/.venv/bin/python'
-- Bật tô màu cú pháp trong init.lua
vim.cmd('syntax enable')
vim.cmd('syntax on')

-- vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='DapBreakpoint', numhl=''})
-- vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
--
-- vim.cmd [[
--   highlight DapStopped guibg=#3c3836
-- ]]

vim.g.flutter_tools_hot_reload_on_save = 1

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end


vim.api.nvim_set_keymap('i', 'clg', [[console.log()<Left>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jlg', [[console.log(`${JSON.stringify(, null, 1) }`)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]], { noremap = true, silent = true })

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

local function configure_hop()
  local hop = require('hop')
  hop.setup()

  local directions = require('hop.hint').HintDirection

  vim.keymap.set('n', '<leader>s', function()
    hop.hint_char1({ current_line_only = false })
  end, { silent = true, noremap = true, desc = "Hop to character" })


  vim.keymap.set('n', '<leader>2s', function()
    hop.hint_char2({ current_line_only = false })
  end, { silent = true, noremap = true, desc = "Hop to 2 characters" })


  vim.keymap.set('n', '<leader>ws', function()
    hop.hint_words({ current_line_only = false })
  end, { silent = true, noremap = true, desc = "Hop to word" })

end

if vim.g.vscode then

else
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
  {
    "phaazon/hop.nvim",
    lazy = false,
    branch = "v2",
    config = configure_hop,
  },
  { import = "plugins" },
}, lazy_config)

require "nvchad.autocmds"

-- local dap = require('dap')
-- local dapui = require('dapui')
--
-- require("dapui").setup({
--   layouts = {
--       {
--         elements = {
--           -- { id = 'repl', size = 0.01 },
--           { id = 'scopes', size = 0.35 },
--           { id = 'watches', size = 0.35 },
--           { id = 'breakpoints', size = 0.3 },
--         },
--         size = 40,
--         position = 'left',
--       },
--       {
--         elements = { 'repl' },
--         -- elements = { },
--         size = 0.2,
--         position = 'bottom',
--       },
--     },
--   controls = {
--     enabled = true,
--     element = "repl",
--   },
--   floating = {
--     max_height = 15, -- These can be integers or a float between 0 and 1.
--     max_width = 80, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--       focus = { "<leader>df" },
--     },
--   },
-- })
-- vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua require("dapui").float_element()<CR>', { noremap = true, silent = true })
--
-- require('nvim-dap-repl-highlights').setup_highlights('dart')
--
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open({})
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close({})
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close({})
-- end
--
-- dap.defaults.dart.exception_breakpoints = { "uncaught" }
--
-- dap.listeners.after.event_breakpoint['dart-debug'] = function(session, body)
--     -- Tự động cập nhật ID breakpoint
--     if body.reason == 'changed' and body.breakpoint.id then
--         for _, bp in pairs(session.breakpoints) do
--             if bp.line == body.breakpoint.line then
--                 bp.id = body.breakpoint.id
--             end
--         end
--     end
-- end
--
-- require("dap-vscode-js").setup({
--   debugger_path = "/home/ngthminhdev/Services/vscode-js-debug", -- Path to vscode-js-debug installation.
--   adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }
-- })
--
-- local js_based_languages = { "typescript", "javascript", "typescriptreact" }
--
-- for _, language in ipairs(js_based_languages) do
--   require("dap").configurations[language] = {
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'KingFood Backend Service Debug',
--       program = '${workspaceFolder}/node_modules/.bin/nodemon',
--       args = {'--inspect', '--config', 'nodemon.json', 'index.js'},
--       cwd = '${workspaceFolder}',
--       runtimeExecutable = 'node',
--       runtimeArgs = {'--nolazy'}
--     },
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "attach",
--       name = "Attach",
--       processId = require 'dap.utils'.pick_process,
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-chrome",
--       request = "launch",
--       name = "Start Chrome with \"localhost\"",
--       url = "http://localhost:3000",
--       webRoot = "${workspaceFolder}",
--       userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
--     }
--   }
-- end
--
end

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")


vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_set_keymap('n', '<Leader>gf', ':LazyGit<CR>', { silent = true })

dofile(vim.g.base46_cache .. "syntax")

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(false, { 0 })
end

vim.lsp.set_log_level('debug')
require("telescope").load_extension("aerial")
