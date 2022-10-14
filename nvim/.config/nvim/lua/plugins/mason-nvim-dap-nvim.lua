return function()
  require("mason-nvim-dap").setup({
    ensure_installed = { "delve" }
  })
end
