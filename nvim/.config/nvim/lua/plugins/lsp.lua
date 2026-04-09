local util = require("util")
local lsp_servers = {
  "lua_ls",
  "cssls",
  "gopls",
  "harper_ls",
  "jsonls",
  "templ",
  "ts_ls",
  "yamlls",
  "gleam",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      util.install_mason_packages(lsp_servers)
      for _, lsp in ipairs(lsp_servers) do
        local isOk, conf = pcall(require, "lsp." .. lsp)
        if not isOk then
          print("Failed to load lsp." .. lsp .. " config, ignoring this one")
        end
        vim.lsp.config(lsp, conf)
        vim.lsp.enable(lsp)
      end
    end,
  },
  { "dmmulroy/ts-error-translator.nvim" },

  {
    "saghen/blink.cmp",
    dependencies = { "neovim/nvim-lspconfig" },
    version = "*",
    event = { "VeryLazy", "InsertEnter" },
    opts = {
      keymap = {
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
        providers = {},
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "single",
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = "single" } },
      },
      snippets = { preset = "luasnip" },
      signature = { enabled = true, window = { border = "single" } },
      cmdline = { enabled = true, completion = { menu = { auto_show = false } } },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      for _, lsp in ipairs(lsp_servers) do
        vim.lsp.config(lsp, { capabilities = capabilities })
      end
    end,
  },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {},
  },
}
