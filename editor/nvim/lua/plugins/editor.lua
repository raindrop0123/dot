return {
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = {
      "Trouble"
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
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
}
