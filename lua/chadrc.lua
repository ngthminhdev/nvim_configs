-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded_solarized",
  toggle_theme = { "bearded_solarized", "one_light" },
  lsp_semantic_tokens = false,
  transparency = false,
  -- opacity = 0.9,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

if vim.g.neovide then
  M.base46.transparency = false
end

return M
