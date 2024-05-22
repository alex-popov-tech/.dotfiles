local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
  root_dir = function(fname)
    local lsputil = require("lspconfig/util")
    return lsputil.root_pattern(
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json"
    )(fname)
  end,
})
