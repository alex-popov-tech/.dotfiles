return function()
    require("bufferline").setup({
      options = {
        numbers = "none",
        diagnostics_indicator = false,
      },
      highlights = {
        fill = { bg = "none" },
        tab_close = { bg = "none" }
      }
    })
    vim.keymap.set('n', '<S-Up>', 'bn')
    vim.keymap.set('n', '<S-Down>', 'bp')
end
