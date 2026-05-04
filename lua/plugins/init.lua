return {
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  "nvchad/volt",
  "nvchad/minty",
  "nvchad/menu",

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "nvchad.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  "nvim-lua/plenary.nvim",

  -- formatting!
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettier" },
        javascript = { "eslint_d", "prettierd", "prettier" },
        typescript = { "eslint_d", "prettierd", "prettier" },
        python = { "isort", "black" },
        go = { "gofmt", "goimports" },
        yaml = { "prettier" },
        cpp = { "clang-format" },
        json = { "jq" },
        sql = { "sql_formatter" },
      },
      -- formatters = {
      --   prettier = {
      --     prepend_args = function()
      --       return { "--tab-width", "2" }
      --     end,
      --   },
      -- },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "nvchad.configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd "Mason"
          local mr = require "mason-registry"

          mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end)
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },

  {
    "easymotion/vim-easymotion",
    config = function()
      require("easy_motion").setup()
      require("configs.easymotion").defaults()
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "nvchad.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      -- { "LiadOz/nvim-dap-repl-highlights", config = true, branch = "LiadOz/fix-check-parser" },
    },
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      -- require("nvim-dap-repl-highlights").setup()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "terryma/vim-multiple-cursors",
    lazy = false,
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    cmd = {
      "FlutterRun",
      "FlutterQuit",
      "FlutterRestart",
      "FlutterDevices",
      "FlutterEmulators",
      "FlutterOutlineToggle",
      "FlutterLogClear",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("configs.flutter_tools").setup()
    end,
  },

  {
    "mtdl9/vim-log-highlighting",
    -- Thêm NvTerm_float vào danh sách để Lazy load plugin
    ft = { "log", "NvTerm_float" },
    config = function()
      -- 1. Hàm dùng chung: Định nghĩa màu sắc custom cho Android/Flutter
      local function apply_custom_highlights()
        vim.cmd [[
          " Highlight Debug (D/...) - Màu xám/Comment
          syntax match LogcatDebug /D\/[^:]*:/ containedin=ALL
          highlight link LogcatDebug Comment
          
          " Highlight Info (I/...) - Màu xanh lá/String
          syntax match LogcatInfo /I\/[^:]*:/ containedin=ALL
          highlight link LogcatInfo String
          
          " Highlight Warning (W/...) - Màu vàng/Cảnh báo
          syntax match LogcatWarn /W\/[^:]*:/ containedin=ALL
          highlight link LogcatWarn DiagnosticWarn
          
          " Highlight Error (E/...) - Màu đỏ/Lỗi
          syntax match LogcatError /E\/[^:]*:/ containedin=ALL
          highlight link LogcatError DiagnosticError

          " Highlight Thời gian (09:00:14)
          syntax match LogcatTime /\d\d:\d\d:\d\d/ containedin=ALL
          highlight link LogcatTime Number
        ]]
      end

      -- 2. Trường hợp 1: File log chuẩn (đuôi .log hoặc filetype=log)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "log",
        callback = apply_custom_highlights,
      })

      -- 3. Trường hợp 2: Terminal NvChad (NvTerm_float)
      -- Ở đây ta set SYNTAX là log, nhưng giữ nguyên FILETYPE là NvTerm_float
      -- để không làm hỏng chức năng của NvChad.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "NvTerm_float",
        callback = function()
          -- Kích hoạt syntax của plugin log-highlighting
          vim.bo.syntax = "log"
          -- Kích hoạt thêm custom highlight của mình
          apply_custom_highlights()
        end,
      })

      -- 4. User Command thủ công (Backup)
      vim.api.nvim_create_user_command("LogMode", function()
        vim.bo.syntax = "log"
        apply_custom_highlights()
        print "Log Highlight Enabled!"
      end, {})

      -- 5. Tự động nhận diện file .log từ đĩa
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.log", "*_FLUTTER_DEV_LOG_*" },
        callback = function()
          vim.bo.filetype = "log"
        end,
      })
    end,
  },

  {
    "nvim-neotest/nvim-nio",
    -- lazy = false,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest: Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "Neotest: Run current file",
      },
      {
        "<leader>tp",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Neotest: Run all tests in project",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Neotest: Run last test",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open { enter = true }
        end,
        desc = "Neotest: Open test output",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Neotest: Toggle summary panel",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand "%")
        end,
        desc = "Neotest: Watch current file",
      },
      {
        "<leader>tx",
        function()
          require("neotest").run.stop()
        end,
        desc = "Neotest: Stop running test",
      },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest",
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },
        summary = {
          enabled = true,
          open = "botright vsplit | vertical resize 60",
        },
        status = {
          enabled = true,
          virtual_text = true,
          signs = true,
        },
      }
    end,
  },
  {
    "mtdl9/vim-log-highlighting",
    -- lazy = false,
  },
  {
    "ggandor/flit.nvim",
    lazy = false,
    config = function()
      require("flit").setup()
    end,
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        per_filetype = {
          ["html"] = {
            enable_close = true,
          },
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#1e1e2e",
        },
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup {
        layout = {
          min_width = 35,
          default_direction = "right", -- Hiển thị bên phải
          placement = "window",
        },
      }
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    version = "^19.0.0",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCLI",
      "CodeCompanionCmd",
    },
    init = function()
      vim.cmd [[cab cc CodeCompanion]]
    end,
    opts = require "configs.codecompanion",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "codecompanion" },
        },
        ft = { "markdown", "codecompanion" },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      pcall(function()
        require("telescope").load_extension "codecompanion"
      end)
    end,
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    config = true,
  },

  -- {
  --   "Maan2003/lsp_lines.nvim",
  --   event = "LspAttach", -- Lazy load khi LSP attach
  --   config = function()
  --     -- Setup với error handling
  --     local status_ok, lsp_lines = pcall(require, "lsp_lines")
  --     if not status_ok then
  --       vim.notify("Failed to load lsp_lines", vim.log.levels.ERROR)
  --       return
  --     end
  --
  --     lsp_lines.setup()
  --
  --     -- Config diagnostic với workaround cho Neovim 0.11.x
  --     vim.diagnostic.config {
  --       virtual_lines = {
  --         only_current_line = true, -- Chỉ hiện dòng hiện tại để giảm lỗi
  --         highlight_whole_line = false, -- Giảm tải rendering
  --       },
  --       virtual_text = false, -- Tắt virtual text để dùng lsp_lines
  --       update_in_insert = false, -- Không update khi insert mode (giảm lỗi)
  --       severity_sort = true,
  --     }
  --
  --     -- Keymap để toggle lsp_lines khi cần
  --     vim.keymap.set("n", "<leader>ll", function()
  --       local current = vim.diagnostic.config().virtual_lines
  --       vim.diagnostic.config {
  --         virtual_lines = not current,
  --       }
  --     end, { desc = "Toggle LSP Lines" })
  --
  --     -- Workaround: tự động hide khi vào insert mode để tránh crash
  --     vim.api.nvim_create_autocmd("InsertEnter", {
  --       group = vim.api.nvim_create_augroup("LspLinesWorkaround", { clear = true }),
  --       callback = function()
  --         vim.diagnostic.config { virtual_lines = false }
  --       end,
  --     })
  --
  --     vim.api.nvim_create_autocmd("InsertLeave", {
  --       group = vim.api.nvim_create_augroup("LspLinesWorkaround", { clear = false }),
  --       callback = function()
  --         -- Delay để buffer đã stable
  --         vim.defer_fn(function()
  --           pcall(function()
  --             vim.diagnostic.config { virtual_lines = { only_current_line = true } }
  --           end)
  --         end, 100)
  --       end,
  --     })
  --   end,
  -- },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup {
        options = {
          use_icons_from_diagnostic = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
          break_line = {
            enabled = true,
            after = 80,
          },
        },
      }
      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        whitelist = { "javascript", "js", "typescript" },
      }
    end,
  },
  {
    "aurum77/live-server.nvim",
    run = function()
      require("live_server.util").install()
      local status_ok, live_server = pcall(require, "live_server")
      if not status_ok then
        return
      end

      live_server.setup {
        port = 8080,
        browser_command = "", -- Empty string starts up with default browser
        quiet = false,
        no_css_inject = false, -- Disables css injection if true, might be useful when testing out tailwindcss
        install_path = vim.fn.stdpath "config" .. "/live-server/",
      }
    end,
    cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
  },
  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {
      window = {
        width = 150,
      },
    },
  },

  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { "ray-x/guihua.lua" },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- cần Go để chạy
  -- },

  -- {
  --     "mistweaverco/kulala.nvim",
  --     version = false,
  --     lazy = false,
  --     opts = function()
  --         return require "configs.kulala_nvim"
  --     end,
  --     config = function(_, opts)
  --         require("kulala").setup(opts)
  --     end,
  -- },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "package.json", "Makefile", "pyproject.toml", "go.mod" },
      }
      require("telescope").load_extension "projects"
    end,
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    opts = {
      border = {
        enable = true,
        top_char = "-",
        bottom_char = "-",
      },
    },
    config = function(_, opts)
      require("glance").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
    config = true,
  },
  -- {
  --     "L3MON4D3/LuaSnip",
  --     build = "make install_jsregexp",
  --     dependencies = {
  --         "rafamadriz/friendly-snippets", -- Hàng trăm snippet cho HTML, React, JS, TS, v.v.
  --     },
  --     config = function()
  --         require("luasnip.loaders.from_vscode").lazy_load()
  --     end,
  -- }
  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
    },
    lazy = false,
    config = function()
      require "configs.dap"
    end,
  },

  -- {
  --   "rcarriga/nvim-dap-ui",
  --   lazy = false,
  --   config = function()
  --     require("dapui").setup()
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  -- },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   requires = { "mfussenegger/nvim-dap" },
  -- },

  {
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
  },
  {
    "phaazon/hop.nvim",
    lazy = false,
    branch = "v2",
    config = function()
      local hop = require "hop"
      hop.setup()

      -- local directions = require('hop.hint').HintDirection

      vim.keymap.set("n", "<leader>s", function()
        hop.hint_char1 { current_line_only = false }
      end, { silent = true, noremap = true, desc = "Hop to character" })

      vim.keymap.set("n", "<leader>2s", function()
        hop.hint_char2 { current_line_only = false }
      end, { silent = true, noremap = true, desc = "Hop to 2 characters" })

      vim.keymap.set("n", "<leader>ws", function()
        hop.hint_words { current_line_only = false }
      end, { silent = true, noremap = true, desc = "Hop to word" })
    end,
  },
}
