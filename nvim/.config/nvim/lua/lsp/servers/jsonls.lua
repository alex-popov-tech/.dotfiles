return function(on_attach)
    return {
        on_attach = on_attach,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas()
            }
        }
    }
end
