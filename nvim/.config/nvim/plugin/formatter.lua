-- conform.nvim — format on demand with <leader>f
local defer = require("defer")

defer.later(function()
  vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/williamboman/mason.nvim",
  })

  local formatters_by_ft = {
    go = { "gofumpt", "golines", "goimports-reviser" },
    templ = { "templ" },
    sql = { "sql_formatter" },
    lua = { "stylua" },
    yaml = { "yamlfmt" },
    json = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
  }

  require("conform").setup({
    formatters_by_ft = formatters_by_ft,
  })

  require("conform").formatters.sql_formatter = {
    prepend_args = { "-l", "postgresql" },
  }

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  vim.keymap.set("n", "<leader>f", function()
    require("conform").format()
  end, { desc = "Format buffer" })

  -- :MasonInstallFormatters — run once on fresh machines
  vim.api.nvim_create_user_command("MasonInstallFormatters", function()
    local tools = {
      "gofumpt",
      "golines",
      "goimports-reviser",
      "stylua",
      "yamlfmt",
      "prettierd",
      "sql-formatter",
    }
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(tools) do
        if registry.has_package(name) and not registry.is_installed(name) then
          registry.get_package(name):install()
        end
      end
    end)
  end, { desc = "Install formatters via mason" })
end)
