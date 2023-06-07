local util = require('util')

return {
    --  shiftwidth/expandtab/etc
    {'tpope/vim-sleuth', event = 'VeryLazy'},
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
    -- after yank leave cursor on its place
    {'svban/YankAssassin.vim', event = 'VeryLazy'},
    -- replace without yankink deleted
    {
        'gbprod/substitute.nvim',
        event = 'VeryLazy',
        config = function()
            require('substitute').setup({})
            vim.keymap.set({'x', 'n'}, 'm',
                           function()
                require('substitute').operator()
            end, {noremap = true})
            vim.keymap.set('n', 'mm',
                           function() require('substitute').line() end,
                           {noremap = true})
            vim.keymap.set('n', 'M', function()
                require('substitute').eol()
            end, {noremap = true})
        end
    },

    -- visual representation for idention
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

    -- nice folding
    {
        'kevinhwang91/nvim-ufo',
        enabled = true,
        event = 'VeryLazy',
        dependencies = {
            'kevinhwang91/promise-async',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.api.nvim_set_hl(0, 'MoreMsg', {bg = 'none', fg = '#7E9CD8'})

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local totalLines = vim.api.nvim_buf_line_count(0)
                local foldedLines = endLnum - lnum
                local suffix = ('  %d %d%%'):format(foldedLines,
                                                       foldedLines / totalLines *
                                                           100)
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
                local rAlignAppndx = math.max(math.min(
                                                  vim.opt.textwidth['_value'],
                                                  width - 1) - curWidth -
                                                  sufWidth, 0)
                suffix = (' '):rep(rAlignAppndx) .. suffix
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
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            -- local builtin = require("statuscol.builtin")
            require('statuscol').setup({})
        end
    },
    -- live command preview
    {
        'smjonas/live-command.nvim',
        cmd = {'G'},
        event = 'VeryLazy',
        config = function()
            require('live-command').setup({commands = {G = {cmd = 'g'}}})
        end
    },

    -- navigate splits
    {
        'numToStr/Navigator.nvim',
        keys = {
            {'<C-h>', '<CMD>NavigatorLeft<CR>', mode = {'n', 't'}},
            {'<C-l>', '<CMD>NavigatorRight<CR>', mode = {'n', 't'}},
            {'<C-k>', '<CMD>NavigatorUp<CR>', mode = {'n', 't'}},
            {'<C-j>', '<CMD>NavigatorDown<CR>', mode = {'n', 't'}}
        },
        config = function()
            local ok, wezterm = pcall(function()
                return require('Navigator.mux.wezterm'):new()
            end)
            require('Navigator').setup({mux = ok and wezterm or 'auto'})
        end
    },

    -- split resize mode
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
            {
                '<c-w>',
                function()
                    require('smart-splits').start_resize_mode()
                end
            }
        }
    },
    {'anuvyklack/hydra.nvim', event = 'VeryLazy'},

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
            require('kanagawa').setup({
                transparent = true,
                globalStatus = true
            })
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

    -- fancy notification messages
    {
        'rcarriga/nvim-notify',
        lazy = false,
        config = function()
            local notify = require('notify')
            notify.setup({
                fps = 60,
                level = 2,
                render = 'compact',
                stages = 'fade',
                timeout = 5,
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
            -- local notify = vim.notify
            -- vim.notify = function(message, level, opts)
            --     -- local final = ''
            --     -- if message ~= nil then
            --     --     final = final .. 'message is ' .. message
            --     -- end
            --     -- if level ~= nil then
            --     --     final = final .. 'level is ' .. level
            --     -- end
            --     -- if opts ~= nil then
            --     --     final = final .. 'opts is ' .. vim.inspect(opts)
            --     -- end
            --     -- if level and level == 'info' and opts and opts.title and
            --     --     opts.title:find('prettierd') then return end
            --     if message and message == 'Complete' then
            --         -- notify(message .. ' ' .. level .. ' ' .. vim.inspect(opts))
            --         return
            --     end
            --     notify(message or "", level, opts)
            -- end
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

    {'echasnovski/mini.ai'},

    {'b0o/schemastore.nvim'},

    {'SmiteshP/nvim-navic', dependencies = {'neovim/nvim-lspconfig'}},

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
        'andymass/vim-matchup',
        event = 'VeryLazy',
        version = nil,
        branch = 'master'
    },

    -- {
    --     'Exafunction/codeium.vim',
    --     keys = {
    --         {
    --             '<c-}>',
    --             function()
    --                 return vim.cmd [[call codeium#CycleCompletions(1)]]
    --             end,
    --             mode = {'i'},
    --             expr = true
    --         },
    --         {
    --             '<c-{>',
    --             function()
    --                 return vim.cmd [[call codeium#CycleCompletions(-1)]]
    --             end,
    --             mode = {'i'},
    --             expr = true
    --         },
    --         {
    --             '<c-space>',
    --             function() return vim.fn['codeium#Accept']() end,
    --             mode = {'i'},
    --             expr = true
    --         }
    --     },
    --     event = 'VeryLazy',
    --     branch = 'main',
    --     config = function() vim.g.codeium_disable_bindings = 1 end
    --     -- enabled = true
    -- },

    {
        'ggandor/leap.nvim',
        dependencies = {'tpope/vim-repeat'},
        event = 'VeryLazy',
        config = function() require('leap').add_default_mappings() end
    },

    {
        'Wansmer/treesj',
        -- keys = {'<space>s'},
        keys = {
            {
                '<leader>s',
                function() require('treesj').toggle() end,
                mode = {'n'}
            }
        },
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('treesj').setup({use_default_keymaps = false})
        end
    }

}
