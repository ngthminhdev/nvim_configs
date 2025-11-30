vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- Fold settings
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 20

vim.opt.encoding = "UTF-8"
vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = "a"
vim.opt.completeopt = { "menuone", "noselect" }
vim.hl.priorities.semantic_tokens = 95

vim.opt.guicursor = "n-v-c-sm:block," .. "i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150," .. "r-cr-o:hor20"
vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
vim.api.nvim_set_hl(0, "TermCursor", { reverse = true })

vim.o.swapfile = false
vim.opt.wrap = true

vim.g.python3_host_prog = vim.fn.getcwd() .. "/.venv/bin/python"
-- Bật tô màu cú pháp trong init.lua
vim.cmd "syntax enable"
vim.cmd "syntax on"

vim.g.flutter_tools_hot_reload_on_save = 1

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<D-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

if vim.g.vscode then
else
  -- load pluginszzj
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
    { import = "plugins" },
  }, lazy_config)

  require "nvchad.autocmds"
  --
end

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_set_keymap("n", "<Leader>gf", ":LazyGit<CR>", { silent = true })

dofile(vim.g.base46_cache .. "syntax")

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(false, { 0 })
end

vim.lsp.set_log_level "WARN"
-- require("telescope").load_extension("aerial")
require("telescope").load_extension "projects"

if vim.g.neovide then
  -- ★ Đưa các thư mục có node/npm lên ĐẦU PATH cho Neovide (GUI)
  local node_bin = "/Users/qc-bright/.nvm/versions/node/v22.20.0/bin"
  local hb_arm = "/opt/homebrew/bin:/opt/homebrew/sbin" -- nếu có Homebrew arm64
  vim.env.PATH = table.concat({ node_bin, hb_arm, vim.env.PATH }, ":")

  vim.g.neovide_input_use_logo = 1
  vim.g.neovide_scale_factor = 1.1
  vim.o.guifont = "Google_Sans_Code:r:h15"

  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")

  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end

vim.opt.title = true
vim.opt.titlestring = vim.fs.basename(vim.fn.getcwd())
vim.filetype.add {
  extension = {
    ["http"] = "http",
    ["proto"] = "proto",
  },
}
