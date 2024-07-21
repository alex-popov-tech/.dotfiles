local vars = require("vars")
local wezterm = require("wezterm")

local format_title = function(title, is_active, max_width)
  local background = { Background = { Color = "#1f1f28" } }
  local title_len = #title
  local pad_len = math.floor((max_width - title_len) / 2)

  local formatted_title = {
    Text = string.rep(" ", pad_len) .. title .. string.rep(" ", pad_len),
  }
  if is_active then
    -- return { background, { Foreground = { Color = "teal" } }, formatted_title }
    return { formatted_title }
  else
    return { formatted_title }
  end
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
  color_scheme = "Tokyo Night",
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
  tab_max_width = 14,
  colors = {
    tab_bar = {
      -- The color of the inactive tab bar edge/divider
      -- background = "none",
    },
    --   foreground = "#dcd7ba",
    --   background = "#1f1f28",
    --
    --   cursor_bg = "#c8c093",
    --   cursor_fg = "#c8c093",
    --   cursor_border = "#c8c093",
    --
    --   selection_fg = "#c8c093",
    -- selection_bg = "#2d4f67",
    --
    --   scrollbar_thumb = "#16161d",
    --   split = "#16161d",
    --
    --   ansi = {
    --     "#090618",
    --     "#c34043",
    --     "#76946a",
    --     "#c0a36e",
    --     "#7e9cd8",
    --     "#957fb8",
    --     "#6a9589",
    --     "#c8c093",
    --   },
    --   brights = {
    --     "#727169",
    --     "#e82424",
    --     "#98bb6c",
    --     "#e6c384",
    --     "#7fb4ca",
    --     "#938aa9",
    --     "#7aa89f",
    --     "#dcd7ba",
    --   },
    --   indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
  window_decorations = "RESIZE",
  window_background_opacity = 1,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
}
