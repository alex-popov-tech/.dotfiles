return function()
    g.obvious_resize_default = 4
    g.obvious_resize_run_tmux = 1
    map("", "<c-up>", ":ObviousResizeUp<cr>")
    map("", "<c-down>", ":ObviousResizeDown<cr>")
    map("", "<c-left>", ":ObviousResizeLeft<cr>")
    map("", "<c-right>", ":ObviousResizeRight<cr>")
end
