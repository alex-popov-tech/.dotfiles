-- plugin-agnostic lsp configuration.
-- plugin-dependent parts (vim.pack.add, blink, schemastore, mason) live in
-- plugin/lsp.lua.


-- diagnostics ----------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = { prefix = "<- " },
  virtual_lines = false,
  severity_sort = true,
  signs = {
    -- no glyph in signcolumn, color moves to the line number instead
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

-- strip backgrounds from diagnostic sign highlights so numhl colors only
-- the digits, not a full block. runs on every colorscheme change, plus
-- once immediately in case a colorscheme is already loaded.
local function strip_diagnostic_bg()
  for _, name in ipairs({
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignHint",
    "DiagnosticSignInfo",
  }) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    hl.bg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = strip_diagnostic_bg })
strip_diagnostic_bg()


-- global lsp features --------------------------------------------------------
vim.lsp.inline_completion.enable()


-- global diagnostic keymaps (work without any lsp client) --------------------
local mapopts = { noremap = true, silent = true }

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = { border = "single" } })
end, mapopts)

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = { border = "single" } })
end, mapopts)

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = "line",
    source = true,
    border = "rounded",
  })
end, mapopts)

vim.keymap.set("n", "<leader>D", function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = "buffer",
    source = true,
    border = "rounded",
  })
end, mapopts)


-- enable all servers declared in ~/.config/nvim/lsp/ -------------------------
-- single source of truth: drop a file in lsp/, get a restart, it's enabled.
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local servers = {}
for name, ftype in vim.fs.dir(lsp_dir) do
  if ftype == "file" and name:match("%.lua$") then
    table.insert(servers, (name:gsub("%.lua$", "")))
  end
end
vim.lsp.enable(servers)


-- per-client behavior + buffer-local lsp keymaps -----------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufopts = { buffer = args.buf, silent = true }

    -- client-specific tweaks
    if client.name == "gopls" then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
    if client.name == "ts_ls" then
      -- let prettier handle formatting for ts/js
      client.server_capabilities.documentFormattingProvider = false
    end

    -- info
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)

    -- navigation (<leader>g*)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>gs", vim.lsp.buf.document_symbol, bufopts)

    -- refactor
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  end,
})
