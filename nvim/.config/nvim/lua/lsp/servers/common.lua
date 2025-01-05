return {
  flags = { debounce_text_changes = 100, lintDebounce = 200 },
  capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
