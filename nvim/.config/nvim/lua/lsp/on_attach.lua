return function(client, bufnr)
  local options = { noremap = true, silent = true }

  map('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
  end, options)
  map('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
  map('n', '\'gr', function()
    require 'telescope.builtin'.lsp_references({
      layout_strategy = 'vertical',
      layout_settings = { width = 0.9, height = 0.9 }
    })
  end, options)
  map('n', '\'gd', function() vim.lsp.buf.definition() end, options)

  map('n', '\'rn', function() vim.lsp.buf.rename() end, options)

  map('n', '[d',
    function() vim.diagnostic.goto_prev({ float = { border = 'single' } }) end,
    options)
  map('n', ']d',
    function() vim.diagnostic.goto_next({ float = { border = 'single' } }) end,
    options)
  map('n', '\'gi', function() vim.lsp.buf.implementation() end, options)
  map('n', '\'a', '<cmd>CodeActionMenu<CR>', options)
  map('n', '\'d', function()
    vim.diagnostic.open_float(0, {
      scope = 'line',
      source = "if_many",
      border = 'rounded',
      focusable = false
    })
  end, options)
  map('n', '\'D', '<cmd>TroubleToggle<CR>', options)

  map('n', '<leader>f', function()
    if vim.bo.filetype == 'typescript' then
      require 'nvim-lsp-ts-utils'.organize_imports_sync()
    end
    vim.lsp.buf.format({ async = true })
  end, options)
end
