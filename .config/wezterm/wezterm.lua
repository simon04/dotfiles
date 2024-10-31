local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'One Light (base16)'
config.initial_cols = 128
config.initial_rows = 48
return config

