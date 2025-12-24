-- credits to original theme for existing https://github.com/BeardedBear/bearded-theme ( blueberry version )
-- BeardedTheme Arc-blueberry → NvChad Base46
local M = {}

-- =========================
-- Palette cho UI (Base46)
-- =========================
M.base_30 = {
  -- nền & line/border
  white = "#bcc1dc",
  darker_black = "#0a0c14",
  black = "#111422", -- nvim bg (editor.background)
  black2 = "#15192b",
  one_bg = "#0d101b", -- activityBar.background
  one_bg2 = "#1a1e33",
  one_bg3 = "#222844",
  grey = "#3c4776",
  grey_fg = "#495383",
  light_grey = "#737ba6",
  line = "#07080e", -- border 

  blue = "#69C3FF",
  nord_blue = "#69C3FF",
  teal = "#22ECDB",
  cyan = "#22ECDB",
  green = "#3CEC85",
  red = "#FF738A",
  orange = "#FF955C",
  yellow = "#EACD61",
  sun = "#EACD61",
  purple = "#B78AFF",
  dark_purple = "#858bf7",
  pink = "#F38CEC",
  baby_pink = "#FF738A",

  -- statusline / popup / folder
  statusline_bg = "#0d101b",
  lightbg = "#1a1e33",
  pmenu_bg = "#141829", -- editorSuggestWidget
  folder_bg = "#69C3FF",

  git_add = "#3CEC85",
  git_change = "#69C3FF",
  git_delete = "#FF738A",
}

-- =========================
-- Base16 (syntax)
-- =========================
M.base_16 = {
  base00 = "#111422",
  base01 = "#1a1e33",
  base02 = "#222844",
  base03 = "#3c4776",
  base04 = "#9aa2cb",
  base05 = "#bcc1dc",
  base06 = "#eaf0fa",
  base07 = "#f0f1f5",
  base08 = "#FF738A",
  base09 = "#FF955C",
  base0A = "#EACD61",
  base0B = "#3CEC85",
  base0C = "#22ECDB",
  base0D = "#69C3FF",
  base0E = "#B78AFF",
  base0F = "#F38CEC",
}

M.type = "dark"

M.polish_hl = {
  ["@variable"] = { fg = M.base_16.base0F }, -- FF738A (pink)
  ["@variable.builtin"] = { fg = M.base_30.teal }, -- 22ECDB
  ["@property"] = { fg = M.base_16.base09 }, -- FF955C (orange)
  ["@parameter"] = { fg = M.base_16.base0F }, -- F38CEC (pink)
  ["@function"] = { fg = M.base_16.base0D }, -- 69C3FF (blue)
  ["@keyword"] = { fg = M.base_16.base0A }, -- EACD61 (yellow)
  ["@keyword.control"] = { fg = M.base_16.base0A },
  ["@keyword.import"] = { fg = M.base_16.base0A },
  ["@type"] = { fg = M.base_16.base0E }, -- B78AFF (purple)
  ["@type.builtin"] = { fg = M.base_30.teal }, -- 22ECDB
  ["@namespace"] = { fg = M.base_16.base0D }, -- 69C3FF
  ["@decorator"] = { fg = M.base_16.base0F }, -- F38CEC
  ["@string"] = { fg = M.base_16.base0B }, -- 3CEC85 (green)
  ["@comment"] = { fg = M.base_16.base03, italic = true }, -- 3c4776

  -- UI enhancements
  CursorLine = { bg = "#8eb0e60f" },
  Visual = { bg = "#8eb0e64d" },
  Search = { bg = "#8eb0e630", fg = M.base_16.base05 },
  IncSearch = { bg = "#8eb0e661", fg = M.base_16.base05 },
}

M.ui = {
  theme = "bearded_arc_blueberry",
  theme_toggle = { "bearded_arc_blueberry" },
}

return M
