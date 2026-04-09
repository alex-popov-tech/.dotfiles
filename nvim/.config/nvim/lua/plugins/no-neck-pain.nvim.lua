-- Plugin: shortcuts/no-neck-pain.nvim
-- Installed via store.nvim

return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  cmd = "NoNeckPain",
  config = function()
    require("lazy").setup({ "shortcuts/no-neck-pain.nvim" })
  end,
}
