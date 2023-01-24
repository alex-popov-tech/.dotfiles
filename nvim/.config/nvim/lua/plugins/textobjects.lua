return {
    -- Extend and create a/i textobjects
    {
        'echasnovski/mini.ai',
        keys = {{'a', mode = {'x', 'o'}}, {'i', mode = {'x', 'o'}}},
        branch = 'stable',
        config = function()
            require('mini.ai').setup({
                search_method = 'cover_or_nearest',
                custom_textobjects = {b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' }}
                -- { { '%b()', '%b[]', '%b{}' }, '^.().*().$' }
            })
        end
    },
    {
        'Julian/vim-textobj-variable-segment',
        keys = {{'av', mode = {'x', 'o'}}, {'iv', mode = {'x', 'o'}}},
        dependencies = {'kana/vim-textobj-user'}
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        keys = {
            {'af', mode = {'x', 'o'}},
            {'if', mode = {'x', 'o'}},
            {']m'},
            {'[m'},
            {']M'},
            {'[M'}
        },
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {[']m'] = '@function.outer'},
                        goto_next_end = {[']M'] = '@function.outer'},
                        goto_previous_start = {['[m'] = '@function.outer'},
                        goto_previous_end = {['[M'] = '@function.outer'}
                    }
                }
            })
        end
    },

    {
        'michaeljsmith/vim-indent-object',
        keys = {
            {'ai', mode = {'x', 'o'}},
            {'ii', mode = {'x', 'o'}},
            {'aI', mode = {'x', 'o'}},
            {'iI', mode = {'x', 'o'}}
        }
    }
}
