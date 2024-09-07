return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = {},
          keywords = {},
          functions = { bold = true },
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        day_brightness = 0.3,
        dim_inactive = true,
        lualine_bold = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
        cache = true,
        plugins = {
          all = package.loaded.lazy == nil,
          auto = true,
        },
      })
    end,
  },
}
