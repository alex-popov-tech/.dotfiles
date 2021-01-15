return function()
    -- previews for fuzzy search
    cmd(
        "command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview('up'), <bang>0)"
    )
    cmd(
        "command! -bang -nargs=? -complete=dir GFiles call fzf#gitfiles(<q-args>, fzf#vim#with_preview('up'), <bang>0)"
    )
    -- search for content occurrences only, not file names
    cmd(
        "command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up'), <bang>0)"
    )
    -- search for content occurrences in only git files
    cmd(
        "command! -bang -nargs=* GGrep call fzf#grep('git grep --line-number '.shellescape(<q-args>), 0, fzf#vim#with_preview('up'),<bang>0)"
    )
    -- respect color scheme
    g.fzf_colors = {
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
    g.fzf_layout = {window = {width = 0.9, height = 0.7}}
    -- define actions
    g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "split",
        ["ctrl-v"] = "vsplit"
    }
    -- [Buffers] Jump to the existing window if possible
    g.fzf_buffers_jump = 1
    -- find in files
    map("n", "<leader>nF", ":GFiles<cr>")
    map("n", "<leader>nf", ":Files<cr>")
    -- find a text in files
    map("n", "<leader>nc", ":GGrep<cr>")
    map("n", "<leader>nC", ":Ag<cr>")
    -- find a buffer
    map("n", "<leader>nb", ":Buffers<cr>")
    -- find in files history
    map("n", "<leader>nh", ":History<cr>")
end
