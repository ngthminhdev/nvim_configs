local map = vim.keymap.set

-- map("i", "<C-h>", "<C-o>h", { desc = "move left" })
-- map("i", "<C-l>", "<C-o>l", { desc = "move right" })
-- map("i", "<C-j>", "<C-o>j", { desc = "move down" })
-- map("i", "<C-k>", "<C-o>k", { desc = "move up" })
--
map("i", "clg", [[console.log()<Left>]], { noremap = true, silent = true })
map(
  "i",
  "jlg",
  [[console.log(`${JSON.stringify(, null, 1) }`)<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { noremap = true, silent = true }
)

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<Bar>", "<cmd>vsplit<CR>", { desc = "switch window up" })

map("n", "<leader>h", "<C-w>h", { desc = "switch window left" })
map("n", "<leader>l", "<C-w>l", { desc = "switch window right" })
map("n", "<leader>j", "<C-w>j", { desc = "switch window down" })
map("n", "<leader>k", "<C-w>k", { desc = "switch window up" })

map("n", "<A-Tab>", ":tabnext<CR>", { desc = "Tab next" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "format files" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<C-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<C-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- nvimtree
map("n", "<C-f>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-f>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ds", "<cmd>Telescope diagnostics<CR>", { desc = "diagnostics_document" })
map("n", "<leader>gr", "<cmd>Telescope lsp_definitions<CR>", { desc = "lsp_definitions" })
map("n", "<leader>fp", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>pj", "<cmd>Telescope projects<cr>", { desc = "recent projects" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

map("n", "<leader>zm", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode" })

-- terminal
map("t", "<C-q>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

map({ "n", "t" }, "<F10>", function()
  require("nvchad.term").runner {
    id = "codeRunner", -- Đặt tên chung để dùng cho nhiều ngôn ngữ
    pos = "float",
    float_opts = {
      width = 0.5,
      height = 0.9,
      row = 0.05,
      col = 1,
    },
    clear_cmd = false, -- Giữ lại lịch sử terminal

    cmd = function()
      local file = vim.fn.expand "%" -- Tên file hiện tại
      local ft = vim.bo.ft -- Loại file (cpp, c, go, python...)

      -- Bảng chứa lệnh chạy cho từng ngôn ngữ
      local ft_cmds = {
        cpp = "g++ -o out " .. file .. " && ./out", -- Lệnh cho C++
        c = "gcc -o out " .. file .. " && ./out", -- Lệnh cho C
        go = "go run " .. file, -- Lệnh cho Go
        rust = "cargo run " .. file, -- Lệnh cho Rust
        rs = "cargo run " .. file, -- Lệnh cho Rust
        python = "python3 " .. file, -- Thêm luôn Python cho tiện
      }

      -- Trả về lệnh tương ứng, hoặc báo lỗi nếu không tìm thấy
      return ft_cmds[ft] or "echo 'Chưa cấu hình chạy cho ngôn ngữ này!'"
    end,
  }
  vim.schedule(function()
    vim.cmd "stopinsert"
  end)
end, { desc = "Compile and Run Code (Smart)" })

map({ "n", "t" }, "<F12>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "hToggleTerm",
    float_opts = {
      width = 0.7,
      height = 0.95,
      row = 0.05,
      col = 1,
    },
  }
end, { desc = "terminal toggle floating term" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- Thiết lập phím tắt cho nvim-dap
-- local dap = require "dap"
-- local dapui = require "dapui"

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--     dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end

-- Phím tắt F5 để bắt đầu debug
map("n", "<F5>", '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })

-- Phím tắt F6 để khởi động lại debug
map("n", "<F6>", '<cmd>lua require"dap".restart()<CR>', { noremap = true, silent = true })

-- Phím tắt F4 để dừng debug
map("n", "<F4>", '<cmd>lua require"dap".terminate()<CR>', { noremap = true, silent = true })

-- Phím tắt Ctrl+B để bật/tắt breakpoint
map("n", "<C-b>", '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })

-- Phím tắt <leader>ui để bật/tắt giao diện DAP UI
map("n", "<leader>ui", '<cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

map("n", "<space>i", '<Cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })

local function watchExpression(expression)
  require("dapui").elements.watches.add(expression)
end

vim.api.nvim_create_user_command("DapiUIAddToWatch", function(opts)
  watchExpression(opts.args)
end, { nargs = 1 })

map("n", "<space>w", ":DapiUIAddToWatch ", { noremap = true })

local function removeExpression(expression)
  require("dapui").elements.watches.remove(expression)
end

vim.api.nvim_create_user_command("DapiUIRemoveWatch", function(opts)
  removeExpression(opts.args)
end, { nargs = 1 })

map("n", "<space>r", ":DapiUIRemoveWatch ", { noremap = true })

-- map("n", "<space>fr", ":FlutterRun<CR>", { noremap = true, silent = true })
-- map("n", "<space>fd", ":FlutterDevices<CR>", { noremap = true, silent = true })
-- map("n", "<space>fe", ":FlutterEmulators<CR>", { noremap = true, silent = true })
-- map("n", "<space>fl", ":FlutterLogClear<CR>", { noremap = true, silent = true })
-- Mở tab mới

local opts = { noremap = true, silent = true }

-- Show hover
map("n", "C-i", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- Jump to definition
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- Open code actions
map("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- Open code actions for the selected visual range
map("x", "<leader>ca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

map("n", "<leader>nl", function()
  require("noice").cmd "last"
end)

map("n", "<leader>nh", function()
  require("noice").cmd "history"
end)

map("n", "<leader>gb", "<Cmd>Gitsigns blame<CR>", opts)
map("n", "<leader>gl", "<Cmd>Gitsigns blame_line<CR>", opts)

map("n", "<C-p>", "<cmd>AerialToggle<cr>", { desc = "Aerial Toggle" })

-- map("n", "<leader>rs", '<cmd>lua require("kulala").run()<CR>', { noremap = true, silent = true, desc = "Run request" })
-- map("n", "<leader>rr", '<cmd>lua require("kulala").replay()<CR>',
--     { noremap = true, silent = true, desc = "Replay request" })
-- map("n", "<leader>rh", '<cmd>lua require("kulala.ui").show_headers()<CR>',
--     { noremap = true, silent = true, desc = "Show headers" })
-- map("n", "<leader>rb", '<cmd>lua require("kulala.ui").show_body()<CR>',
--     { noremap = true, silent = true, desc = "Show body" })
-- map("n", "<leader>ra", '<cmd>lua require("kulala.ui").show_headers_body()<CR>',
--     { noremap = true, silent = true, desc = "Show headers & body" })
-- map("n", "<leader>rv", '<cmd>lua require("kulala.ui").show_verbose()<CR>',
--     { noremap = true, silent = true, desc = "Show verbose" })
-- map("n", "S", '<cmd>lua require("kulala.ui").show_stats()<CR>', { noremap = true, silent = true, desc = "Show stats" })
-- map("n", "R", '<cmd>lua require("kulala.ui").show_report()<CR>', { noremap = true, silent = true, desc = "Show report" })
--

map("n", "gD", "<CMD>Glance definitions<CR>")
map("n", "gR", "<CMD>Glance references<CR>")
map("n", "gY", "<CMD>Glance type_definitions<CR>")
map("n", "gM", "<CMD>Glance implementations<CR>")

-- Move line up/down with Alt + Arrow
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

map("n", "<leader>dr", function()
  local dapui = require "dapui"
  dapui.float_element("repl", {
    enter = true,
    width = 100,
    height = 20,
  })
end, { desc = "Open & focus DAP console (float)" })

map("n", "<leader>dc", function()
  local dapui = require "dapui"
  dapui.float_element("console", {
    enter = true,
    width = 100,
    height = 20,
  })
end, { desc = "Open & focus DAP console (float)" })

vim.g.copilot_no_tab_map = true
