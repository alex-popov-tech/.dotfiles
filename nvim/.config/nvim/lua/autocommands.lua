-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = {'*'},
    callback = function()
        vim.highlight.on_yank({higroup = 'Visual', timeout = 100})
    end
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

-- write path when save file if needed
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = {'*'},
    callback = function()
        vim.cmd(
            ':exe \': !mkdir -p \' . escape(fnamemodify(bufname(\'%\'),\':p:h\'),\'#% \\\')')
    end
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

local ns = vim.api.nvim_create_namespace('toggle_hlsearch')

local function toggle_hlsearch(char)
    if vim.fn.mode() == 'n' then
        local keys = {'<CR>', 'n', 'N', '*', '#', '?', '/'}
        local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end

vim.on_key(toggle_hlsearch, ns)
