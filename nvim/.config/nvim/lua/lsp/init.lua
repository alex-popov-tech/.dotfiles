local util = require("util")
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
  callback = function(args)
    local clients = vim.lsp.get_clients()
    local client = util.t.find(function(it)
      return it.id == args.data.client_id
    end, clients)

    require("lsp.settings")(client)
    require("lsp.mappings")(client)
    require("lsp.ui")(client)
  end,
})
