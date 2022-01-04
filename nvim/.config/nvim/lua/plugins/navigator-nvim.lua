return function()
    require("Navigator").setup(
        {
            auto_save = "current",
            disable_on_zoom = false
        }
    )
    map("", "<c-h>", function() require('Navigator').left() end)
    map("", "<c-j>", function() require('Navigator').down() end)
    map("", "<c-k>", function() require('Navigator').up() end)
    map("", "<c-l>", function() require('Navigator').right() end)
end
