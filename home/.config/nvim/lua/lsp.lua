local lsp_config = require("lspconfig")
local lsp_completion = require("completion")
local general_on_attach = function(client, bufnr)
  if client.resolved_capabilities.completion then
    lsp_completion.on_attach(client, bufnr)
  -- map("i", "<c-n>", "<Plug>(completion_trigger)", false)
  -- map("i", "<c-j>", "<Plug>(completion_next_source)", false)
  -- map("i", "<c-k>", "<Plug>(completion_prev_source)", false)
  end
  local mappingOptions = {noremap = true, silent = true}
  if client.resolved_capabilities.hover then
    vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mappingOptions)
  end
  if client.resolved_capabilities.find_references then
    vim.api.nvim_set_keymap("n", "'re", "<cmd>lua vim.lsp.buf.references()<CR>", mappingOptions)
  end
  if client.resolved_capabilities.rename then
    vim.api.nvim_set_keymap("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mappingOptions)
  end
  vim.api.nvim_set_keymap("i", "<tab>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'i", "<cmd>Implementations<CR>", mappingOptions)
  vim.api.nvim_set_keymap("n", "'a", "<cmd>CodeActions<cr>", mappingOptions)
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
  vim.api.nvim_set_keymap("n", "'d", "<cmd>Diagnostics<CR>", mappingOptions)

  vim.api.nvim_command("setlocal omnifunc=lua.vim.lsp.omnifunc")
  vim.api.nvim_command("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
end

-- setup basic lsp servers
for _, server in pairs({"vimls", "jsonls", "bashls"}) do
  lsp_config[server].setup {
    on_attach = general_on_attach
  }
end

-- tsserver, stop messing with prettier da fuck!
lsp_config.tsserver.setup {
  on_attach = function(client, bufnr)
    general_on_attach(client, bufnr)
    -- client.resolved_capabilities.document_formatting = false
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
    underline = true,
    virtual_text = {
      prefix = "<"
    },
    signs = true,
    update_in_insert = true
  }
)

-- write only if diffs there
vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd [[noautocmd :update]]
        end
    end
end


-- define line number hl for lines with Lsp errors
vim.fn.sign_define("LspDiagnosticsSignError", {numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {numhl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {numhl = "LspDiagnosticsSignHint"})



lsp_config.efm.setup {
  default_config = {
    cmd = {
      "efm-langserver",
      "-c",
      [["$HOME/.config/efm-langserver/config.yaml"]]
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "lua"
  }
}
