local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- This is where you actually apply your config choices

--SHELL
config.default_prog = { '/usr/bin/fish', '-l' }

--COLORS
--config.color_scheme = "Dracula (Official)"
config.colors = {
  foreground = 'white',
  background = 'rgb(2 8 25 / 45%)',
  cursor_bg = 'white',
  tab_bar = {
    background = 'rgb(2 8 25 / 45%)',
  },
}

--APPEARANCE
config.font = wezterm.font 'MesloLGS Nerd Font Mono'
config.font_size = 13.0
config.default_cursor_style = 'SteadyBar'
config.underline_thickness = 1
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 5,
  right = 0,
  top = 8,
  bottom = 0,
}
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
