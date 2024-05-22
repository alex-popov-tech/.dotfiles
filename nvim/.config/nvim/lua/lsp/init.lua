vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp.settings")(client)
    require("lsp.mappings")(client)
    require("lsp.ui")(client)
  end,
})
