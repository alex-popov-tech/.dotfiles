local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  filetypes = { "typescriptreact", "javascriptreact", "html" },
  root_dir = function(fname)
    local lsputil = require("lspconfig/util")
    return lsputil.root_pattern(
      "tailwind.config.js",
      "tailwind.config.ts",
      "tailwind.config.cjs",
      "tailwind.js",
      "tailwind.ts",
      "tailwind.cjs"
    )(fname)
  end,
})
