return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = { "t", "n" },
    },
  },
  opts = {
    formatters_by_ft = {
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
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in pairs({ "stylua", "prettierd", "yamlfmt" }) do
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
  end,
}
