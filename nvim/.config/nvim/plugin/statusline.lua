-- lualine.nvim — statusline, winbar, tabline.
-- eager-loaded (no vim.schedule) because the statusline is visible from the
-- very first frame. deferring would cause a flash of unstyled status area.

-- mini.icons dependency: lualine expects nvim-web-devicons API.
-- mini.icons provides the same via mock. declared here so statusline is
-- self-contained regardless of plugin/mini.lua's load timing.
vim.pack.add({ "https://github.com/nvim-mini/mini.icons" })
require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons()

-- lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

require("lualine").setup({
  extensions = { "mason" },
  options = {
    theme = "nightfox",
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      { "filetype", icon_only = true },
      {
        "filename",
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
      },
    },
    lualine_c = {
      { "branch" },
    },
    lualine_x = {},
    lualine_y = { { "encoding" } },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {},
    lualine_b = {
      { "filetype", icon_only = true },
      { "filename" },
    },
    lualine_c = {
      { "location" },
      { "diagnostics" },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {
      { "filetype", icon_only = true },
      { "filename" },
    },
    lualine_c = {
      { "location" },
      { "diagnostics" },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
