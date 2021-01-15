return function()
    -- Write all buffers before navigating from Vim to tmux pane
    g.tmux_navigator_save_on_switch = 2
    g.tmux_navigator_no_mappings = 1
    map("", "<c-h>", ":TmuxNavigateLeft<cr>")
    map("", "<c-j>", ":TmuxNavigateDown<cr>")
    map("", "<c-k>", ":TmuxNavigateUp<cr>")
    map("", "<c-l>", ":TmuxNavigateRight<cr>")
end
