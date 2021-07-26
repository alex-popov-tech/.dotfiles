return function()
    g.floaterm_width = 0.99
    g.floaterm_height = 0.99
    g.floaterm_title = ""
    map("n", "<F11>", ":FloatermToggle<cr>")
    map("t", "<F11>", "<c-\\><c-n>:FloatermToggle<cr>")
    hi("FloatermBorder", {guibg = "none", guifg = "none"})
end
