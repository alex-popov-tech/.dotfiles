local M = {}

M.list = {
  'eslint_d',
  'prettierd',
  'cspell',
  'proselint',
  'yamllint',
  'golangci-lint',
  'goimports',
}

M.setup = function()
  local general_on_attach = require('lsp.on_attach')
  local null_ls = require('null-ls')
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local code_actions = null_ls.builtins.code_actions

  null_ls.setup({
    sources = {
      formatting.prettierd,
      formatting.fixjson,
      formatting.gofmt,
      formatting.goimports,

      diagnostics.eslint_d.with({ timeout = 10000 }),
      diagnostics.yamllint,
      diagnostics.markdownlint,
      diagnostics.proselint.with({ extra_filetypes = { 'markdown', 'octo' } }),
      diagnostics.cspell.with({
        extra_filetypes = { 'octo' },
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity['WARN']
        end
      }),
      diagnostics.golangci_lint,

      code_actions.eslint_d,
    },
    on_attach = general_on_attach
  })
end

return M
