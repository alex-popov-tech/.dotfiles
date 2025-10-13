return {
  flags = { debounce_text_changes = 100, lintDebounce = 200 },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}
