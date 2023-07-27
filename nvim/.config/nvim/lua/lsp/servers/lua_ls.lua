local util = require('util')
local common = require('lsp.servers.common')
return function(on_attach)
    return util.t.merge('force', common, {
        on_attach = on_attach,
        settings = {
            Lua = {
                hint = {enable = true},
                workspace = {checkThirdParty = false},
                completion = {callSnippet = 'Replace'}
            }
        }
    })
end
