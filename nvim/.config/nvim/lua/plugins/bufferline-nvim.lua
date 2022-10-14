return function()
  require("bufferline").setup({
    options = {
      numbers = "none",
      diagnostics_indicator = false,
    },
    highlights = {
      fill = {
        bg = 'none',
      },
      background = {
        bg = 'none'
      },
      tab = {
        bg = 'none'
      },
      tab_selected = {
        bg = 'none'
      },
      tab_close = {
        bg = 'none'
      },
      close_button = {
        bg = 'none'
      },
      close_button_visible = {
        bg = 'none'
      },
      close_button_selected = {
        bg = 'none'
      },
      buffer_visible = {
        bg = 'none'
      },
      buffer_selected = {
        bg = 'none',
        bold = true,
        italic = true,
      },
      modified = {
        bg = 'none'
      },
      modified_visible = {
        bg = 'none'
      },
      modified_selected = {
        bg = 'none'
      },
      duplicate_selected = {
        bg = 'none',
        italic = true,
      },
      duplicate_visible = {
        bg = 'none',
        italic = true
      },
      duplicate = {
        bg = 'none',
        italic = true
      },
      separator_selected = {
        bg = 'none'
      },
      separator_visible = {
        bg = 'none'
      },
      separator = {
        bg = 'none'
      },
      indicator_selected = {
        bg = 'none'
      },
    }
  })
  vim.keymap.set('n', '<S-Up>', 'bn')
  vim.keymap.set('n', '<S-Down>', 'bp')
end
