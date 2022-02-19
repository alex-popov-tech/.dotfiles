return function()
    require('lightspeed').setup {
        ignore_case = true,
        jump_to_unique_chars = {safety_timeout = 400}
    }
    cmd('nmap s <Plug>Lightspeed_omni_s')
end
