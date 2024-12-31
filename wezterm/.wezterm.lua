local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- This is where you actually apply your config choices

--SHELL
config.default_prog = { '/usr/bin/fish', '-l' }

--COLORS
config.colors = {
  foreground = 'white',
  background = 'rgb(2 7 22 / 45%)',
  cursor_bg = 'white',
}

--APPEARANCE
config.font = wezterm.font 'MesloLGS Nerd Font Mono'
config.font_size = 13.0
config.default_cursor_style = 'SteadyBar'
config.underline_thickness = 1
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'

-- and finally, return the configuration to wezterm
return config
