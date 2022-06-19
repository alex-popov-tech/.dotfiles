return function()
    local augend = require('dial.augend')
    require('dial.config').augends:register_group{
        -- default augends used when no group name is specified
        default = {
            augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
            augend.constant.alias.bool, -- boolean value (true <-> false)
            augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
            augend.constant.new {
                elements = {'and', 'or'},
                word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                cyclic = true -- "or" is incremented into "and".
            },
            augend.constant.new {
                elements = {'const', 'let'},
                word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                cyclic = true -- "or" is incremented into "and".
            },
            augend.constant.new {
                elements = {'&&', '||'},
                word = false,
                cyclic = true
            }
        }
    }
    map('n', '<C-a>', require('dial.map').inc_normal(), {noremap = true})
    map('n', '<C-x>', require('dial.map').dec_normal(), {noremap = true})
    map('v', '<C-a>', require('dial.map').inc_visual(), {noremap = true})
    map('v', '<C-x>', require('dial.map').dec_visual(), {noremap = true})
    map('v', 'g<C-a>', require('dial.map').inc_gvisual(), {noremap = true})
    map('v', 'g<C-x>', require('dial.map').dec_gvisual(), {noremap = true})

end
