local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  local home = wezterm.home_dir

  local stats_tab, stats_pane, window = mux.spawn_window({
    workspace = "default",
    cwd = home .. "/.dotfiles",
  })
  window:gui_window():set_inner_size(2560, 1440)
  stats_pane:split({ args = { "/Users/alex/.go/bin/up" }, direction = "Right", size = 40 })
  stats_pane:send_text("btop\n")
  stats_tab:set_title("stats")
  wezterm.log_info(stats_pane:get_foreground_process_name())

  local dotfiles_tab = window:spawn_tab({
    args = args,
    cwd = home .. "/.dotfiles",
  })
  dotfiles_tab:set_title("dotfiles")

  local kc_tab = window:spawn_tab({ cwd = home .. "/me/work/informa" })
  kc_tab:set_title("K&C")

  local of_tab = window:spawn_tab({ cwd = home .. "/me/work/of/of-ui-integration-tests" })
  of_tab:set_title("of")

  window:gui_window():perform_action(act.ActivateTab(0), stats_pane)
end)

return {}
