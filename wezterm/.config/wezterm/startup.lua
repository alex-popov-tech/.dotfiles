local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    -- allow `wezterm start -- something` to affect what we spawn
    -- in our initial window
    local args = {}
    if cmd then args = cmd.args end

    local home = wezterm.home_dir

    local stats_tab, stats_pane, window = mux.spawn_window {
        workspace = 'default',
        cwd = home .. '/.dotfiles'
    }
    -- window:gui_window():maximize()
    stats_pane:send_text('btop\n')
    stats_tab:set_title('stats')

    local dotfiles_tab = window:spawn_tab({
        args = args,
        cwd = home .. '/.dotfiles'
    })
    dotfiles_tab:set_title('dotfiles')

    local kc_tab = window:spawn_tab({cwd = home .. '/me/informa_e2e'})
    kc_tab:set_title('K&C')

    local frontend_tab = window:spawn_tab({cwd = home .. '/me/reporter'})
    frontend_tab:set_title('RIP')

    window:gui_window():perform_action(act.ActivateTab(0), stats_pane)
end)

return {}
