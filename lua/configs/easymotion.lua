local M = {}

function M.setup()
  vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
  vim.api.nvim_set_keymap('n', '<C-p>', '<Plug>(easymotion-s)', {})
end

return M
