return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { bold = true },
          keywords = { bold = true },
          functions = { bold = true },
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = true,
        lualine_bold = true,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      })
      vim.api.nvim_command("colorscheme tokyonight")
    end,
  },
}
