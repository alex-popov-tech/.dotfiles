return function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     '
    }
    dashboard.section.buttons.val = {
        dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('s', 'P  > Plugins - Sync', ':PackerSync<CR>'),
        dashboard.button('c', 'P  > Plugins - Cleanup', ':PackerClean<CR>'),
        dashboard.button('i', 'P  > Plugins - Install', ':PackerInstall<CR>'),
        dashboard.button('q', '  > Quit NVIM', ':qa<CR>')
    }
    dashboard.section.footer.val = require('alpha.fortune')()

    alpha.setup(dashboard.opts)
end
