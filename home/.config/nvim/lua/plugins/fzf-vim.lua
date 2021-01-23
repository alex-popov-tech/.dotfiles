return function()
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
    map("n", "gf", ":GFiles<cr>")
    map("n", "gF", ":Files<cr>")
    map("n", "gC", ":Rg<cr>")
end
