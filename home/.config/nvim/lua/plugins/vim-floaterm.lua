return function()
    g.floaterm_width = 0.9
    g.floaterm_height = 0.9
    map("n", "<F11>", ":FloatermToggle<cr>")
    map("t", "<F11>", "<c-\\><c-n>:FloatermToggle<cr>")
end
