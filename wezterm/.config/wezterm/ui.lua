local wezterm = require 'wezterm'
local utils = require 'utils'

local format_title = function(title, is_active, max_width)
    local background = {Background = {Color = '#24273a'}}
    local title_len = #title
    local pad_len = math.floor((max_width - title_len) / 2)

    local formatted_title = {
        Text = string.rep(' ', pad_len) .. title .. string.rep(' ', pad_len)
    }
    if is_active then
        return {background, {Foreground = {Color = '#c6a0f6'}}, formatted_title}
    else
        return {background, {Foreground = {Color = '#cad3f5'}}, formatted_title}
    end
end

local user_var_tab_title_key = 'tab_title';
wezterm.on('format-tab-title',
           function(tab, tabs, panes, config, hover, max_width)
    -- if there is title already set, proceed with it
    if type(tab.tab_title) == 'string' and #tab.tab_title > 0 then
        return format_title(tab.tab_title, tab.is_active, max_width)
    end
    return format_title('temp', tab.is_active, max_width)
end)

wezterm.on('user-var-changed', function(window, pane, name, value)
    wezterm.log_info('user-var-changed', name, value)
    if name == user_var_tab_title_key then pane:tab():set_title(value) end
end)

return {
    font = wezterm.font 'JetBrains Mono',
    font_size = 12,
    -- dpi = 144.0,
    tab_max_width = 16,
    color_scheme = 'Catppuccin Macchiato',
    window_decorations = 'RESIZE',
    window_background_opacity = 0.9,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    colors = {
        tab_bar = {
            -- The color of the inactive tab bar edge/divider
            background = '#24273a'
        }
    }
}
