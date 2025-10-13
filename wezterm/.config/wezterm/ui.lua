local vars = require("vars")
local wezterm = require("wezterm")

local format_title = function(title, is_active, max_width)
  local title_len = #title
  local pad_len = math.floor((max_width - title_len) / 2)

  local formatted_title = {
    Text = string.rep(" ", pad_len) .. title .. string.rep(" ", pad_len),
  }
  return { { Background = { Color = "#1d2021" } }, formatted_title }
  -- if is_active then
  --   -- return { background, { Foreground = { Color = "teal" } }, formatted_title }
  -- else
  --   return { formatted_title }
  -- end
end

local user_var_tab_title_key = "tab_title"
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- if there is title already set, proceed with it
  if type(tab.tab_title) == "string" and #tab.tab_title > 0 then
    return format_title(tab.tab_title, tab.is_active, max_width)
  end
  return format_title("temp", tab.is_active, max_width)
end)

wezterm.on("update-right-status", function(window)
  local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
  local mode = vars.is_resize_mode and "Resize Mode Activated |↑ up|↓ down|← left|→ right|  " or ""
  window:set_right_status(mode .. date)
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
  wezterm.log_info("user-var-changed", name, value)
  if name == user_var_tab_title_key then
    pane:tab():set_title(value)
  end
end)

return {
  animation_fps = 120,
  dpi = 144.0,
  max_fps = 120,
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  color_scheme = "Gruvbox dark, hard (base16)",
  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
  font_rules = {
    {
      italic = true,
      font = wezterm.font({
        family = "JetBrainsMono Nerd Font Mono",
        weight = "DemiBold",
        italic = true,
      }),
    },
  },
  font_size = 13,
  adjust_window_size_when_changing_font_size = false,
  -- dpi = 144.0,
  tab_max_width = 18,
  colors = {
    tab_bar = {
      -- The color of the inactive tab bar edge/divider
      background = "none",
      new_tab = {
        bg_color = "#1d2021",
        fg_color = "#d3869b",
      },
      active_tab = {
        bg_color = "#2b2042",
        fg_color = "#d3869b",
        italic = true,
      },
    },
  },
  window_decorations = "RESIZE",
  window_background_opacity = 1,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
}
