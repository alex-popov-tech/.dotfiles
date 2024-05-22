local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})
