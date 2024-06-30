local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Default Dark (base16)"
config.font_size = 12.0
config.line_height = 1.15
config.font = wezterm.font("JetBrainsMono Nerd Font", { italic = false, weight = "Bold" })
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 12,
  right = 12,
  top = 4,
  bottom = 4,
}
config.window_close_confirmation = "NeverPrompt"

return config
