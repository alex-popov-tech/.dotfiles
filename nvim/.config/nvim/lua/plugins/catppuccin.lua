return function()
    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerCompileDone',
        callback = function()
            vim.cmd 'CatppuccinCompile'
            vim.defer_fn(function() vim.cmd 'colorscheme catppuccin' end, 0) -- Defered for live reloading
        end
    })

    local colors = require('catppuccin.palettes').get_palette()
    colors.bg = colors.base

    vim.g.catppuccin_flavour = 'macchiato'
    require('catppuccin').setup({
        transparent_background = true,
        compile = {enabled = true},
        integrations = {
            lsp_trouble = true,
            lightspeed = true,
            native_lsp = {
                enabled = true,
                virtual_text = {},
                virtual_lines = {},
                underlines = {}
            }
        },
        custom_highlights = {
            DiagnosticVirtualTextError = {bg = colors.bg, fg = colors.error}
        }
    })
    --  hi('DiagnosticVirtualTextError', {guibg = 'none', guifg = colors.error})
end
