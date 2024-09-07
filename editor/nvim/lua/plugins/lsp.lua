return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
          }
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "clangd",
            "lua_ls",
            "pylsp",
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.pylsp.setup({})
      pcall(vim.cmd.LspStart)
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "K",
        "<CMD>Lspsaga hover_doc<CR>",
        desc = "LSP: Hover",
      },
      {
        "gd",
        "<CMD>Lspsaga goto_definition<CR>",
        desc = "LSP: Go to definition"
      },
      {
        "ga",
        "<CMD>Lspsaga code_action<CR>",
        desc = "LSP: Code action"
      },
    },
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end
  },
  {
    "j-hui/fidget.nvim",
    lazy = true,
    event = "LspAttach",
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    lazy = true,
    event = "LspAttach",
    ft = "lua",
    opts = {},
  },
}
