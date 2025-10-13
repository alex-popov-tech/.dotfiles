local util = require("util")
local common = require("lsp.common")

return util.t.merge("force", common, {
  settings = {
    Lua = {
      hint = { enable = true },
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
    },
  },
})
