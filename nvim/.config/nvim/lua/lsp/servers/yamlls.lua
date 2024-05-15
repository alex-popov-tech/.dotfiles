local util = require('util')
local common = require('lsp.servers.common')
return function(on_attach)
    return util.t.merge('force', common, {
        on_attach = on_attach,
        settings = {
            yaml = {
                schemaStore = {
                    enable = true,
                    -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                    url = ''
                },
                schemas = require('schemastore').yaml.schemas()
            }
        }
    })
end
