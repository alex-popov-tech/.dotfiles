return function(config, on_attach)
    config.terraform.setup {
        on_attach = on_attach
    }
end
