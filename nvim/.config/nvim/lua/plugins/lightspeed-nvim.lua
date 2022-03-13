return function()
    require('lightspeed').setup {
        ignore_case = true,
        jump_to_unique_chars = {safety_timeout = 400}
    }
end
