-- plugin-dependent lsp setup. plugin-agnostic parts (vim.diagnostic.config,
-- vim.lsp.enable, LspAttach autocmd) live in lua/lsp.lua.
--
-- ordering notes:
--   1. lspconfig must be on rtp before any server starts (its lsp/*.lua
--      files are read at client-start time, not at setup time).
--   2. blink capabilities must be registered via vim.lsp.config('*', ...)
--      before any buffer triggers lsp auto-attach — this file runs
--      synchronously during plugin/ sourcing, before buffers load, so
--      it's always in time.
--   3. schemastore schemas are layered onto jsonls/yamlls the same way.
--   4. vim.lsp.config() calls just register defaults; actual merge happens
--      when a client starts, so declaration order here doesn't matter.


-- nvim-lspconfig -------------------------------------------------------------
-- provides lsp/*.lua defaults for every server we use. no setup needed;
-- neovim deep-merges them automatically with our own lsp/*.lua files.
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })


-- blink.cmp ------------------------------------------------------------------
-- completion engine. mini.icons is a visual dependency used by the kind
-- icon draw component. friendly-snippets provides default snippet sources.
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/nvim-mini/mini.icons",
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "select_and_accept", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  snippets = { preset = "luasnip" },
  completion = {
    list = { selection = { preselect = false, auto_insert = true } },
    menu = {
      border = "rounded",
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = require("mini.icons").get("lsp", ctx.kind)
              return icon
            end,
            highlight = function(ctx)
              local _, hl = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = { border = "single" },
    },
  },
  signature = { enabled = true, window = { border = "single" } },
  cmdline = { enabled = true, completion = { menu = { auto_show = false } } },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- broadcast blink capabilities to every lsp server (merged at client start)
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})


-- schemastore ----------------------------------------------------------------
-- layers json/yaml schemas onto jsonls and yamlls. our lsp/yamlls.lua
-- disables yamlls's built-in schemaStore so this one takes over.
vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})


-- mason ----------------------------------------------------------------------
-- binary installer for lsp servers, formatters, linters. setup is cheap
-- (no network). :MasonInstallAll does the actual installs on demand —
-- run once on a fresh machine.
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })

require("mason").setup()

vim.api.nvim_create_user_command("MasonInstallLsp", function()
  local packages = {
    "lua-language-server",
    "gopls",
    "css-lsp",
    "harper-ls",
    "json-lsp",
    "tailwindcss-language-server",
    "templ",
    "typescript-language-server",
    "yaml-language-server",
  }
  local registry = require("mason-registry")
  registry.refresh(function()
    for _, name in ipairs(packages) do
      if registry.has_package(name) and not registry.is_installed(name) then
        registry.get_package(name):install()
      end
    end
  end)
end, { desc = "Install LSP servers via mason" })


-- outline.nvim ---------------------------------------------------------------
-- symbol outline (depends on lsp). use with :Outline or :OutlineOpen.
vim.pack.add({ "https://github.com/hedyhli/outline.nvim" })
require("outline").setup({})


-- ts-error-translator --------------------------------------------------------
-- prettifies typescript compile errors in diagnostics.
vim.pack.add({ "https://github.com/dmmulroy/ts-error-translator.nvim" })
require("ts-error-translator").setup({})
