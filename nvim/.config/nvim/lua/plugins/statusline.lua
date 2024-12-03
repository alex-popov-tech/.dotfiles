local util = require("util")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufEnter *.*" },
    dependencies = {
      {
        "echasnovski/mini.icons",
        version = false,
        lazy = true,
        config = function()
          require("mini.icons").setup()
          MiniIcons.mock_nvim_web_devicons()
        end,
      },
    },
    opts = {
      extensions = { "mason", "lazy", "neo-tree", "toggleterm", "trouble" },
      options = {
        theme = "tokyonight",
        -- component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function()
              return MiniIcons.get("file", "init.lua")
            end,
          },
        },
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1,
            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          },
          { "branch" },
        },

        lualine_x = { { "encoding" }, "filetype" },
        lualine_y = {},
        lualine_z = { "fileformat" },
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
        lualine_b = {},
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
            separator = { right = "", left = "" },
            color = { bg = "none" },
          },
          {
            "filename",
            padding = { left = 0, right = 1 },
            separator = { right = "", left = "" },
            color = { bg = "none" },
          },
          {
            "location",
            padding = { left = 0, right = 1 },
            separator = { right = "", left = "" },
            color = { bg = "none" },
          },
          { "diagnostics", padding = 0, color = { bg = "none" } },
          { "Snacks.profiler.status()" },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "diagnostics", padding = 0, color = { bg = "none" } } },
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
    },
  },
}
