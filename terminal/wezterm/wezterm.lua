local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- FONT
config.font_size = 12.0
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- THEME
--config.color_scheme = "Default Dark (base16)"
config.colors = {
  foreground = "#abb2bf",
  background = "#1b1f27",
  cursor_fg = "#1b1f27",
  cursor_bg = "#ff75a0",
  cursor_border = "#ff75a0",
  selection_fg = "#1b1f27",
  selection_bg = "#61afef",
  scrollbar_thumb = "#1e222a",
  split = "#373b43",
  ansi = {
    "#1b1f27",
    "#e06c75",
    "#98c379",
    "#e7c787",
    "#61afef",
    "#c882e7",
    "#a3b8ef",
    "#abb2bf"
  },
  brights = {
    "#1e222a",
    "#ff75a0",
    "#7eca9c",
    "#EBCB8B",
    "#81A1C1",
    "#c882e7",
    "#519ABA",
    "#abb2bf",
  },
  compose_cursor = "#ff75a0",
  tab_bar = {
    background = "#1b1f27",
    inactive_tab_edge = "#42464e",
    active_tab = {
      bg_color = "#1b1f27",
      fg_color = "#98c379",
      intensity = "Bold",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab = {
      bg_color = "#1b1f27",
      fg_color = "#abb2bf",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab_hover = {
      bg_color = "#1b1f27",
      fg_color = "#abb2bf",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    new_tab = {
      bg_color = "#1b1f27",
      fg_color = "#abb2bf",
      italic = true,
    },
    new_tab_hover = {
      bg_color = "#1b1f27",
      fg_color = "#abb2bf",
      italic = true,
    },
  },
}
config.window_frame = {
  font = wezterm.font { family = "JetBrainsMono Nerd Font", weight = "Bold" },
  font_size = 12.0,
  active_titlebar_bg = "#1b1f27",
  inactive_titlebar_bg = "#1b1f27",
}

-- UI
config.line_height = 1.15
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- ANIMATION
config.animation_fps = 1

-- TAB
config.hide_tab_bar_if_only_one_tab = true

-- CUSTOM
config.window_close_confirmation = "NeverPrompt"

return config
