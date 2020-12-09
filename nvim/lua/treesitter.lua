require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true
  },
}
-- disable hl for brackets to allow use of rainbow
require('nvim-treesitter.highlight')
vim.treesitter.highlighter.hl_map["punctuation.delimiter"] = "Delimiter"
vim.treesitter.highlighter.hl_map["punctuation.bracket"] = nil
