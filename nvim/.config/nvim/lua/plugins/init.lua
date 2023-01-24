local util = require('util')

return {
    {'svban/YankAssassin.vim', event = 'VeryLazy'},
    --  shiftwidth/expandtab/etc
    {'tpope/vim-sleuth', event = 'VeryLazy'},
    {
        'nyngwang/murmur.lua',
        event = 'VeryLazy',
        config = function()
            require('murmur').setup({
                -- cursor_rgb = 'purple', -- default to '#393939'
                max_len = 80, -- maximum word-length to highlight
                -- min_len = 3,
                -- disable_on_lines = 2000, -- to prevent lagging on large files. Default to 2000 lines.
                exclude_filetypes = {},
                callbacks = {
                    -- to trigger the close_events of vim.diagnostic.open_float.
                    function()
                        -- Close floating diag. and make it triggerable again.
                        vim.cmd('doautocmd InsertEnter')
                        vim.w.diag_shown = false
                    end
                }
            })
        end
    },

    -- add bunch of mappings like ]p ]e ]<space> etc.
    {'tpope/vim-unimpaired', event = 'VeryLazy'},
    -- allows repeat via dot for some plugins like surround
    {'tpope/vim-repeat', event = 'VeryLazy'},
    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        version = '*',
        config = function()
            require('nvim-surround').setup({
                aliases = {['b'] = {')', '}', ']', '>'}}
            })
        end
    },
    -- close all buffers but current
    {
        'schickling/vim-bufonly',
        init = function() vim.cmd('cnoreabbrev bo silent Bonly') end,
        cmd = 'Bonly'
    },
    -- close buffer
    {
        'ojroques/nvim-bufdel',
        init = function()
            vim.cmd('cnoreabbrev bd BufDel')
            vim.cmd('cnoreabbrev bd! BufDel!')
        end,
        cmd = 'BufDel'
    },
    -- replace without yankink deleted
    {
        'gbprod/substitute.nvim',
        config = function() require('substitute').setup({}) end,
        keys = {
            {
                'm',
                function() require('substitute').operator() end,
                {noremap = true}
            },
            {
                'mm',
                function() require('substitute').line() end,
                {noremap = true}
            },
            {'M', function() require('substitute').eol() end, {noremap = true}},
            {
                'm',
                function() require('substitute').eol() end,
                mode = 'x',
                {noremap = true}
            }
        }
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        config = {
            -- char = "▏",
            char = '│',
            filetype_exclude = {
                'help',
                'alpha',
                'dashboard',
                'neo-tree',
                'Trouble',
                'lazy'
            }
        }
    },

    {
        'kevinhwang91/nvim-ufo',
        event = 'VeryLazy',
        dependencies = {
            'kevinhwang91/promise-async',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()

            -- vim.o.foldcolumn = 0
            -- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            -- vim.o.foldlevelstart = 99
            -- vim.o.foldenable = true
            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.api.nvim_set_hl(0, 'MoreMsg', {bg = 'none', fg = '#7E9CD8'})

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix ..
                                         (' '):rep(
                                             targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end,
                fold_virt_text_handler = handler
            })
        end
    },

    -- live command preview
    {
        'smjonas/live-command.nvim',
        event = 'VeryLazy',
        config = function()
            require('live-command').setup({commands = {G = {cmd = 'g'}}})
        end
    },

    -- navigate/resize splits
    {
        'mrjones2014/smart-splits.nvim',
        config = function()
            require('smart-splits').setup({
                resize_mode = {
                    quit_key = '<ESC>',
                    resize_keys = {'l', 'd', 'u', 'r'},
                    silent = false,
                    hooks = {on_enter = nil, on_leave = nil}
                },
                default_amount = 5
            })
        end,
        keys = {
            {'<c-h>', function()
                require('smart-splits').move_cursor_left()
            end},
            {'<c-j>', function()
                require('smart-splits').move_cursor_down()
            end},
            {'<c-k>', function()
                require('smart-splits').move_cursor_up()
            end},
            {
                '<c-l>',
                function()
                    require('smart-splits').move_cursor_right()
                end
            },
            {
                '<c-w>',
                function()
                    require('smart-splits').start_resize_mode()
                end
            }
        }
    },

    -- open terminal in floating window
    {
        'numToStr/FTerm.nvim',
        config = function()
            require('FTerm').setup({
                border = 'rounded',
                dimensions = {height = 0.99, width = 0.99}
            })
            vim.api.nvim_set_hl(0, 'FloatBorder', {bg = 'none'})
        end,
        keys = {
            {
                '<F11>',
                function() require('FTerm').toggle() end,
                mode = {'t', 'n'}
            }
        }
    },

    -- file tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim'
        },
        keys = {{'<c-f>', '<cmd>Neotree position=float reveal<cr>'}},
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require('neo-tree').setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = 'rounded',
                enable_git_status = true,
                enable_diagnostics = false,
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = '│',
                        last_indent_marker = '└',
                        highlight = 'NeoTreeIndentMarker',
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = '',
                        expander_expanded = '',
                        expander_highlight = 'NeoTreeExpander'
                    },
                    icon = {
                        folder_closed = '',
                        folder_open = '',
                        folder_empty = 'ﰊ',
                        default = '*'
                    },
                    modified = {symbol = '[+]', highlight = 'NeoTreeModified'},
                    name = {
                        trailing_slash = false,
                        use_git_status_colors = true
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted = '✖', -- this can only be used in the git_status source
                            renamed = '', -- this can only be used in the git_status source
                            -- Status type
                            untracked = '',
                            ignored = '',
                            unstaged = '',
                            staged = '',
                            conflict = ''
                        }
                    }
                },
                window = {
                    mappings = {
                        ['<bs>'] = 'close_node',
                        ['<cr>'] = 'open',
                        ['s'] = 'open_split',
                        ['v'] = 'open_vsplit',
                        ['t'] = 'open_tabnew',
                        ['C'] = 'noop',
                        ['a'] = 'add',
                        ['A'] = 'add_directory',
                        ['d'] = 'delete',
                        ['r'] = 'rename',
                        ['y'] = 'copy_to_clipboard',
                        ['x'] = 'cut_to_clipboard',
                        ['p'] = 'paste_from_clipboard',
                        ['c'] = 'copy', -- takes text input for destination
                        ['m'] = 'move', -- takes text input for destination
                        ['q'] = 'close_window',
                        ['R'] = 'refresh',
                        ['z'] = 'noop'
                    }
                },
                nesting_rules = {},
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_by_name = {
                            '.DS_Store',
                            'thumbs.db'
                            -- "node_modules"
                        },
                        never_show = { -- remains hidden even if visible is toggled to true
                            -- ".DS_Store",
                            -- "thumbs.db"
                        }
                    },
                    follow_current_file = false, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    hijack_netrw_behavior = 'disabled', -- netrw left alone, neo-tree does not handle opening dirs
                    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                    -- instead of relying on nvim autocmd events.
                    window = {
                        popup = {
                            position = {col = '100%', row = '2'},
                            size = function(state)
                                local root_name =
                                    vim.fn.fnamemodify(state.path, ':~')
                                local root_len = string.len(root_name) + 4
                                return {
                                    width = math.max(root_len, 50),
                                    height = vim.o.lines - 6
                                }
                            end
                        },
                        mappings = {
                            --  ['<bs>'] = 'navigate_up',
                            ['.'] = 'set_root',
                            ['H'] = 'toggle_hidden',
                            --  ['/'] = 'fuzzy_finder',
                            ['/'] = 'noop',
                            ['f'] = 'filter_on_submit',
                            ['<c-x>'] = 'clear_filter'
                        }
                    }
                },
                buffers = {},
                git_status = {}
            })
        end
    },

    -- global replace
    {
        'windwp/nvim-spectre',
        dependencies = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
        cmd = 'Replace',
        config = function()
            require('spectre').setup({
                color_devicons = true,
                line_sep_start = '┌-----------------------------------------',
                result_padding = '¦  ',
                line_sep = '└-----------------------------------------',
                highlight = {
                    ui = 'String',
                    search = 'DiffDelete',
                    replace = 'DiffChange'
                }
            })
            vim.api.nvim_create_user_command('Replace', function()
                require('spectre').open()
            end, {})
        end
    },

    {
        'numToStr/Comment.nvim',
        keys = {{'<leader>cc'}, {'<leader>c', mode = {'x', 'o'}}},
        dependencies = {'JoosepAlviste/nvim-ts-context-commentstring'},
        config = function()
            require('Comment').setup({
                toggler = {line = '<leader>cc'},
                opleader = {line = '<leader>c'},
                pre_hook = function(ctx)
                    -- Only calculate commentstring for tsx filetypes
                    if vim.bo.filetype == 'typescriptreact' then
                        local U = require('Comment.utils')

                        -- Determine whether to use linewise or blockwise commentstring
                        local type = ctx.ctype == U.ctype.linewise and
                                         '__default' or '__multiline'

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.ctype == U.ctype.blockwise then
                            location =
                                require('ts_context_commentstring.utils').get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion ==
                            U.cmotion.V then
                            location =
                                require('ts_context_commentstring.utils').get_visual_start_location()
                        end

                        return
                            require('ts_context_commentstring.internal').calculate_commentstring(
                                {key = type, location = location})
                    end
                end
            })
        end
    },

    -- colorscheme
    {
        'rebelot/kanagawa.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.opt.fillchars:append({
                horiz = '━',
                horizup = '┻',
                horizdown = '┳',
                vert = '┃',
                vertleft = '┨',
                vertright = '┣',
                verthoriz = '╋'
            })
            require('kanagawa').setup({transparent = true, globalStatus = true})
            -- load the colorscheme here
            vim.cmd('colorscheme kanagawa')
        end
    },

    -- highlight hex text as color
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function()
            require('colorizer').setup(nil, {names = false, mode = 'foreground'})
        end
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        version = 'v3.*',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        event = {'BufEnter *.*'},
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'buffers',
                    numbers = 'none',
                    close_command = ':BufDel',
                    diagnostics_indicator = false,
                    hover = {enabled = false},
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    separator_style = {'', ''},
                    indicator = {style = 'none'}
                },
                highlights = {
                    fill = {bg = 'none'},
                    background = {bg = 'none'},
                    tab = {bg = 'none'},
                    tab_selected = {bg = 'none'},
                    tab_close = {bg = 'none'},
                    close_button = {bg = 'none'},
                    close_button_visible = {bg = 'none'},
                    close_button_selected = {bg = 'none'},
                    buffer_visible = {bg = 'none'},
                    buffer_selected = {bg = 'none', bold = true, italic = true},
                    modified = {bg = 'none'},
                    modified_visible = {bg = 'none'},
                    modified_selected = {bg = 'none'},
                    duplicate_selected = {bg = 'none', italic = true},
                    duplicate_visible = {bg = 'none', italic = true},
                    duplicate = {bg = 'none', italic = true},
                    separator_selected = {bg = 'none'},
                    separator_visible = {bg = 'none'},
                    separator = {bg = 'none'},
                    indicator_selected = {bg = 'none'}
                }
            })
        end
    },

    -- statusline
    {
        'feline-nvim/feline.nvim',
        branch = 'master',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'lewis6991/gitsigns.nvim'
        },
        event = {'BufEnter *.*'},
        config = function()
            require('gitsigns').setup()
            local feline = require('feline')
            local colors = {
                bg = 'none',
                default_fg = '#C8C093',
                red = '#C34043',
                git_red = '#C34043',
                git_yellow = '#DCA561',
                git_green = '#76946A',
                diagnostic_error = '#E82424',
                diagnostic_warn = '#FF9E3B',
                diagnostic_info = '#6A9589',
                light_blue = '#7E9CD8',
                light_purple = '#957FB8'
            }

            local is_ignored_filetype = function()
                return not util.t.includes({'prompt'}, vim.bo.filetype)
            end

            local component = function(comp)
                return util.t.merge('force', {
                    hl = {bg = colors.bg},
                    enabled = is_ignored_filetype
                }, comp)
            end
            local space = component({provider = ' ', hl = {bg = colors.bg}})

            feline.setup({
                force_inactive = {
                    filetypes = {
                        '^NvimTree$',
                        '^packer$',
                        '^startify$',
                        '^fugitive$',
                        '^fugitiveblame$',
                        '^qf$',
                        '^help$'
                    },
                    buftypes = {'^terminal$', 'prompt'},
                    bufnames = {}
                },
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
                                hl = {fg = colors.default_fg, style = 'italic'},
                                short_provider = {}
                            }),
                            component({
                                provider = ' on ',
                                hl = {fg = colors.light_blue}
                            }),
                            component({
                                provider = function()
                                    local branch = require(
                                                       'feline.providers.git').git_info_exists()
                                    if branch then
                                        return '' .. ' ' .. branch
                                    end
                                    return ''
                                end,
                                hl = {fg = colors.git_red, style = 'italic'}
                            })
                        },
                        {
                            component({
                                provider = 'lsp_client_names',
                                hl = {fg = colors.light_blue, style = 'italic'}
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
                    hl = {fg = colors.default_fg, style = 'italic'},
                    short_provider = {}
                }),
                space,
                space,
                component({
                    provider = 'position',
                    hl = {fg = colors.light_blue, gui = 'italic'}
                }),
                component({
                    provider = 'git_diff_added',
                    enabled = function()
                        return require('feline.providers.git').git_info_exists()
                    end,
                    hl = {fg = colors.git_green}
                }),
                component({
                    provider = 'git_diff_changed',
                    enabled = function()
                        return require('feline.providers.git').git_info_exists()
                    end,
                    hl = {fg = colors.git_yellow}
                }),
                component({
                    provider = 'git_diff_removed',
                    enabled = function()
                        require('feline.providers.git').git_info_exists()
                    end,
                    hl = {fg = colors.git_red}
                }),
                component({
                    provider = 'diagnostic_errors',
                    enabled = function()
                        return
                            require('feline.providers.lsp').diagnostics_exist(
                                vim.diagnostic.severity.ERROR)
                    end,
                    hl = {fg = colors.diagnostic_error, gui = 'italic'}
                }),
                component({
                    provider = 'diagnostic_warnings',
                    enabled = function()
                        return
                            require('feline.providers.lsp').diagnostics_exist(
                                vim.diagnostic.severity.WARN)
                    end,
                    hl = {fg = colors.diagnostic_warn, gui = 'italic'}
                })
            }
            feline.winbar.setup({
                components = {
                    active = {winbarComponents},
                    inactive = {winbarComponents}
                }
            })
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufReadPost',
        build = ':TSUpdate',
        config = function()
            local parser_configs =
                require('nvim-treesitter.parsers').get_parser_configs()
            parser_configs.http = {
                install_info = {
                    url = 'https://github.com/NTBBloodbath/tree-sitter-http',
                    files = {'src/parser.c'},
                    branch = 'main'
                }
            }
            require('nvim-treesitter.configs').setup({
                indent = {enable = true},
                ensure_installed = 'all',
                ignore_install = {'haskell'},
                highlight = {
                    enable = true, -- false will disable the whole extension
                    indent = {enable = true},
                    use_languagetree = true
                },
                context_commentstring = {enable = true},
                autotag = {enable = true},
                matchup = {
                    enable = true -- mandatory, false will disable the whole extension
                }
            })
        end
    },

    -- autocomplete closing tags, auto rename
    {
        'windwp/nvim-ts-autotag',
        event = 'BufReadPost',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require('nvim-ts-autotag').setup() end
    },

    -- better highlights args treesitter
    {
        'm-demare/hlargs.nvim',
        event = 'BufReadPost',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require('hlargs').setup({}) end
    },

    -- fancy notification messages
    {
        'rcarriga/nvim-notify',
        lazy = false,
        dependencies = {'rebelot/kanagawa.nvim'},
        config = function()
            local notify = require('notify')
            notify.setup({
                timeout = 2000,
                top_down = false,
                background_colour = '#000000',
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end
            })
            vim.notify = notify
        end
    },

    -- github code review plugin
    {
        'pwntester/octo.nvim',
        cmd = {'Octo'},
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('octo').setup()
            util.hi(0, 'OctoEditable', {bg = 'none'})
        end
    },

    {'sindrets/diffview.nvim', cmd = 'DiffviewOpen'},

    {'tpope/vim-fugitive', cmd = 'Gread'},

    {
        'ckolkey/ts-node-action',
        keys = {
            {
                '<c-a>',
                function()
                    local type =
                        require('nvim-treesitter.ts_utils').get_node_at_cursor():type()
                    if type == 'number' then
                        vim.cmd('normal! ')
                    else
                        require('ts-node-action').node_action()
                    end
                end
            },
            {
                '<c-x>',
                function()
                    local type =
                        require('nvim-treesitter.ts_utils').get_node_at_cursor():type()
                    if type == 'number' then
                        vim.cmd('normal! ')
                    else
                        require('ts-node-action').node_action()
                    end
                end
            }
        },
        dependencies = {'nvim-treesitter'},
        config = function() -- Optional
            require('ts-node-action').setup({})
        end
    },

    {
        'echasnovski/mini.move',
        keys = {
            {'H', mode = {'v'}},
            {'L', mode = {'v'}},
            {'J', mode = {'v'}},
            {'K', mode = {'v'}}
        },
        config = function()
            require('mini.move').setup(
                { -- Module mappings. Use `''` (empty string) to disable one.
                    mappings = {
                        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                        left = 'H',
                        right = 'L',
                        down = 'J',
                        up = 'K',
                        -- Move current line in Normal mode
                        line_left = '',
                        line_right = '',
                        line_down = '',
                        line_up = ''
                    }
                })
        end
    },

    {
        'hrsh7th/nvim-insx',
        event = 'VeryLazy',
        config = function() require('insx.preset.standard').setup() end
    },

    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        version = nil,
        branch = 'master'
    },

    {
        'Exafunction/codeium.vim',
        keys = {
            {
                '<c-space>',
                function() return vim.fn['codeium#Accept']() end,
                mode = {'i'},
                expr = true
            }
        },
        -- lua vim.keymap.set('i', '<C-space>', function () return vim.fn['codeium#Accept']() end, { expr = true })
        event = 'VeryLazy',
        branch = 'main'
    }

}
