-- highlight overrides — strip backgrounds that look wrong with transparent
-- terminals or winblend. re-applied on every colorscheme change.

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local groups = {
      "NormalFloat",
      "FloatBorder",
      "LspInlayHint",
      "DiagnosticVirtualTextError",
      "DiagnosticVirtualTextWarn",
      "DiagnosticVirtualTextInfo",
      "DiagnosticVirtualTextHint",
    }
    for _, name in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = name })
      hl.bg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end,
})
