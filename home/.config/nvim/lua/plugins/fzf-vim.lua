return function()
    local createMapping = require "utils".createMapping
    -- previews for fuzzy search
    vim.cmd(
        "command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview('up'), <bang>0)"
    )
    vim.cmd(
        "command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('up'), <bang>0)"
    )
    -- search for content occurrences only, not file names
    vim.cmd(
        "command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up'), <bang>0)"
    )
    -- search for content occurrences in only git files
    vim.cmd(
        "command! -bang -nargs=* GGrep call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, fzf#vim#with_preview('up'),<bang>0)"
    )
    -- respect color scheme
    vim.g.fzf_colors = {
        fg = {"fg", "Normal"},
        bg = {"bg", "Normal"},
        hl = {"fg", "Comment"},
        ["fg+"] = {"fg", "CursorLine", "CursorColumn", "Normal"},
        ["bg+"] = {"bg", "CursorLine", "CursorColumn"},
        ["hl+"] = {"fg", "Statement"},
        info = {"fg", "PreProc"},
        border = {"fg", "Ignore"},
        prompt = {"fg", "Conditional"},
        pointer = {"fg", "Exception"},
        marker = {"fg", "Keyword"},
        spinner = {"fg", "Label"},
        header = {"fg", "Comment"}
    }
    vim.g.fzf_layout = {window = {width = 0.9, height = 0.7}}
    -- define actions
    vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "split",
        ["ctrl-v"] = "vsplit"
    }
    -- [Buffers] Jump to the existing window if possible
    vim.g.fzf_buffers_jump = 1
    -- find in files
    createMapping("n", "<leader>nF", ":GFiles<cr>")
    createMapping("n", "<leader>nf", ":Files<cr>")
    -- find a text in files
    createMapping("n", "<leader>nc", ":GGrep<cr>")
    createMapping("n", "<leader>nC", ":Ag<cr>")
    -- find a buffer
    createMapping("n", "<leader>nb", ":Buffers<cr>")
    -- find in files history
    createMapping("n", "<leader>nh", ":History<cr>")
end
