local map = vim.keymap.set

-- map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
-- map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<C-o>h", { desc = "move left" })
map("i", "<C-l>", "<C-o>l", { desc = "move right" })
map("i", "<C-j>", "<C-o>j", { desc = "move down" })
map("i", "<C-k>", "<C-o>k", { desc = "move up" })

map("n", "<Bar>", "<cmd>vsplit<CR>", { desc = "switch window up" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>h", "<C-w>h", { desc = "switch window left" })
map("n", "<leader>l", "<C-w>l", { desc = "switch window right" })
map("n", "<leader>j", "<C-w>j", { desc = "switch window down" })
map("n", "<leader>k", "<C-w>k", { desc = "switch window up" })

-- map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
-- map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc= "toggle line number" })
-- map("n", "<space>tn", ":tabnew<CR>:terminal<CR>", { noremap = true, silent = true })
map("n", "<space>tn", ":tabnext<CR>", { desc = "Tab next" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<A-.>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-,>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<C-c>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
-- map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
-- map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

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
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-p>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
--[[ map("n", "<F10>", function()
  require("nvchad.term").new { pos = "float", size = 0.8 }
end, { desc = "terminal new horizontal term" }) ]]
--
-- map("n", "<F11>", function()
-- require("nvchad.term").new { pos = "vsp" }
-- end, { desc = "terminal new vertical window" })

-- toggleable
-- map({ "n", "t" }, "<F10>", function()
-- require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
-- end, { desc = "terminal toggleable vertical term" })
--

local filename = vim.fn.expand "%:t"
local cmd = string.format("g++ %s && ./a.out", vim.fn.shellescape(filename))

map({ "n", "t" }, "<F10>", function()
  require("nvchad.term").runner {
    id = "pythonRunner",
    pos = "vsp",
    size = 0.3,
    clear_cmd = false,

    cmd = function()
      return "clear && python3 main.py"
    end,

    -- id = "cppRunner",
    -- pos = "vsp",
    -- size = 0.3,
    -- clear_cmd = false,
    --
    -- cmd = function()
    --   local file = vim.fn.expand "%"
    --
    --   local ft_cmds = {
    --     cpp = "clear && g++ -o out " .. file .. " && ./out",
    --   }
    --
    --   return ft_cmds[vim.bo.ft]
    -- end,
  }
end, { desc = "CPP compile and run" })

map({ "n", "t" }, "<F12>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "hToggleTerm",
    float_opts = {
      width = 0.5,
      height = 0.9,
      row = 0.05,
      col = 1,
      -- location = "center",
    },
  }
end, { desc = "terminal toggle floating term" })

-- map({ "n", "t" }, "<F2>", function()
-- require("nvchad.term").toggle { pos = "sp", size = 0.3, id = "hCToggleTerm",  }
-- end, { desc = "C debug" })
-- whichkey
-- map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
--
-- map("n", "<leader>wk", function()
-- vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
-- end, { desc = "whichkey query lookup" })

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
local dap = require "dap"
local dapui = require "dapui"

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
  dapui.elements.watches.add(expression)
end

vim.api.nvim_create_user_command("DapiUIAddToWatch", function(opts)
  watchExpression(opts.args)
end, { nargs = 1 })

map("n", "<space>w", ":DapiUIAddToWatch ", { noremap = true })

local function removeExpression(expression)
  dapui.elements.watches.remove(expression)
end

vim.api.nvim_create_user_command("DapiUIRemoveWatch", function(opts)
  removeExpression(opts.args)
end, { nargs = 1 })

map("n", "<space>r", ":DapiUIRemoveWatch ", { noremap = true })
map("n", "<space>fr", ":FlutterRun<CR>", { noremap = true, silent = true })
map("n", "<space>cl", ":FlutterLogClear<CR>", { noremap = true, silent = true })
-- Mở tab mới
-- map('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
local opts = { noremap = true, silent = true }

-- Show hover
map("n", "C-K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
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
