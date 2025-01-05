return {
  -- lsp setup
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { { "williamboman/mason.nvim", lazy = true }, { "neovim/nvim-lspconfig", lazy = true } },
    config = function()
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "astro",
          "lua_ls",
          "ts_ls",
          "gopls",
          "templ",
          "cssls",
          "jsonls",
          "yamlls",
          "tailwindcss",
          "emmet_language_server",
        },
        automatic_installation = true,
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          local ok, opts = pcall(require, "lsp.servers." .. server_name)
          if not ok then
            opts = require("lsp.servers.common")
          end
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
