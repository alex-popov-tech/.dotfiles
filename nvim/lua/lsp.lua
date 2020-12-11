local lsp_config = require("lspconfig")
local lsp_completion = require("completion")
local lsp_status = require("lsp-status")
local general_on_attach = function(client, bufnr)
  lsp_completion.on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)

  local mappingOptions = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("i", "<tab>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", mappingOptions)
  vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'i", "<cmd>lua vim.lsp.buf.implementation()<CR>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'re", "<cmd>lua vim.lsp.buf.references()<CR>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'a", "<cmd>lua vim.lsp.buf.code_action()<CR>", mappingOptions)
  vim.api.nvim_set_keymap(
    "n",
    "[d",
    "<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { show_header = false } })<CR>",
    mappingOptions
  )
  vim.api.nvim_set_keymap(
    "n",
    "]d",
    "<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { show_header = false } })<CR>",
    mappingOptions
  )
  vim.api.nvim_set_keymap("n", "'d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", mappingOptions)

  -- vim.api.nvim_command('setlocal omnifunc=lua.vim.lsp.omnifunc')
  vim.api.nvim_command("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
  -- vim.api.nvim_command('autocmd BufWritePre *.ts,*.js lua vim.lsp.buf.formatting_sync({}, 5000)')
end

lsp_status.config {
  current_function = false,
  indicator_errors = "E:",
  indicator_warnings = "W:",
  indicator_info = "I:",
  indicator_hint = "H:",
  indicator_ok = "",
  status_symbol = ""
}
lsp_status.register_progress()

-- setup basic lsp servers
for _, server in pairs({"vimls", "jsonls", "bashls"}) do
  lsp_config[server].setup {
    capabilities = lsp_status.capabilities,
    on_attach = general_on_attach
  }
end
-- tsserver, stop messing with prettier da fuck!
lsp_config.tsserver.setup {
  capabilities = lsp_status.capabilities,
  on_attach = function(client, bufnr)
    general_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end
}

lsp_config.sumneko_lua.setup {
  on_attach = general_on_attach,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  settings = {
    Lua = {
      runtime = {version = "LuaJIT"},
      diagnostics = {globals = {"vim", "use"}},
      workspace = {
        library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true}
      }
    }
  }
}

-- setup errors ui
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = true
  }
)

local prettierFormatter = function()
  return {
    exe = "npx prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require "formatter".setup(
  {
    logging = true,
    filetype = {
      typescript = {prettierFormatter},
      javascript = {prettierFormatter},
      lua = {
        function()
          return {
            exe = "npx luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
-- setup diagnostic linters and formatters
lsp_config.diagnosticls.setup(
  {
    capabilities = lsp_status.capabilities,
    on_attach = general_on_attach,
    filetypes = {"javascript", "typescript"},
    init_options = {
      filetypes = {javascript = "eslint", typescript = "eslint"},
      linters = {
        eslint = {
          command = "./node_modules/.bin/eslint",
          rootPatterns = {".git"},
          debounce = 100,
          args = {
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json"
          },
          sourceName = "eslint",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
          },
          securities = {
            [2] = "error",
            [1] = "warning"
          }
        }
      }
    }
  }
)

-- define line number hl for lines with Lsp errors
vim.fn.sign_define("LspDiagnosticsSignError", {numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {numhl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {numhl = "LspDiagnosticsSignHint"})
-- when following something from loclist close it
vim.api.nvim_command("autocmd BufWinEnter quickfix nnoremap <silent> <buffer> <enter> <enter>:lclose<cr>")
