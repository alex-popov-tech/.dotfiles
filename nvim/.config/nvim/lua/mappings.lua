for _, mappings in pairs({
    -- {'n', '<c-w>', ':w<cr>'},
    {'n', '<C-q>', 'ZZ'}, -- write and exit from current buffer
    {'n', 'Y', 'y$'}, -- do Y to yank till the end of the line
    -- split and navigate to it
    {'n', '<up>', ':bn<cr>'},
    {'n', '<down>', ':bp<cr>'},
    {'n', '<leader>-', ':split | wincmd j<cr>'},
    {'n', '<leader>|', ':vsplit | wincmd l<cr>'},
    {'n', 'zl', 'zo'}, -- remap zl back to zo
    -- replace selected
    {'n', 'R', ':%s///gI<left><left><left>'},
    -- if press 'a' no empty line it should respect indent
    {'n', 'a', 'len(getline(\'.\')) == 0 ? \'S\' : \'a\'', {expr = true}},
    -- show last commands list on last item
    {'n', 'Q', 'q:dd'},
    -- map to drop into { } block
    --  {"i", "{<cr>", "{}<left><cr><esc>O"},
    --  {"i", "{<space>", "{}<left><space><left><space>"},
    --  {"i", "(<cr>", "()<left><cr><esc>O"},
    --  {"i", "(<space>", "()<left><space><left><space>"},
    --  {"i", "({<space>", "({})<left><left><space><left><space>"},
    --  {"i", "({<cr>", "({})<left><left><cr><esc>O"},
    -- jump with  and stay cursor in center of the screen
    -- {"n", "*", "*zz", { noremap = true }},
    -- {"n", "n", "nzz", { noremap = true }},
    -- {"n", "N", "Nzz", { noremap = true }},
    {
        'n',
        'n',
        function()
            vim.cmd('norm! nzz')
            vim.opt.hlsearch = true
            vim.defer_fn(function() vim.opt.hlsearch = false end, 200)
        end,
        {noremap = true, remap = true}
    },
    {
        'n',
        'N',
        function()
            vim.cmd('norm! Nzz')
            vim.opt.hlsearch = true
            vim.defer_fn(function() vim.opt.hlsearch = false end, 200)
        end,
        {noremap = true, remap = true}
    },
    {
        'n',
        '*',
        function()
            vim.cmd('norm! *zz')
            vim.opt.hlsearch = true
            vim.defer_fn(function() vim.opt.hlsearch = false end, 200)
        end,
        {noremap = true, remap = true}
    },
    -- stay cursor on place when 'J'
    --  {"n", "J", "mzJ`z"},
    -- do not yank on x/X
    {'n', 'x', '"_dl'},
    {'n', 'X', '"_dh'},
    -- magic search mappnigs
    {'n', '/', '/\\v', {noremap = true}},
    {'v', ':s/', ':s/\\v', {noremap = true}},
    {'c', '%s/', '%s/\\v', {noremap = true}},
    {'c', '%s/', '%s/\\v', {noremap = true}},
    {
        'n',
        '<c-a>',
        function()
            local word_under_cursor = vim.fn.expand('<cword>')
            if word_under_cursor == 'true' then
                vim.cmd('normal ciwfalse')
                return
            elseif word_under_cursor == 'false' then
                vim.cmd('normal ciwtrue')
                return
            end
            vim.cmd('normal! ')
        end,
        {noremap = true}
    },
    {
        'n',
        '<c-x>',
        function()
            local word_under_cursor = vim.fn.expand('<cword>')
            if word_under_cursor == 'true' then
                vim.cmd('normal ciwfalse')
                return
            elseif word_under_cursor == 'false' then
                vim.cmd('normal ciwtrue')
                return
            end
            vim.cmd('normal! ')
        end,
        {noremap = true}
    }

}) do
    local mode = mappings[1]
    local key = mappings[2]
    local value = mappings[3]
    local options = mappings[4] or {silent = true}
    vim.keymap.set(mode, key, value, options)
end
