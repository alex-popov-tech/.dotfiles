return function()
    cmd("cnoreabbrev gp Git push")
    cmd("cnoreabbrev gpf Git push --force")
    cmd("command! Gs :Git | on")
    cmd("cnoreabbrev gs Gs")
    map("n", "gl", ":diffget //2<cr>")
    map("n", "gr", ":diffget //3<cr>")
end
