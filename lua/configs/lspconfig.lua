-- lspconfig.lua (Neovim 0.11+ style)
local M = {}

function M.defaults()
  -- nvim-cmp
  local cmp = require "cmp"
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<A-u>"] = cmp.mapping.scroll_docs(-4),
      ["<A-d>"] = cmp.mapping.scroll_docs(4),
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

  -- Capabilities cho LSP (kết hợp với cmp)
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -------------------------------------------------------------------------
  -- Thay vì truyền on_attach cho từng server, dùng LspAttach cho keymaps
  -------------------------------------------------------------------------
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local opts = { silent = true, buffer = bufnr }

      -- Keymaps khuyến nghị (API mới)
      -- vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

      -- Diagnostics API mới
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Format API mới
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format({ async = true })
      end, {})
    end,
  })

  -------------------------------------------------------------------------
  -- Danh sách servers
  -------------------------------------------------------------------------
  local servers = {
    "lua_ls",
    "ts_ls",
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "html",
    "pylsp",
    "gopls",
    "buf_ls",
  }

  -------------------------------------------------------------------------
  -- Cấu hình từng server với vim.lsp.config (Neovim 0.11+)
  -- Lưu ý: nvim-lspconfig vẫn cung cấp default cmd/root_dir/settings.
  -- vim.lsp.config("<server>", opts) sẽ hợp nhất với default của lspconfig.
  -------------------------------------------------------------------------
  for _, lsp in ipairs(servers) do
    local cfg = {
      capabilities = capabilities,
      flags = { debounce_text_changes = 50 },
    }

    -- Dart (dartls) - nếu bạn thêm "dartls" vào servers, block này sẽ chạy
    if lsp == "dartls" then
      local dart_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Disable semantic tokens
      dart_capabilities.textDocument.semanticTokens = {
        dynamicRegistration = false,
        formats = {},
        requests = { full = false, range = false },
        tokenModifiers = {},
        tokenTypes = {},
      }
      cfg.capabilities = dart_capabilities
      cfg.settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
          analysisExcludedFolders = {
            ".dart_tool", ".github", "build", "android", "ios",
          },
        },
      }
    end

    -- TypeScript / JavaScript (ts_ls)
    if lsp == "ts_ls" then
      cfg.settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
    end

    -- Go (gopls)
    if lsp == "gopls" then
      -- Các field như lsp_cfg/lsp_inlay_hints/... là của plugin go.nvim, LSP core sẽ bỏ qua; vẫn để nếu bạn dùng chung.
      cfg = vim.tbl_deep_extend("force", cfg, {
        lsp_cfg = true,
        lsp_inlay_hints = { enable = true },
        lsp_keymaps = true,
        lsp_codelens = true,
        dap_debug = true,
        auto_format = false,
        auto_lint = false,
        settings = {
          gopls = {
            analyses = { unusedparams = true, unreachable = true },
            staticcheck = true,
          },
        },
      })
    end

    -- Buf (protobuf) qua buf lsp
    if lsp == "buf_ls" then
      cfg = vim.tbl_deep_extend("force", cfg, {
        cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
        filetypes = { "proto" },
      })
    end

    -- Clangd
    if lsp == "clangd" then
      cfg = vim.tbl_deep_extend("force", cfg, {
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })
    end

    -- Đăng ký cấu hình server với core LSP
    vim.lsp.config(lsp, cfg)
  end

  -------------------------------------------------------------------------
  -- Bật tất cả servers
  -------------------------------------------------------------------------
  for _, lsp in ipairs(servers) do
    pcall(vim.lsp.enable, lsp)  -- dùng pcall để không vỡ nếu thiếu binary
  end
end

return M
