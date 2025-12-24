-- credits to original theme for existing https://github.com/BeardedBear/bearded-theme ( bearded_anthracite version )
local M = {}

-- =========================
-- Palette cho UI (Base46)
-- =========================
M.base_30 = {
  -- nền & line/border
  white = "#c8ccd4",
  darker_black = "#0f1013",
  black = "#181a1f", -- nvim bg (editor.background)
  black2 = "#1e2026",
  one_bg = "#131519", -- activityBar.background
  one_bg2 = "#23262d",
  one_bg3 = "#2e323c",
  grey = "#515766",
  grey_fg = "#606570",
  light_grey = "#8b8d91",
  line = "#0b0c0e", -- border chính

  -- màu nhấn chính (màu đỏ đã làm dịu)
  blue = "#3398DB",
  nord_blue = "#3398DB",
  teal = "#24B5A8",
  cyan = "#24B5A8",
  green = "#37ae6f",
  red = "#D26D52", -- đổi từ #C13838 → dịu hơn (cam đỏ)
  orange = "#D26D32",
  yellow = "#c9a022",
  sun = "#c9a022",
  purple = "#935cd1",
  dark_purple = "#7a4db8",
  pink = "#CC71BC",
  baby_pink = "#de456b",

  -- statusline / popup / folder
  statusline_bg = "#131519",
  lightbg = "#23262d",
  pmenu_bg = "#1c1f25", -- editorSuggestWidget
  folder_bg = "#3398DB",

  -- extra tiện dụng (git colors cũng dịu đỏ)
  git_add = "#37ae6f",
  git_change = "#3398DB",
  git_delete = "#D26D52", -- dịu hơn
}

-- =========================
-- Base16 (syntax)
-- =========================
M.base_16 = {
  base00 = "#181a1f", -- background (editor.background)
  base01 = "#23262d", -- bg sáng hơn
  base02 = "#2e323c", -- selection
  base03 = "#515766", -- comment
  base04 = "#acb1bd", -- subtle fg
  base05 = "#c8ccd4", -- default fg (editor.foreground)
  base06 = "#e1e4e7", -- fg sáng
  base07 = "#f4f4f4", -- trắng nhất
  base08 = "#D26D52", -- red dịu hơn (errors) - thay #C13838
  base09 = "#D26D32", -- orange (property)
  base0A = "#c9a022", -- yellow (keywords)
  base0B = "#37ae6f", -- green (strings)
  base0C = "#24B5A8", -- cyan (storage/types)
  base0D = "#3398DB", -- blue (functions)
  base0E = "#935cd1", -- purple (classes/types)
  base0F = "#CC71BC", -- pink (decorators/parameters)
}

M.type = "dark"

M.polish_hl = {
  ["@variable"] = { fg = M.base_30.baby_pink }, -- de456b (pink)
  ["@variable.builtin"] = { fg = M.base_30.teal }, -- 24B5A8
  ["@property"] = { fg = M.base_16.base09 }, -- D26D32 (orange)
  ["@parameter"] = { fg = M.base_16.base0F }, -- CC71BC (pink)
  ["@function"] = { fg = M.base_16.base0D }, -- 3398DB (blue)
  ["@keyword"] = { fg = M.base_16.base0A }, -- c9a022 (yellow)
  ["@keyword.control"] = { fg = M.base_16.base0A },
  ["@keyword.import"] = { fg = M.base_16.base0A },
  ["@type"] = { fg = M.base_16.base0E }, -- 935cd1 (purple)
  ["@type.builtin"] = { fg = M.base_30.teal }, -- 24B5A8
  ["@namespace"] = { fg = M.base_16.base0D }, -- 3398DB
  ["@decorator"] = { fg = M.base_16.base0F }, -- CC71BC
  ["@string"] = { fg = M.base_16.base0B }, -- 37ae6f (green)
  ["@comment"] = { fg = M.base_16.base03, italic = true }, -- 515766

  -- UI enhancements
  CursorLine = { bg = "#a2abb60f" },
  Visual = { bg = "#a2abb64d" },
  Search = { bg = "#a2abb630", fg = M.base_16.base05 },
  IncSearch = { bg = "#a2abb661", fg = M.base_16.base05 },

  -- Error/Warning colors 
  DiagnosticError = { fg = "#D26D52" }, 
  DiagnosticWarn = { fg = M.base_16.base0A },
  DiffDelete = { bg = "#d2695226", fg = "#D26D52" },
  DiffAdd = { bg = "#37ae6f26" },

  -- Git signs
  GitSignsDelete = { fg = "#D26D52" },
  GitSignsChange = { fg = M.base_16.base0D },
  GitSignsAdd = { fg = M.base_16.base0B },
}

M.ui = {
  theme = "bearded_anthracite",
  theme_toggle = { "bearded_anthracite" },
}

return M
