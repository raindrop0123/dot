local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font_size = 11.25
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.color_scheme = "Default Dark (base16)"
config.line_height = 1.0
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.command_palette_font_size = 11.25
config.command_palette_bg_color = "#181818"
config.command_palette_fg_color = "#d8d8d8"

return config
