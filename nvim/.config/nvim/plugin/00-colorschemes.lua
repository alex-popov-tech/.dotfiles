-- nightfox --------------------------------------------------------------
-- active colorscheme. ordering matters: this file has a numeric prefix so
-- it sources before any other plugin/ file and fires the ColorScheme event
-- early (lua/lsp.lua has a ColorScheme autocmd that depends on this).
vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })

require("nightfox").setup({
  options = {
    transparent = false,
    terminal_colors = true,
  },
})

vim.cmd.colorscheme("nightfox")


-- disabled colorschemes (kept as reference) ------------------------------
-- to try one: uncomment its block and comment out the nightfox section above.

-- vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
-- require("tokyonight").setup({
--   style = "night",
--   transparent = true,
--   styles = { sidebars = "transparent", floats = "transparent" },
-- })
-- vim.cmd.colorscheme("tokyonight")

-- vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })
-- require("kanagawa").setup({ transparent = true, globalStatus = true })
-- vim.cmd.colorscheme("kanagawa")

-- vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
-- require("gruvbox").setup({
--   contrast = "hard",
--   transparent_mode = true,
--   italic = { strings = true, comments = true, folds = true },
-- })
-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd("hi WinSeparator guifg=#d3869b")

-- vim.pack.add({ "https://github.com/sainnhe/gruvbox-material" })
-- vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_enable_italic = true
-- vim.cmd.colorscheme("gruvbox-material")
