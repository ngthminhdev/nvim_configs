dofile(vim.g.base46_cache .. "mason")
local options = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    "bashls",
    "clangd",
    "ast_grep",
    "docker_compose_language_service",
    "dotls",
    "html",
    "cssls",
    "sqls",
    "yamlls",
    "bashls",
    "typescript-language-server",
  }, -- not an option from mason.nvim

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
