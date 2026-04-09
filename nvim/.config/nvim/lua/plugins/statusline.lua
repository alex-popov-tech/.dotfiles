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
        theme = "nightfox",
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          { "filetype", icon_only = true },
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1,
            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
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
    },
  },
}
