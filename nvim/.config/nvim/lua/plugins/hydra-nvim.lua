return function()
    local Hydra = require('hydra')
    Hydra({
        name = 'Resizing mode',
        hint = [[
 ^^^^^^  Split/Pane  ^^^^^^
 ^^^^^^--------------^^^^^^
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^
 _h_ ^ ^ _l_   _H_ ^ ^ _L_
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^
 focus^^^^^^   resize^^^^^
 ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^
]],
        config = {
            invoke_on_body = true,
            hint = {position = 'bottom', border = 'rounded'},
            timeout = 4000
        },
        mode = 'n',
        body = '<leader>w',
        heads = {
            {'h', function() require('Navigator').left() end},
            {'j', function() require('Navigator').down() end},
            {'k', function() require('Navigator').up() end},
            {'l', function() require('Navigator').right() end},
            {'H', function() vim.cmd(':ObviousResizeLeft') end},
            {'J', function() vim.cmd(':ObviousResizeDown') end},
            {'K', function() vim.cmd(':ObviousResizeUp') end},
            {'L', function() vim.cmd(':ObviousResizeRight') end},
            {'<esc>', nil, exit = true}
        }
    })
end
