local wz = require "wezterm"

return {
  default_prog = { '/usr/bin/nu' },
  scrollback_lines = 50000,
  enable_scroll_bar = false,
  font = wz.font 'FiraCode Nerd Font Mono',
  font_size = 11,
  color_scheme = 'Catppuccin Mocha',
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },
  window_background_opacity = 0.7,
  default_cursor_style = 'BlinkingUnderline',
  cursor_blink_rate = 200,
  cursor_thickness = 1,
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  window_decorations = "NONE",
  window_padding = {
    left = 8,
    right = 2,
    top = 0,
    bottom = 0,
  },
  window_close_confirmation = 'NeverPrompt'
}


