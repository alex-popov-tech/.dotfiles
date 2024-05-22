return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "'D", "<cmd>TroubleToggle<cr>" },
    },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true,
      mode = "document_diagnostics",
    },
  },

  {
    "aznhe21/actions-preview.nvim",
    opts = {},
    keys = {
      {
        "'a",
        function()
          require("actions-preview").code_actions()
        end,
        mode = { "n" },
      },
    },
  },

  -- lint setup
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in pairs({ "actionlint", "yamllint", "proselint", "textlint" }) do
          local package = registry.get_package(name)
          if not registry.is_installed(name) then
            package:install()
          else
            package:check_new_version(function(success, result_or_err)
              if success then
                package:install({ version = result_or_err.latest_version })
              end
            end)
          end
        end
      end)
      local null_ls = require("null-ls")
      local diagnostics = null_ls.builtins.diagnostics
      null_ls.setup({
        debounce = 150,
        update_in_insert = false,
        sources = {
          diagnostics.actionlint,
          diagnostics.proselint,
          diagnostics.textlint,
          diagnostics.yamllint,
        },
      })
    end,
  },

  -- lsp setup
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", { "folke/neodev.nvim", opts = {} } },
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in pairs({ "sqlfluff" }) do
          local package = registry.get_package(name)
          if not registry.is_installed(name) then
            package:install()
          else
            package:check_new_version(function(success, result_or_err)
              if success then
                package:install({ version = result_or_err.latest_version })
              end
            end)
          end
        end
      end)
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "tsserver",
          "cssls",
          "jsonls",
          "yamlls",
          "tailwindcss",
          "emmet_ls",
          "prismals",
        },
        automatic_installation = true,
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = require("lsp.servers." .. server_name)
          opts.flags = {
            debounce_text_changes = 100,
            lintDebounce = 200,
          }
          opts.capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()
          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
}
