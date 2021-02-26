return function()
    cmd("cnoreabbrev gp Git push")
    cmd("command Gs :Git | on")
    cmd("cnoreabbrev gs Gs")
    map("n", "gm", ":diffget //2<cr>")
    map("n", "gt", ":diffget //3<cr>")
end
