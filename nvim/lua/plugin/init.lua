return {
  --- UI ---
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "auto",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_color = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic", "bold" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {
          mocha = {
            base = "#11111b",
            mantle = "#11111b",
            crust = "#11111b",
          },
        },
        custom_highlights = function(color)
          return {
            CursorLineNr = { fg = color.green, style = { "bold" } },
            Pmenu = { bg = color.crust, fg = color.text },
            PmenuSel = { bg = color.blue, fg = color.crust, style = { "bold", "italic" } },
          }
        end,
        default_integrations = true,
        integrations = {
          aerial = false,
          alpha = true,
          barbar = false,
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
          beacon = false,
          coc_nvim = false,
          colorful_winsep = {
            enabled = false,
            color = "red",
          },
          dashboard = true,
          diffview = false,
          dropbar = {
            enabled = false,
            color_mode = false,
          },
          fern = false,
          fidget = false,
          flash = true,
          fzf = true,
          gitsigns = true,
          grug_far = false,
          harpoon = false,
          headlines = false,
          hop = false,
          indent_blankline = {
            enabled = true,
            scope_color = "pink",
            colored_indent_levels = false,
          },
          leap = false,
          lightspeed = false,
          lir = {
            enabled = false,
            git_status = false,
          },
          lsp_saga = false,
          markdown = true,
          mason = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          neotree = false,
          neogit = true,
          neotest = false,
          noice = true,
          NormalNvim = false,
          notifier = false,
          cmp = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = {
            enabled = false,
            custom_bg = "NONE",
          },
          notify = true,
          semantic_tokens = true,
          nvim_surround = false,
          nvimtree = true,
          treesitter_context = true,
          treesitter = true,
          ts_rainbow2 = false,
          ts_rainbow = false,
          ufo = true,
          window_picker = false,
          octo = false,
          overseer = false,
          pounce = false,
          rainbow_delimiters = true,
          render_markdown = true,
          symbols_outline = true,
          telekasten = false,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          lsp_trouble = false,
          dadbod_ui = false,
          gitgutter = false,
          illuminate = {
            enabled = true,
            lsp = false,
          },
          sandwich = false,
          vim_sneak = false,
          vimwiki = false,
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      style = "night",
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    disabled = true,
    lazy = true,
    event = "VeryLazy",
    opts = {},
    config = function() end,
  },
  {
    "rose-pine/neovim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    config = function()
      require("rose-pine").setup({})
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    config = function()
      require("onedark").setup({})
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    config = function()
      require('material').setup({})
    end,
  },
  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
        globalstatus = true,
      },
    },
  },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      dashboard = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = {
        enabled = true,
        debounce = 200,
        notify_jump = false,
        notify_end = true,
        foldopen = true,
        jumplist = true,
        modes = { "n", "i", "c" },
      },
      styles = {
        notification = {
          wo = { wrap = true }
        },
      },
      terminal = {
        enabled = true,
        win = {
          position = 'float',
          border = 'rounded',
        },
      },
    },
    keys = {
      { "<c-\\>", mode = { "n", "t" }, function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    },
  }, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  --- TOOL ---
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ft", mode = { "n" }, "<cmd>TodoTelescope<cr>", desc = "Find: Todo" },
    },
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "regex",
          "treesitter",
          "lsp",
        },
        delay = 200,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>tb",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle: Trouble Diagnostics",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = "NvimTreeToggle",
    keys = {
      { "<leader>tn", mode = { "n" }, "<cmd>NvimTreeToggle<cr>", desc = "Toggle: Nvim Tree" },
    },
    opts = {},
  },
  {
    "folke/flash.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
    opts = {},
  },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    cmd = { "FzfLua" },
    keys = {
      { "<leader><leader>", mode = "n", "<cmd>FzfLua commands<cr>", desc = "Find: Commands" },
      { "<localleader><localleader>", mode = "n", "<cmd>FzfLua commands<cr>", desc = "Find: Commands" },
      { "<leader>fb", mode = "n", "<cmd>FzfLua buffers<cr>", desc = "Find: Buffers" },
      { "<leader>fc", mode = "n", "<cmd>FzfLua colorschemes<cr>", desc = "Find: Colorschemes" },
      { "<leader>ff", mode = "n", "<cmd>FzfLua files<cr>", desc = "Find: Files" },
      { "<leader>fS", mode = "n", "<cmd>FzfLua lines<cr>", desc = "Find: Lines" },
      { "<leader>fs", mode = "n", "<cmd>FzfLua blines<cr>", desc = "Find: Buffer Lines" },
      { "<leader>fw", mode = "n", "<cmd>FzfLua live_grep<cr>", desc = "Find: Words" },
      { "<leader>fr", mode = "n", "<cmd>FzfLua oldfiles<cr>", desc = "Find: History" },
    },
  },
  --- TREESITTER ---
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context" },
    },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it"s custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "r",
        "typescript",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  --- COMPLETION & SNIPPET ---
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "onsails/lspkind.nvim" },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_lua").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_snipmate").lazy_load()
        end,
      },
    },
    config = function()
      require("cmp").setup({
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
            scrollbar = false,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDoc",
          },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = {
              abbr = 30,
              menu = 20,
            },
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        performance = {
          debounce = 30,
          throttle = 20,
          max_view_entries = 100,
        },
        mapping = require("cmp").mapping.preset.insert({
          ["<c-b>"] = require("cmp").mapping.scroll_docs(-4),
          ["<c-f>"] = require("cmp").mapping.scroll_docs(4),
          ["<c-g>"] = require("cmp").mapping.abort(),
          ["<cr>"] = require("cmp").mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp", max_item_count = 300 },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "buffer" },
        },
        experimental = {
          ghost_text = true,
        },
      })
      require("cmp").setup.cmdline({ '/', '?' }, {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      require("cmp").setup.cmdline(':', {
        mapping = require("cmp").mapping.preset.cmdline(),
        formatting = {
          fields = { "abbr" },
        },
        sources = require("cmp").config.sources({
          { name = 'path' },
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },
  --- LSP ---
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
            width = 0.92,
            height = 0.88,
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "basedpyright",
            "clangd",
            "lua_ls",
          },
        },
      },
    },
    config = function()
      require("lspconfig").basedpyright.setup({})
      require("lspconfig").clangd.setup({})
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
              disable = { "different-requires", "undefined-field" },
            },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
            hint = { enable = true, setType = true },
            format = { enable = false },
            telemetry = { enable = false },
            semantic = { enable = false },
          },
        },
      })
      require("lspconfig").r_language_server.setup({})
      pcall(vim.cmd.LspStart)
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      { "K", mode = { "n" }, "<cmd>Lspsaga hover_doc<cr>", desc = "LSP: Hover Documentation" },
      { "gd", mode = { "n" }, "<cmd>Lspsaga goto_definition<cr>", desc = "LSP: Go to Definition" },
      { "<leader>lo", mode = { "n" }, "<cmd>Lspsaga outline<cr>", desc = "LSP: Symbols Outline" },
      { "<leader>lp", mode = { "n" }, "<cmd>Lspsaga peek_definition<cr>", desc = "LSP: Peek Definition" },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    event = "LspAttach",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded"
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  --- LINTER & FORMATTER ---
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "jay-babu/mason-null-ls.nvim",
        opts = {
          ensure_installed = {
            "stylua",
          },
        },
      },
    },
    config = function()
      local none_ls = require("null-ls")
      none_ls.setup({
        border = "rounded",
        debug = false,
        log_level = "warn",
        update_in_insert = false,
        sources = {
          none_ls.builtins.formatting.stylua,
        },
      })
    end,
  },
  --- DAP ---
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          { "nvim-neotest/nvim-nio" },
        },
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", mode = {"n", "v"}, function() require("dapui").eval() end, desc = "Eval" },
        },
        opts = {},
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = {
            "codelldb", -- for C, Cpp
          },
          automatic_installation = true,
        },
      },
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "DAP: Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "DAP: Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "DAP: Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "DAP: Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "DAP: Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "DAP: Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "DAP: Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "DAP: Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "DAP: Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP: Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "DAP: Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "DAP: Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "DAP: Widgets" },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "$HOME/.local/share/nvim/mason/packages/codelldb/codelldb",
          args = {
            "--port",
            "${port}"
          },
        }
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
    end,
  },
}
