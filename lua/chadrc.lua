-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  toggle_theme = { "bearded-arc", "one_light" },
  lsp_semantic_tokens = true,
  transparency = true,
  opacity = 0.9,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    NormalFloat = { bg = "#1f2430" },
    FloatBorder = { fg = "#89b4fa", bg = "#1f2430" },
  },
}


return M
