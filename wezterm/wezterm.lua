local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Menlo'
config.color_scheme = 'Gruvbox Material (Gogh)'
config.font_size = 16.0
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.initial_cols = 125
config.initial_rows = 40
config.keys = {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab { confirm = false },
  },
}
config.window_close_confirmation = 'NeverPrompt'
config.pane_focus_follows_mouse = true
config.native_macos_fullscreen_mode = false

return config
