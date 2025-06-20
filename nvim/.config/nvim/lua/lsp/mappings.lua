local Input = require("nui.input")
local event = require("nui.utils.autocmd").event
local options = { noremap = true, silent = true }

return function(client)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, options)
  vim.keymap.set("n", "'gd", vim.lsp.buf.definition, options)
  vim.keymap.set("n", "'rn", vim.lsp.buf.rename, options)

  vim.keymap.set("n", "'gr", function()
    require('fzf-lua').lsp_references()
    -- require("telescope.builtin").lsp_references({
    --   layout_strategy = "vertical",
    --   layout_settings = { width = 0.9, height = 0.9 },
    -- })
  end, options)

  vim.keymap.set("n", "'gi", function()
    if vim.bo.filetype == "go" then
      vim.lsp.buf.definition()
    else
      vim.lsp.buf.implementation()
    end
  end, options)

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ float = { border = "single" } })
  end, options)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ float = { border = "single" } })
  end, options)

  vim.keymap.set("n", "'d", function()
    vim.diagnostic.open_float({
      bufnr = 0,
      scope = "line",
      source = true,
      border = "rounded",
    })
  end, options)

  vim.keymap.set("n", "'D", function()
    vim.diagnostic.open_float({
      bufnr = 0,
      scope = "buffer",
      source = true,
      border = "rounded",
    })
  end, options)
end
