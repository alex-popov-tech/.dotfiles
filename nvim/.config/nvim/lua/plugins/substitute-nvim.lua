return function()
    require('substitute').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    })
    vim.keymap.set('n', 'm', '<cmd>lua require(\'substitute\').operator()<cr>',
                   {noremap = true})
    vim.keymap.set('n', 'mm', '<cmd>lua require(\'substitute\').line()<cr>',
                   {noremap = true})
    vim.keymap.set('n', 'M', '<cmd>lua require(\'substitute\').eol()<cr>',
                   {noremap = true})
    vim.keymap.set('x', 'm', '<cmd>lua require(\'substitute\').visual()<cr>',
                   {noremap = true})
end
