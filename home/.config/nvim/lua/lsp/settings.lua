return function()
    -- define line number hl for lines with Lsp errors
    vim.fn.sign_define("LspDiagnosticsSignError", {numhl = "LspDiagnosticsSignError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {numhl = "LspDiagnosticsSignWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {numhl = "LspDiagnosticsSignInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint", {numhl = "LspDiagnosticsSignHint"})
end
