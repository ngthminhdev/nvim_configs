local wezterm = require("wezterm")
local config = {}

-- =========================
-- Giao diện cửa sổ
-- =========================
config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.max_fps = 120
config.animation_fps = 120
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- =========================
-- Font configuration
-- =========================
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Medium" },
    { family = "FiraCode Nerd Font",      weight = "Medium" },
    { family = "3270 Nerd Font",          weight = "Medium" },
})
config.font_size = 15.5

-- =========================
-- Environment variables
-- =========================
config.set_environment_variables = {
    TERM = "wezterm",
    WINIT_X11_SCALE_FACTOR = "1.2",
}

-- =========================
-- Custom Color Scheme: Bearded Solarized
-- =========================
config.colors = {
    -- Màu nền và tiền cảnh chính
    foreground = '#c3e0e9', -- base_30.white
    background = '#132c34', -- base_30.black (nvim bg)

    -- Cursor colors
    cursor_bg = '#4db0f7',     -- base_30.blue
    cursor_fg = '#132c34',     -- base_30.black
    cursor_border = '#4db0f7', -- base_30.blue

    -- Selection colors
    selection_fg = '#132c34', -- base_30.black
    selection_bg = '#c3e0e9', -- base_30.white

    -- Scrollbar và split
    scrollbar_thumb = '#17353f', -- base_30.black2
    split = '#0b191e',           -- base_30.line

    -- ANSI colors (0-7)
    ansi = {
        '#132c34', -- black (base00)
        '#FF738A', -- red (base08)
        '#a5b82e', -- green (base0B)
        '#e2ae10', -- yellow (base0A)
        '#4db0f7', -- blue (base0D)
        '#858bf7', -- purple/magenta (base0E)
        '#26bbae', -- cyan (base0C)
        '#c3e0e9', -- white (base05)
    },

    -- Bright ANSI colors (8-15)
    brights = {
        '#367b90', -- bright black (base03 - comment)
        '#f45645', -- bright red (git_delete)
        '#a5b82e', -- bright green (same as green)
        '#f2b600', -- bright yellow (sun)
        '#45b1ff', -- bright blue (nord_blue)
        '#f154a0', -- bright purple (pink)
        '#47cfc4', -- bright cyan (cyan)
        '#ffffff', -- bright white (base07)
    },

    -- Indexed colors cho các màu đặc biệt
    indexed = {
        [136] = '#e8913b', -- orange
        [208] = '#f481ea', -- baby_pink
    },

    -- Compose cursor
    compose_cursor = '#e8913b', -- base_30.orange

    -- Copy mode colors
    copy_mode_active_highlight_bg = { Color = '#214c59' },   -- pmenu_bg
    copy_mode_active_highlight_fg = { Color = '#c3e0e9' },   -- white
    copy_mode_inactive_highlight_bg = { Color = '#1a3c47' }, -- lightbg
    copy_mode_inactive_highlight_fg = { Color = '#77b4c9' }, -- base04

    -- Quick select colors
    quick_select_label_bg = { Color = '#4db0f7' }, -- blue
    quick_select_label_fg = { Color = '#132c34' }, -- black
    quick_select_match_bg = { Color = '#858bf7' }, -- purple
    quick_select_match_fg = { Color = '#c3e0e9' }, -- white

    -- Tab bar colors
    tab_bar = {
        background = '#0f2228',   -- darker_black
        active_tab = {
            bg_color = '#4db0f7', -- blue
            fg_color = '#132c34', -- black
        },
        inactive_tab = {
            bg_color = '#17353f', -- black2
            fg_color = '#77b4c9', -- base04
        },
        inactive_tab_hover = {
            bg_color = '#1a3c47', -- lightbg
            fg_color = '#c3e0e9', -- white
        },
        new_tab = {
            bg_color = '#112830', -- statusline_bg
            fg_color = '#77b4c9', -- base04
        },
        new_tab_hover = {
            bg_color = '#26bbae', -- teal
            fg_color = '#132c34', -- black
        },
    },
}

-- =========================
-- Additional terminal settings
-- =========================
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_max_width = 64
config.hide_tab_bar_if_only_one_tab = false

-- =========================
-- Window padding
-- =========================
config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
}

-- =========================
-- Keybindings (optional - có thể bỏ nếu không cần)
-- =========================
config.keys = {
    -- Split panes
    {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'D',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Navigate between panes (Vim-style)
    {
        key = 'h',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },

    -- Navigate between panes (Arrow keys)
    {
        key = 'LeftArrow',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },

    -- Resize panes
    {
        key = 'LeftArrow',
        mods = 'CMD|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'RightArrow',
        mods = 'CMD|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'UpArrow',
        mods = 'CMD|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
        key = 'DownArrow',
        mods = 'CMD|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },

    -- Close pane
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },

    -- Toggle pane zoom (maximize/restore current pane)
    {
        key = 'z',
        mods = 'CMD',
        action = wezterm.action.TogglePaneZoomState,
    },

    -- Cycle through panes
    {
        key = 'Tab',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Next',
    },
    {
        key = 'Tab',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Prev',
    },
}


return config
