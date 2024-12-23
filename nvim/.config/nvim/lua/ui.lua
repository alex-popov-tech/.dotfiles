function reset_bg_for_highlight(highlight_name)
  local existing_colors = vim.api.nvim_get_hl(0, { name = highlight_name })
  existing_colors.bg = nil
  vim.api.nvim_set_hl(0, highlight_name, existing_colors)
end

reset_bg_for_highlight("NormalFloat")
reset_bg_for_highlight("FloatBorder")
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none", fg = "#7E9CD8" })
reset_bg_for_highlight("FoldColumn")
reset_bg_for_highlight("LineNr")
reset_bg_for_highlight("SignColumn")
reset_bg_for_highlight("DiagnosticSignWarn")
reset_bg_for_highlight("DiagnosticVirtualTextError")
reset_bg_for_highlight("DiagnosticVirtualTextWarn")
reset_bg_for_highlight("DiagnosticVirtualTextInfo")
reset_bg_for_highlight("DiagnosticVirtualTextHint")
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#565f89", bg = "none" })
reset_bg_for_highlight("LspInlayHint")
reset_bg_for_highlight("helpCommand")
reset_bg_for_highlight("GitSignsChange")
reset_bg_for_highlight("GitSignsAdd")
reset_bg_for_highlight("GitSignsDelete")
-- for changed line in lazy update notification which annoy me
reset_bg_for_highlight("@markup.raw.markdown_inline")
-- vim.api.nvim_set_hl(0, 'CursorLineNr', {bg = 'none'})
