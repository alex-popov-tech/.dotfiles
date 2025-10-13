local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  filetypes = {
    "astro",
    "html",
    "javascriptreact",
    "pug",
    "svelte",
    "typescriptreact",
    "vue",
    "templ",
  },
})
