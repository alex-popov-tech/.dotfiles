return function()
    local parser_configs =
        require('nvim-treesitter.parsers').get_parser_configs()
    parser_configs.http = {
        install_info = {
            url = 'https://github.com/NTBBloodbath/tree-sitter-http',
            files = {'src/parser.c'},
            branch = 'main'
        }
    }
    require'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        ignore_install = {'haskell'},
        highlight = {
            enable = true, -- false will disable the whole extension
            indent = {enable = true},
            use_languagetree = true
        },
        context_commentstring = {enable = true, enable_autocmd = true},
        pairs = {
            enable = true,
            disable = {},
            highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
            highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
            goto_right_end = false, -- whether to go to the end of the right partner or the beginning
            fallback_cmd_normal = 'call matchit#Match_wrapper(\'\',1,\'n\')', -- What command to issue when we can't find a pair (e.g. "normal! %")
            keymaps = {goto_partner = '<leader>%'} -- do not work
        }
    }
end
