local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = true,
        generate = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
      },
      hints = {
        compositeLiteralTypes = true,
        functionTypeParameters = true,
        parameterNames = true,
        assignVariableTypes = false,
        constantValues = false,
        rangeVariableTypes = false,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      semanticTokens = true,
    },
  },
})
