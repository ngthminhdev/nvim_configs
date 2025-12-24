-- credits to original theme for existing https://github.com/BeardedBear/bearded-theme ( Solarized version )
-- BeardedTheme Solarized-dark → NvChad Base46
local M = {}

-- =========================
-- Palette cho UI (Base46)
-- =========================
M.base_30 = {
  white = "#c3e0e9",
  darker_black = "#0f2228",
  black = "#132c34", -- nvim bg
  black2 = "#17353f",
  one_bg = "#15313b",
  one_bg2 = "#17353f",
  one_bg3 = "#1a3c47",
  grey = "#367b90",
  grey_fg = "#42889e",
  light_grey = "#435d65",
  line = "#0b191e", -- viền/split

  blue = "#4db0f7",
  nord_blue = "#45b1ff",
  teal = "#26bbae",
  cyan = "#47cfc4",

  green = "#a5b82e",
  red = "#FF738A",
  orange = "#e8913b",
  yellow = "#e2ae10",
  sun = "#f2b600",

  purple = "#858bf7",
  dark_purple = "#6a6fe0",
  pink = "#f154a0",
  baby_pink = "#f481ea",

  -- statusline / popup / folder
  statusline_bg = "#112830",
  lightbg = "#1a3c47",
  pmenu_bg = "#214c59",
  folder_bg = "#4db0f7",

  git_add = "#a5b82e",
  git_change = "#4db0f7",
  git_delete = "#f45645",
}

-- =========================
-- Base16 (syntax)
-- =========================
M.base_16 = {
  base00 = "#132c34",
  base01 = "#17353f",
  base02 = "#183a41",
  base03 = "#367b90",
  base04 = "#77b4c9",
  base05 = "#c3e0e9",
  base06 = "#dff1f5",
  base07 = "#ffffff",
  base08 = "#FF738A",
  base09 = "#e8913b",
  base0A = "#e2ae10",
  base0B = "#a5b82e",
  base0C = "#26bbae",
  base0D = "#4db0f7",
  base0E = "#858bf7",
  base0F = "#f154a0",
}

M.type = "dark"

M.ui = {
  theme = "bearded_solarized",
  theme_toggle = { "bearded_solarized" },
}

return M
