return function()
    require("Navigator").setup(
        {
            auto_save = "current",
            disable_on_zoom = false
        }
    )
    map("", "<c-h>", "<CMD>lua require('Navigator').left()<CR>")
    map("", "<c-j>", "<CMD>lua require('Navigator').down()<CR>")
    map("", "<c-k>", "<CMD>lua require('Navigator').up()<CR>")
    map("", "<c-l>", "<CMD>lua require('Navigator').right()<CR>")
end
