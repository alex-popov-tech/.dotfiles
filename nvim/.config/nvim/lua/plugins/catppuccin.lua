return function()
    require'catppuccin'.setup({
        transparent_background = true,
        term_colors = true
    })
    cmd("colorscheme catppuccin")
end
