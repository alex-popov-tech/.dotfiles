return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = { "n" },
    },
  },
  opts = {
    formatters_by_ft = {
      sql = { "sqlfmt" },
      lua = { "stylua" },
      yaml = { "yamlfmt" },
      json = { "prettierd" },
      css = { "prettierd" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    require("mason").setup()
    local tools = { "stylua", "prettierd", "yamlfmt", "sqlfmt" }
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in pairs(tools) do
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
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
