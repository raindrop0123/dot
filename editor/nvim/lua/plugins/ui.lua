return {
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = "InsertEnter",
    main = "ibl",
    opts = {}
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
    end,
  },
  {
    "folke/paint.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("paint").setup({
        ---@type PaintHighlight[]
        highlights = {
          {
            filter = { filetype = "lua" },
            pattern = "%s*%-%-%-%s*(@%w+)",
            hl = "Constant",
          },
        },
      })
    end,
  },
}
