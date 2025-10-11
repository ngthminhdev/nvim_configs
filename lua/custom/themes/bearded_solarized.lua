-- BeardedTheme Solarized-dark → NvChad Base46
-- nguồn màu: VS Code JSON bạn gửi ở trên
local M = {}

-- =========================
-- Palette cho UI (Base46)
-- =========================
M.base_30 = {
    -- nền & line/border
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

    -- màu nhấn chính
    blue = "#4db0f7",
    nord_blue = "#45b1ff",
    teal = "#26bbae",
    cyan = "#47cfc4",

    green = "#a5b82e",
    red = "#f45645",
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

    -- extra tiện dụng
    git_add = "#a5b82e",
    git_change = "#4db0f7",
    git_delete = "#f45645",
}

-- =========================
-- Base16 (syntax)
-- =========================
M.base_16 = {
    base00 = "#132c34", -- background
    base01 = "#17353f", -- bg sáng hơn
    base02 = "#183a41", -- selection/chuẩn bị
    base03 = "#367b90", -- comment
    base04 = "#77b4c9", -- subtle fg
    base05 = "#c3e0e9", -- default fg
    base06 = "#dff1f5", -- fg sáng
    base07 = "#ffffff", -- trắng nhất

    base08 = "#f45645", -- red (errors, variables)
    base09 = "#e8913b", -- orange
    base0A = "#e2ae10", -- yellow
    base0B = "#a5b82e", -- green
    base0C = "#26bbae", -- cyan/teal
    base0D = "#4db0f7", -- blue
    base0E = "#858bf7", -- purple
    base0F = "#f154a0", -- pink (specials)
}

M.type = "dark"

M.ui = {
    theme = "bearded_solarized",
    theme_toggle = { "bearded_solarized", },
}

return M
