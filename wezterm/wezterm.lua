local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

---@FONT
config.font_size = 8.0
config.font = wezterm.font("JetBrainsMono Nerd Font")

---@THEME
--config.color_scheme = "Default Dark (base16)"
config.colors = {
  foreground = "#d8d8d8",
  background = "#181818",
  cursor_fg = "#181818",
  cursor_bg = "#f7ca88",
  cursor_border = "#f7ca88",
  selection_fg = "#f8f8f8",
  selection_bg = "#585858",
  scrollbar_thumb = "#585858",
  split = "#585858",
  ansi = {
    "#181818",
    "#ab4642",
    "#a1b56c",
    "#f7ca88",
    "#7cafc2",
    "#ba8baf",
    "#86c1b9",
    "#d8d8d8",
  },
  brights = {
    "#585858",
    "#ab4642",
    "#a1b56c",
    "#f7ca88",
    "#7cafc2",
    "#ba8baf",
    "#86c1b9",
    "#f8f8f8",
  },
  compose_cursor = "#f7ca88",
  tab_bar = {
    background = "#181818",
    inactive_tab_edge = "#181818",
    active_tab = {
      bg_color = "#181818",
      fg_color = "#f7ca88",
      intensity = "Bold",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab = {
      bg_color = "#181818",
      fg_color = "#d8d8d8",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    inactive_tab_hover = {
      bg_color = "#181818",
      fg_color = "#d8d8d8",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = true,
    },
    new_tab = {
      bg_color = "#181818",
      fg_color = "#d8d8d8",
      italic = true,
    },
    new_tab_hover = {
      bg_color = "#181818",
      fg_color = "#d8d8d8",
      italic = true,
    },
  },
}
config.window_frame = {
  font = wezterm.font {
    family = "JetBrainsMono Nerd Font",
    weight = "Bold"
  },
  font_size = 8.0,
  active_titlebar_bg = "#181818",
  inactive_titlebar_bg = "#181818",
}

---@UI
config.line_height = 1.2
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

---@ANIMATION
config.animation_fps = 1

---@TAB
config.hide_tab_bar_if_only_one_tab = false

---@CUSTOM
config.window_close_confirmation = "NeverPrompt"

return config
