return {
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
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>tt",
        "<CMD>Trouble diagnostics toggle<CR>",
        desc = "Toggle: Trouble Diagnostics",
      },
    },
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
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
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "◉",
        virtual_symbol_position = "eol",
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "regex",
          "lsp",
          "treesitter",
        },
        delay = 500,
      })
    end,
  },
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = function()
      require("bigfile").setup {
        filesize = 2,
        pattern = { "*" },
        features = {
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      }
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require('rainbow-delimiters.setup').setup({
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
          lua = 210,
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
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = "NvimTreeToggle",
    keys = {
      {
        "<leader>tn",
        "<CMD>NvimTreeToggle<CR>",
        desc = "Toggle: Nvim Tree",
      },
    },
    opts = {},
  },
}
