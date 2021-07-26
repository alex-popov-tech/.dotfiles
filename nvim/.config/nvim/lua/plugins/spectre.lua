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
    map("n", "<leader>r", 'viw:lua require("spectre").open_visual()<CR>', {})
    map("n", "<leader>R", '<cmd>lua require("spectre").open()<CR>', {})
end
