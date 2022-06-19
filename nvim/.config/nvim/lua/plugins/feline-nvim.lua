return function()
    require('gitsigns').setup()
    local colors = {
        red = '#D57780',
        green = '#A3BE8C',
        blue = '#81A1C1',
        yellow = '#EBCB8B',
        bg = 'none'
    }

    local component = function(component)
        return vim.tbl_deep_extend('keep', {hl = {bg = colors.bg}}, component)
    end
    local space = component({provider = ' '})
    require('feline').setup({
        components = {
            active = {
                {
                    space,
                    component({
                        provider = {
                            name = 'file_info',
                            opts = {
                                type = 'relative',
                                colored_icon = true,
                                file_modified_icon = '[+]'
                            }
                        },
                        hl = {fg = colors.green, style = 'italic'},
                        short_provider = {}
                    }),
                    component({provider = ' on ', hl = {fg = colors.blue}}),
                    component({
                        provider = function()
                            local branch =
                                require('feline.providers.git').git_info_exists()
                            if branch then
                                return '' .. ' ' .. branch
                            end
                            return ''
                        end,
                        hl = {fg = colors.red, style = 'italic'}
                    })
                },
                {
                    component({
                        provider = 'lsp_client_names',
                        hl = {fg = colors.green, bg = colors.bg, gui = 'italic'}
                    }),
                    space
                }
            },
            inactive = {}
        }
    })

    local winbarComponents = {
        space,
        component({
            provider = function(c)
                return require('feline.providers.file').file_info(c, {
                    type = 'unique',
                    colored_icon = true,
                    file_modified_icon = ''
                })
            end,
            hl = {fg = colors.green, style = 'italic'},
            short_provider = {}
        }),
        space,
        component({
            provider = 'position',
            hl = {fg = colors.blue, bg = colors.bg, gui = 'italic'}
        }),
        component({
            provider = 'git_diff_added',
            enabled = require('feline.providers.git').git_info_exists,
            hl = {fg = colors.green}
        }),
        component({
            provider = 'git_diff_changed',
            enabled = require('feline.providers.git').git_info_exists,
            hl = {fg = colors.yellow}
        }),
        component({
            provider = 'git_diff_removed',
            enabled = require('feline.providers.git').git_info_exists,
            hl = {fg = colors.red}
        }),
        component({
            provider = 'diagnostic_errors',
            enabled = function()
                return require('feline.providers.lsp').diagnostics_exist(
                           vim.diagnostic.severity.ERROR)
            end,
            hl = {fg = colors.red, bg = colors.bg, gui = 'italic'}
        }),
        component({
            provider = 'diagnostic_warnings',
            enabled = function()
                return require('feline.providers.lsp').diagnostics_exist(
                           vim.diagnostic.severity.WARN)
            end,
            hl = {fg = colors.yellow, bg = colors.bg, gui = 'italic'}
        })
    }
    require('feline').winbar.setup({
        components = {
            active = {winbarComponents},
            inactive = {winbarComponents}
        }
    })
end
