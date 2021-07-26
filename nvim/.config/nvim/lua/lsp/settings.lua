return function()
    -- define line number hl for lines with Lsp errors
    vim.fn.sign_define("LspDiagnosticsSignError", {numhl = "LspDiagnosticsSignError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {numhl = "LspDiagnosticsSignWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {numhl = "LspDiagnosticsSignInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint", {numhl = "LspDiagnosticsSignHint"})
    require "vim.lsp.protocol".CompletionItemKind = {
      "ﮜ [text]",
      " [method]",
      " [function]",
      " [constructor]",
      "ﰠ [field]",
      " [variable]",
      " [class]",
      " [interface]",
      " [module]",
      " [property]",
      " [unit]",
      " [value]",
      " [enum]",
      " [key]",
      " [snippet]",
      " [color]",
      " [file]",
      " [reference]",
      " [folder]",
      " [enum member]",
      " [constant]",
      " [struct]",
      "⌘ [event]",
      " [operator]",
      "⌂ [type]"
    }
end
