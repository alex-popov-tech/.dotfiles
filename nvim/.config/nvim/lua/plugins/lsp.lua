local util = require("util")

return {

  -- current lsp path in winbar
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
        callback = function(args)
          -- local client = vim.lsp.get_client_by_id(args.data.client_id)
          local clients = vim.lsp.get_clients()
          local client = util.t.find(function(it)
            return it.id == args.data.client_id
          end, clients)
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "'D", "<cmd>Trouble diagnostics toggle focus=true win.type=float<cr>" },
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
        for _, name in pairs({ "actionlint", "yamllint" }) do
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
          diagnostics.yamllint,
        },
      })
    end,
  },

  -- lsp setup
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
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
          "astro",
          "lua_ls",
          "eslint",
          "tsserver",
          "cssls",
          "jsonls",
          "yamlls",
          "tailwindcss",
          "emmet_ls",
          "prismals",
          "typos_lsp",
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
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    },
    opts = {
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        "luvit-meta/library", -- see below
      },
    },
  },
}
