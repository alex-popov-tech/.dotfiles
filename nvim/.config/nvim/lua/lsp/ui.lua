return function(client)
  -- define line number hl for lines with Lsp errors
  local define_sign = function(name)
    vim.fn.sign_define(name, { text = "", texthl = "", linehl = "", numhl = name })
  end

  define_sign("DiagnosticSignError")
  define_sign("DiagnosticSignWarn")
  define_sign("DiagnosticSignHint")
  define_sign("DiagnosticSignInfo")

  -- set colors with delay to apply after lazy nvim loading theme
  function reset_bg_for_highlight(highlight_name)
    local existing_colors = vim.api.nvim_get_hl(0, { name = highlight_name })
    existing_colors.bg = nil
    vim.api.nvim_set_hl(0, highlight_name, existing_colors)
  end

  vim.defer_fn(function()
    reset_bg_for_highlight("DiagnosticSignError")
    reset_bg_for_highlight("DiagnosticSignWarn")
    reset_bg_for_highlight("DiagnosticSignHint")
    reset_bg_for_highlight("DiagnosticSignInfo")
  end, 100)

  -- set global diagnostic config
  vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = { prefix = "<" },
    severity_sort = true,
  })
end
