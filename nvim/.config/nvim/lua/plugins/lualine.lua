return function()
    local lualine = require('lualine')
    local colors = {
        red = '#D57780',
        green = '#A3BE8C',
        blue = '#81A1C1',
        yellow = '#EBCB8B',
        bg = 'none'
    }
    local space = {
        function() return ' ' end,
        padding = {left = 0, right = 0},
        color = {bg = colors.bg}
    }
    lualine.setup({
        options = {
            icons_enabled = true,
            theme = {normal = {c = {bg = 'none'}}},
            component_separators = {left = '', right = ''},
            section_separators = {left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true
        },
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                space,
                {
                    'filetype',
                    colored = true, -- Displays filetype icon in color if set to true
                    icon_only = true, -- Display only an icon for filetype
                    padding = {left = 0, right = 0}
                },
                space,
                {
                    'filename',
                    file_status = true,
                    path = 1,
                    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                    symbols = {
                        modified = '[+]', -- Text to show when the file is modified.
                        readonly = '🔒', -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]' -- Text to show for unnamed buffers.
                    },
                    color = {fg = colors.green, bg = colors.bg, gui = 'italic'},
                    padding = {left = 0, right = 0}
                },
                space,
                {
                    function() return 'on' end,
                    color = {fg = colors.blue, bg = colors.bg},
                    padding = {left = 0, right = 0}
                },
                space,
                {
                    'branch',
                    icon = '',
                    padding = {left = 0, right = 0},
                    color = {fg = colors.red, bg = colors.bg, gui = 'italic'}
                },
                space,
                {
                    'diff',
                    icon = '',
                    color = {fg = colors.red, bg = colors.bg},
                    padding = {left = 0, right = 0}
                }
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {
                {
                    'diagnostics',
                    sources = {'nvim_lsp'},
                    sections = {'error', 'warn'},
                    diagnostics_color = {
                        color_error = colors.red,
                        color_warn = colors.yellow
                    },
                    symbols = {error = ' ', warn = ' '},
                    colored = true, -- Displays diagnostics status in color if set to true.
                    update_in_insert = false, -- Update diagnostics in insert mode.
                    always_visible = true, -- Show diagnostics even if there are none.
                    padding = {left = 0, right = 0},
                    color = {bg = colors.bg}
                },
                space,
                {
                    function()
                        local noClientMessage = 'No Active Lsp'
                        local buf_ft = vim.api
                                           .nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return noClientMessage
                        end
                        local clientNames = {}
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~=
                                -1 then
                                table.insert(clientNames, client.name)
                            end
                        end
                        if vim.tbl_count(clientNames) == 0 then
                            return noClientMessage
                        end
                        return table.concat(clientNames, '|')
                    end,
                    icon = ' ',
                    color = {fg = colors.blue, bg = colors.bg, gui = 'italic'},
                    padding = {left = 0, right = 0}
                },
                {'%l:%c'}
            }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {'nvim-tree', 'fugitive', 'quickfix', 'toggleterm'}
    })
end
