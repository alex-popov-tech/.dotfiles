local palette = {
  bg = "#192330",
  muted = "#71839b",
  fg = "#cdcecf",
  blue = "#719cd6",
  yellow = "#dbc074",
  red = "#c94f6d",
}

return {
  palette = palette,
  colors = {
    tab_bar = {
      background = palette.bg,
      active_tab = {
        bg_color = palette.bg,
        fg_color = palette.blue,
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = palette.bg,
        fg_color = palette.muted,
      },
      new_tab = {
        bg_color = palette.bg,
        fg_color = palette.muted,
      },
    },
  },
}
