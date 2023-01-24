local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)

    local stats_tab, htop_pane, window = mux.spawn_window {
        workspace = 'local',
        cwd = wezterm.home_dir,
        width = 100,
        height = 100
    }
    stats_tab:set_title 'my title'
    htop_pane:send_text 'htop\n'

    local ping_pane = htop_pane:split{
        direction = 'Right',
        size = 0.3,
        cwd = wezterm.home_dir
    }
    ping_pane:send_text 'ping google.com\n'

    window:spawn_tab{cwd = wezterm.home_dir .. '/.dotfiles'}

    local zmk_tab, zmk_pane = window:spawn_tab{
        cwd = wezterm.home_dir .. '/me/zmk-fork'
    }
    local zmk_config_pane = zmk_pane:split{
        direction = 'Bottom',
        size = 0.8,
        cwd = wezterm.home_dir .. '/me/zmk-config'
    }

    local lokalise_tab = window:spawn_tab{cwd = wezterm.home_dir .. '/me/louis'}
    lokalise_tab:set_title('lokalise')

    local kc_tab = window:spawn_tab{cwd = wezterm.home_dir .. '/me/informa_e2e'}
    kc_tab:set_title('K&C')

    window:spawn_tab{cwd = wezterm.home_dir .. '/me/extensions'}

  stats_tab:focus()
    mux.set_active_workspace 'local'
end)

return {
    font = wezterm.font 'JetBrains Mono',
    default_prog = {'/opt/homebrew/bin/zsh'},
    use_fancy_tab_bar = true,
    window_decorations = 'NONE',
    unix_domains = {{name = 'unix'}}
}
