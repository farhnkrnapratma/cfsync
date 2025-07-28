local wz = require "wezterm"

return {
  default_prog = { '/usr/bin/nu' },
  scrollback_lines = 50000,
  enable_scroll_bar = false,
  font = wz.font 'JetBrainsMono Nerd Font',
  font_size = 11,
  color_scheme = 'Gruvbox Material (Gogh)',
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },
  window_background_opacity = 0.9,
  default_cursor_style = 'BlinkingUnderline',
  cursor_blink_rate = 200,
  cursor_thickness = 1,
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  window_decorations = "NONE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_close_confirmation = 'NeverPrompt'
}


