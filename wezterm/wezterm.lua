local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--- FONT ---
config.font_size = 9.0
config.font = wezterm.font("JetBrainsMono Nerd Font")

--- THEME ---
--config.color_scheme = "Default Dark (base16)"
config.colors = {
  foreground = "#cdd6f4",
  background = "#11111b",
  cursor_fg = "#11111b",
  cursor_bg = "#f5e0dc",
  cursor_border = "#f5e0dc",
  selection_fg = "#11111b",
  selection_bg = "#89dceb",
  scrollbar_thumb = "#6c7086",
  split = "#9399b2",
  ansi = {
    "#1e1e2e",
    "#f38ba8",
    "#a6e3a1",
    "#f9e2af",
    "#89b4fa",
    "#cba6f7",
    "#74c7ec",
    "#cdd6f4",
  },
  brights = {
    "#1e1e2e",
    "#f38ba8",
    "#a6e3a1",
    "#f9e2af",
    "#89b4fa",
    "#cba6f7",
    "#74c7ec",
    "#cdd6f4",
  },
  compose_cursor = "#f2cdcd",
  tab_bar = {
    background = "#11111b",
    inactive_tab_edge = "#11111b",
    active_tab = {
      bg_color = "#11111b",
      fg_color = "#a6e3a1",
      intensity = "Bold",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab = {
      bg_color = "#11111b",
      fg_color = "#b4befe",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab_hover = {
      bg_color = "#11111b",
      fg_color = "#a6e3a1",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    new_tab = {
      bg_color = "#11111b",
      fg_color = "#cdd6f4",
      italic = true,
    },
    new_tab_hover = {
      bg_color = "#11111b",
      fg_color = "#cdd6f4",
      italic = true,
    },
  },
}
config.window_frame = {
  font = wezterm.font { family = "JetBrainsMono Nerd Font", weight = "Bold" },
  font_size = 8.0,
  active_titlebar_bg = "#11111b",
  inactive_titlebar_bg = "#11111b",
}

--- UI ---
config.line_height = 1.0
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

--- ANIMATION ---
config.animation_fps = 1

--- TAB ---
config.hide_tab_bar_if_only_one_tab = true

--- CUSTOM ---
config.window_close_confirmation = "NeverPrompt"

return config
