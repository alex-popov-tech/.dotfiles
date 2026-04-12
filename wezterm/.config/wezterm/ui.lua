local vars = require("vars")
local wezterm = require("wezterm")
local theme_colors = require("colors.nightfox")
local p = theme_colors.palette

local user_var_tab_title_key = "tab_title"
wezterm.on("update-status", function(window)
  local segments = {}
  if vars.is_resize_mode then
    table.insert(segments, { Foreground = { Color = p.yellow } })
    table.insert(segments, { Text = "RESIZE: l/r/u/d (shift=15x) | ESC to exit  " })
  end
  table.insert(segments, { Foreground = { Color = p.muted } })
  table.insert(segments, { Text = wezterm.strftime("%H:%M:%S %d-%m-%Y ") })
  window:set_right_status(wezterm.format(segments))
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == user_var_tab_title_key then
    pane:tab():set_title(value)
  end
end)

return {
  color_scheme = "nightfox",
  colors = theme_colors.colors,
  animation_fps = 60,
  max_fps = 120,
  front_end = "WebGpu",
  font = wezterm.font_with_fallback({ "JetBrains Mono" }),
  font_rules = {
    {
      italic = true,
      font = wezterm.font_with_fallback({
        { family = "JetBrains Mono", weight = "DemiBold", italic = true },
      }),
    },
  },
  font_size = 13,
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
  window_background_opacity = 0.9,
  macos_window_background_blur = 20,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
}
