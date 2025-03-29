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
        javascript = { "prettier" },
        typescript = { "prettier" },
        yaml = { "prettier" },
        cpp = { "clang-format" },
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
      { "LiadOz/nvim-dap-repl-highlights", config = true, branch = "LiadOz/fix-check-parser" },
    },
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-dap-repl-highlights").setup()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "terryma/vim-multiple-cursors",
    lazy = false,
  },

  -- {
  --   "mfussenegger/nvim-dap",
  --   lazy = false,
  --   config = function()
  --     require "configs.dap"
  --   end,
  -- },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   requires = { "mfussenegger/nvim-dap" },
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   lazy = false,
  --   config = function()
  --     require("dapui").setup()
  --   end,
  -- },
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim", -- optional for vim.ui.select
  --   },
  --   config = function()
  --     require("flutter-tools").setup {
  --       debugger = {
  --         enabled = true,
  --         run_via_dap = true,
  --         register_configurations = function(paths)
  --           require("dap").adapters.dart = {
  --             type = "executable",
  --             command = "/home/ngthminhdev/fvm/versions/2.8.1/bin/dart",
  --             -- command = '${workspaceFolder}/.fvm/flutter_sdk',
  --             args = { "debug_adapter" },
  --             options = {
  --               detached = false,
  --             },
  --           }
  --
  --           -- Flutter
  --           require("dap").adapters.flutter = {
  --             type = "executable",
  --             command = "/home/ngthminhdev/fvm/versions/2.8.1/bin/flutter",
  --             -- command = "/home/ngthminhdev/fvm/versions/3.19.0/bin/flutter",
  --             args = { "debug_adapter" },
  --             options = {
  --               detached = false,
  --             },
  --           }
  --
  --           require("dap").configurations.dart = {
  --             -- KPOS
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Development] KPOS",
  --               args = {
  --                 "--flavor",
  --                 "development",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android", -- Chỉ định platform (android hoặc ios)
  --               autoReload = {
  --                 enable = true,
  --               },
  --             },
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Local] KPOS",
  --               args = {
  --                 "--flavor",
  --                 "local",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main_development.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --               autoReload = {
  --                 enable = true,
  --               },
  --             },
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Staging] KPOS",
  --               args = {
  --                 "--flavor",
  --                 "local",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main_staging.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --             },
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Production] KPOS",
  --               args = {
  --                 "--flavor",
  --                 "local",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main_production.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --             },
  --
  --             -- KDB
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Development] KDB",
  --               args = {
  --                 "--flavor",
  --                 "development",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main_dev.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --               autoReload = {
  --                 enable = true,
  --               },
  --             },
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "[Production] KDB",
  --               args = {
  --                 "--flavor",
  --                 "production",
  --               },
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main_staging.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --             },
  --             {
  --               type = "flutter",
  --               request = "launch",
  --               name = "Launch Flutter",
  --               dartSdkPath = "${workspaceFolder}/.fvm/flutter_sdk/bin/cache/dart-sdk",
  --               flutterSdkPath = "${workspaceFolder}/.fvm/flutter_sdk",
  --               program = "${workspaceFolder}/lib/main.dart",
  --               cwd = "${workspaceFolder}",
  --               platform = "android",
  --             },
  --           }
  --         end,
  --       },
  --       fvm = true,
  --       -- flutter_path = "/home/ngthminhdev/fvm/versions/2.8.1/bin/flutter",
  --       dev_log = {
  --         enabled = true,
  --         notify_errors = false,
  --         open_cmd = "tabedit",
  --       },
  --     }
  --   end,
  -- },
  {
    "nvim-neotest/nvim-nio",
    -- lazy = false,
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
    "ggandor/leap.nvim",
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
            enable_close = false,
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
      "rcarriga/nvim-notify",
    },
  },

  {
    "stevearc/aerial.nvim",
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
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {

      provider = "qianwen",
      auto_suggestions_provider = "qianwen",
      vendors = {
        qianwen = {
          __inherited_from = "openai",
          endpoint = "http://localhost:1234/v1",
          model = "qwen2.5-coder-3b-instruct", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          -- ["local"] = true,
          api_key_name = "",
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
      },
      behaviour = {
        auto_suggestions = false,
      },

      mappings = {
        suggestion = {
          accept = "<C-e>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-.>",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional. You can alse set your own keybindings
    keys = {
      -- Global Minimap Controls
      { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
      { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
      { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
      { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
      { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

      ---Focus Controls
      { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
      { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
      }
    end,
  },
}
