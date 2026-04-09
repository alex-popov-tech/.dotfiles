local util = require("util")
local common = require("lsp.common")

return util.t.merge("force", common, {
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = true,
        generate = true,
        run_govulncheck = true,
        test = false,
        tidy = true,
        upgrade_dependency = true,
      },
      hints = {
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        assignVariableTypes = true,
        rangeVariableTypes = true,
        ignoredError = true,
      },
      analyses = {
        nilness = true,
        assign = true,
        atomic = true,
        composites = true,
        copylocks = true,
        defers = true,
        deprecated = true,
        fillreturns = true,
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      semanticTokens = false,
      usePlaceholders = true,
    },
  },
})
