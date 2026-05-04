# Netherize Editor — Default Keymap Profile (Extracted from current Neovim config)
# ==============================================================================
# Đây là bản tóm tắt toàn bộ keymap hiện tại theo phong cách "profile" để bạn
# đưa sang AI khác generate lại bộ keymap IDE cùng style.
#
# Nguồn tổng hợp:
# - init.lua
# - lua/mappings.lua
# - lua/configs/lspconfig.lua
# - lua/configs/gitsigns.lua
# - lua/configs/flutter_tools.lua
# - lua/configs/dap.lua
# - lua/configs/easymotion.lua
# - lua/plugins/init.lua (hop.nvim)
#
# Lưu ý:
# - Một số phím bị map đè nhiều lần (xem mục "Conflicts/Overrides").
# - Một số binding là buffer-local (LSP/Flutter/Gitsigns attach theo buffer).

[profile]
name = "default"
description = "Current custom NvChad/Neovim-inspired keybindings with heavy <leader> workflows, debugging, Telescope, Flutter, and AI actions."

# ── Leader key ────────────────────────────────────────────────────────────────
[meta]
leader = "space"

# ── Global / App-like shortcuts ───────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<Esc>"
command = "search.clear_highlight"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<Bar>"
command = "window.vsplit"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>h"
command = "window.focus_left"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>l"
command = "window.focus_right"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>j"
command = "window.focus_down"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>k"
command = "window.focus_up"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>tn"
command = "tab.next"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>rn"
command = "editor.toggle_relative_number"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ch"
command = "app.open_nvcheatsheet"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fm"
command = "editor.format_file"
source = "lua/mappings.lua"

# ── Buffer / tabline ──────────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<leader>b"
command = "buffer.new"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-l>"
command = "buffer.next"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-h>"
command = "buffer.prev"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>x"
command = "buffer.close_current"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<D-1..9>"
command = "buffer.goto_index_in_tab"
source = "init.lua"

# ── File tree / explorer ──────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<C-f>"
command = "explorer.toggle"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-f>"
command = "explorer.focus"
source = "lua/mappings.lua"

# ── Telescope / search ────────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<leader>fw"
command = "search.live_grep"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fb"
command = "search.buffers"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fh"
command = "search.help_tags"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ma"
command = "search.marks"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fo"
command = "search.old_files"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fc"
command = "search.current_buffer_fuzzy"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>cm"
command = "git.search_commits"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>gt"
command = "git.search_status"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>pt"
command = "terminal.search_terms"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ds"
command = "diagnostics.open_picker"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>gr"
command = "lsp.search_definitions"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fp"
command = "lsp.document_symbols"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ff"
command = "files.find"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>fa"
command = "files.find_all_hidden_no_ignore"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>pj"
command = "projects.recent"
source = "lua/mappings.lua"

# ── Theme / UI / Zen ─────────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<leader>th"
command = "theme.open_picker"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>zm"
command = "ui.toggle_zen_mode"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>cc"
command = "indent_scope.jump_current_context"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>nl"
command = "notifications.open_last"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>nh"
command = "notifications.open_history"
source = "lua/mappings.lua"

# ── AI / CodeCompanion ────────────────────────────────────────────────────────
[[bindings]]
mode = "n,v"
key = "<leader>aa"
command = "ai.actions"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ac"
command = "ai.chat_toggle"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>an"
command = "ai.chat_new"
source = "lua/mappings.lua"

[[bindings]]
mode = "v"
key = "<leader>av"
command = "ai.chat_add_selection"
source = "lua/mappings.lua"

[[bindings]]
mode = "n,v"
key = "<leader>ai"
command = "ai.inline"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>am"
command = "ai.command"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ar"
command = "ai.refresh_cache"
source = "lua/mappings.lua"

# ── Terminal / runner ─────────────────────────────────────────────────────────
[[bindings]]
mode = "t"
key = "<C-q>"
command = "terminal.exit_to_normal_mode"
source = "lua/mappings.lua"

[[bindings]]
mode = "n,t"
key = "<F10>"
command = "runner.smart_compile_and_run"
source = "lua/mappings.lua"

[[bindings]]
mode = "n,t"
key = "<F12>"
command = "terminal.toggle_floating"
source = "lua/mappings.lua"

# ── Debug (DAP / DAP UI) ──────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<F5>"
command = "debug.continue"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<F6>"
command = "debug.restart"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<F4>"
command = "debug.terminate"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-b>"
command = "debug.toggle_breakpoint"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ui"
command = "debug.ui_toggle"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<space>i"
command = "debug.eval_under_cursor"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>df"
command = "debug.ui_float_element"
source = "lua/configs/dap.lua"

[[bindings]]
mode = "n"
key = "<leader>dc"
command = "debug.ui_console_float"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>dt"
command = "debug.ui_stacks_float"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>dr"
command = "debug.ui_repl_float_focus"
source = "lua/mappings.lua"

# ── LSP navigation/actions ────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "K"
command = "lsp.hover"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "gi"
command = "lsp.implementation"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "<C-i>"
command = "lsp.signature_help"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "<space>D"
command = "lsp.type_definition"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "<space>rn"
command = "lsp.rename"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "gr"
command = "lsp.references"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "[d"
command = "diagnostics.prev"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "]d"
command = "diagnostics.next"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "<space>q"
command = "diagnostics.to_loclist"
source = "lua/configs/lspconfig.lua"

[[bindings]]
mode = "n"
key = "gd"
command = "lsp.definition"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<leader>ca"
command = "lsp.code_action"
source = "lua/mappings.lua"

[[bindings]]
mode = "x"
key = "<leader>ca"
command = "lsp.range_code_action"
source = "lua/mappings.lua"

# ── Git ───────────────────────────────────────────────────────────────────────
[[bindings]]
mode = "n"
key = "<Leader>gf"
command = "git.open_lazygit"
source = "init.lua"

[[bindings]]
mode = "n"
key = "<leader>rh"
command = "git.reset_hunk"
source = "lua/configs/gitsigns.lua"

[[bindings]]
mode = "n"
key = "<leader>ph"
command = "git.preview_hunk"
source = "lua/configs/gitsigns.lua"

[[bindings]]
mode = "n"
key = "<leader>gl"
command = "git.blame_line"
source = "lua/configs/gitsigns.lua"

[[bindings]]
mode = "n"
key = "<leader>gb"
command = "git.blame"
source = "lua/mappings.lua"

# ── Flutter (buffer-local when attached) ─────────────────────────────────────
[[bindings]]
mode = "n"
key = "<leader>fr"
command = "flutter.run"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fq"
command = "flutter.quit"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fR"
command = "flutter.restart"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fd"
command = "flutter.devices"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fe"
command = "flutter.emulators"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fo"
command = "flutter.outline_toggle"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<leader>fl"
command = "flutter.log_clear"
source = "lua/configs/flutter_tools.lua"

[[bindings]]
mode = "n"
key = "<space>fe"
command = "flutter.emulators"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<space>fl"
command = "flutter.log_clear"
source = "lua/mappings.lua"

# ── Navigation plugins (Hop / Aerial / Glance / EasyMotion) ─────────────────
[[bindings]]
mode = "n"
key = "<leader>s"
command = "hop.char1"
source = "lua/plugins/init.lua"

[[bindings]]
mode = "n"
key = "<leader>2s"
command = "hop.char2"
source = "lua/plugins/init.lua"

[[bindings]]
mode = "n"
key = "<leader>ws"
command = "hop.word"
source = "lua/plugins/init.lua"

[[bindings]]
mode = "n"
key = "<C-p>"
command = "aerial.toggle"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-p>"
command = "easymotion.s"
source = "lua/configs/easymotion.lua"

[[bindings]]
mode = "n"
key = "gD"
command = "glance.definitions"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "gr"
command = "glance.references"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "gR"
command = "glance.references"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "gY"
command = "glance.type_definitions"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "gM"
command = "glance.implementations"
source = "lua/mappings.lua"

# ── Editing helpers ───────────────────────────────────────────────────────────
[[bindings]]
mode = "i"
key = "clg"
command = "snippet.insert_console_log"
source = "lua/mappings.lua"

[[bindings]]
mode = "i"
key = "jlg"
command = "snippet.insert_json_stringify_log"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-j>"
command = "line.move_down"
source = "lua/mappings.lua"

[[bindings]]
mode = "n"
key = "<C-k>"
command = "line.move_up"
source = "lua/mappings.lua"

[[bindings]]
mode = "i"
key = "<C-j>"
command = "line.move_down"
source = "lua/mappings.lua"

[[bindings]]
mode = "i"
key = "<C-k>"
command = "line.move_up"
source = "lua/mappings.lua"

[[bindings]]
mode = "v"
key = "<C-j>"
command = "selection.move_down"
source = "lua/mappings.lua"

[[bindings]]
mode = "v"
key = "<C-k>"
command = "selection.move_up"
source = "lua/mappings.lua"

[[bindings]]
mode = "i"
key = "<C-j>"
command = "copilot.accept"
source = "lua/mappings.lua"

# ── GUI / macOS / Neovide ─────────────────────────────────────────────────────
[[bindings]]
mode = "n,v"
key = "<C-+>"
command = "ui.scale_up"
source = "init.lua"

[[bindings]]
mode = "n,v"
key = "<C-->"
command = "ui.scale_down"
source = "init.lua"

[[bindings]]
mode = "n,v"
key = "<C-0>"
command = "ui.scale_reset"
source = "init.lua"

[[bindings]]
mode = ""
key = "<D-v>"
command = "clipboard.paste"
source = "init.lua"

[[bindings]]
mode = "!"
key = "<D-v>"
command = "clipboard.paste_insert_like"
source = "init.lua"

[[bindings]]
mode = "t"
key = "<D-v>"
command = "clipboard.paste_terminal"
source = "init.lua"

[[bindings]]
mode = "v"
key = "<D-v>"
command = "clipboard.paste_visual"
source = "init.lua"

# ── Conflicts / Overrides (quan trọng cho AI generate) ───────────────────────
# 1) <C-f> trong normal mode:
#    - NvimTreeToggle
#    - NvimTreeFocus
#    -> mapping sau sẽ override mapping trước.
#
# 2) <C-p> trong normal mode:
#    - AerialToggle
#    - EasyMotion <Plug>(easymotion-s)
#    -> mapping load sau sẽ thắng.
#
# 3) <leader>gl:
#    - Gitsigns blame_line (configs/gitsigns.lua)
#    - Gitsigns blame_line (mappings.lua)
#    -> cùng intent, không xung đột chức năng.
#
# 4) gr:
#    - lsp.references (lspconfig attach)
#    - Glance references (mappings.lua)
#    -> mapping Glance có thể override behavior references mặc định.
#
# 5) <C-j> ở insert mode:
#    - move line down
#    - copilot accept
#    -> xung đột trực tiếp, mapping cuối sẽ thắng.
