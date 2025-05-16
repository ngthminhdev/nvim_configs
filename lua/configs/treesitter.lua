dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "treesitter")

local options = {
  ensure_installed = {
    "lua",
    "luadoc",
    "printf",
    "vim",
    "vimdoc",
    "javascript",
    "typescript",
    "dockerfile",
    "c",
    "cpp",
    "bash",
    "dap_repl",
    "html",
    "json",
    "css",
    "scss",
    "nginx",
    "json",
    "dart",
    "python",
    "java",
    "http",
    "go"
  },
  sync_install = true,
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
  },

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- use_languagetree = true,
  },
}

return options
