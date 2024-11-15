local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Menlo'
config.color_scheme = 'Gruvbox Material (Gogh)'
config.font_size = 16.0
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

return config
