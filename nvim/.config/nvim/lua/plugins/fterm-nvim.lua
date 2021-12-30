return function()
    require'FTerm'.setup({
      border = 'rounded',
      dimensions  = {
          height = 0.99,
          width = 0.99,
      },
    })
    map("n", "<F11>", "<CMD>lua require('FTerm').toggle()<CR>")
    map("t", "<F11>", "<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>")
end
