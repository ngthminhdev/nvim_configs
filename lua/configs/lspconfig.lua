-- lspconfig.lua
local M = {
  -- lsp = {
  --   signature = true
  -- }
}

function M.defaults()
  local nvim_lsp = require "lspconfig"
  local cmp = require "cmp"

  -- Cấu hình nvim-cmp.
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<tab>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    },
  }

  -- Khả năng LSP cho nvim-cmp.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Hàm on_attach để cài đặt key mappings sau khi LSP được đính kèm vào buffer.
  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-i>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end

  -- Cấu hình các LSP servers
  local servers = {
    "dartls",
    "lua_ls",
    "ts_ls",
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "html",
    "pylsp",
    "gopls",
    "kulala_ls",
  }

  for _, lsp in ipairs(servers) do
    local config = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 50,
      },
    }

    -- Cấu hình riêng cho dartls
    if lsp == "dartls" then
      local dart_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Disable semantic tokens
      dart_capabilities.textDocument.semanticTokens = {
        dynamicRegistration = false,
        formats = {},
        requests = {
          full = false,
          range = false,
        },
        tokenModifiers = {},
        tokenTypes = {},
      }

      config.capabilities = dart_capabilities

      -- Thêm các cài đặt đặc biệt cho Dart
      config.settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
          analysisExcludedFolders = {
            ".dart_tool",
            ".github",
            "build",
            "android",
            "ios",
          },
        },
      }
    end

    -- Giữ nguyên cấu hình cho TypeScript
    if lsp == "ts_ls" then
      config.settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      }
    end

    if lsp == "gopls" then
      config = {
        lsp_cfg = true,
        lsp_inlay_hints = {
          enable = true,
        },
        lsp_keymaps = true,
        lsp_codelens = true,
        dap_debug = true,
        auto_format = false,
        auto_lint = false,
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 50,
        },
      }
    end

    nvim_lsp[lsp].setup(config)
  end
end

return M
