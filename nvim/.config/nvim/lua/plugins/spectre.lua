return function()
    require('spectre').setup({

      color_devicons = true,
      line_sep_start = '┌-----------------------------------------',
      result_padding = '¦  ',
      line_sep       = '└-----------------------------------------',
      highlight = {
          ui = "String",
          search =  "DiffDelete",
          replace ="DiffChange",
      },
    })
    vim.api.nvim_command("command! Replace :lua require'spectre'.open()")
end
