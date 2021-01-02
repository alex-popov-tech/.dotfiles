return function()
    require "nvim-treesitter.configs".setup {
        ensure_installed = "all",
        highlight = {
            enable = true, -- false will disable the whole extension
            indent = {
                enable = true
            },
            use_languagetree = true
        }
    }
end
