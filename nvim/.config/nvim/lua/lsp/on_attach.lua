local navic = require("nvim-navic")
return function(client, bufnr)
  local options = { noremap = true, silent = true }

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- vim.api.nvim_create_augroup('lsp_augroup', {clear = true})
  --
  -- vim.api.nvim_create_autocmd('InsertEnter', {
  --     buffer = bufnr,
  --     callback = function() vim.lsp.buf.inlay_hint(bufnr, true) end,
  --     group = 'lsp_augroup'
  -- })
  -- vim.api.nvim_create_autocmd('InsertLeave', {
  --     buffer = bufnr,
  --     callback = function() vim.lsp.buf.inlay_hint(bufnr, false) end,
  --     group = 'lsp_augroup'
  -- })

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, options)

  vim.keymap.set("i", "<c-k>", function()
    vim.lsp.buf.signature_help()
  end, options)

  vim.keymap.set("n", "'gr", function()
    require("telescope.builtin").lsp_references({
      layout_strategy = "vertical",
      layout_settings = { width = 0.9, height = 0.9 },
    })
  end, options)

  vim.keymap.set("n", "'gi", function()
    if vim.bo.filetype == "go" then
      vim.lsp.buf.definition()
    else
      vim.lsp.buf.implementation()
    end
  end, options)
  vim.keymap.set("n", "'gd", function()
    vim.lsp.buf.definition()
  end, options)

  vim.keymap.set("n", "'rn", function()
    vim.lsp.buf.rename()
  end, options)

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ float = { border = "single" } })
  end, options)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ float = { border = "single" } })
  end, options)

  vim.keymap.set("n", "'d", function()
    vim.diagnostic.open_float(0, {
      scope = "line",
      source = "if_many",
      border = "rounded",
      focusable = false,
    })
  end, options)

  -- vim.keymap.set('n', '<leader>f', function()
  --     vim.lsp.buf.format({
  --         async = false,
  --         filter = function(client)
  --             return client.name == 'null-ls'
  --             -- return client.name == 'null-ls' or client.name == 'eslint'
  --         end
  --     })
  -- end, options)
end
