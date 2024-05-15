local util = require("util")

return {
  "feline-nvim/feline.nvim",
  branch = "master",
  dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
  event = { "BufEnter *.*" },
  config = function()
    require("gitsigns").setup()
    local feline = require("feline")
    local colors = {
      bg = "none",
      default_fg = "#C8C093",
      red = "#C34043",
      git_red = "#C34043",
      git_yellow = "#DCA561",
      git_green = "#76946A",
      diagnostic_error = "#E82424",
      diagnostic_warn = "#FF9E3B",
      diagnostic_info = "#6A9589",
      light_blue = "#7E9CD8",
      light_purple = "#957FB8",
    }

    local is_ignored_filetype = function()
      return not util.t.includes({ "prompt" }, vim.bo.filetype)
    end

    local component = function(comp)
      return util.t.merge("force", {
        hl = { bg = colors.bg },
        enabled = is_ignored_filetype,
      }, comp)
    end
    local space = component({ provider = " ", hl = { bg = colors.bg } })

    local git_branch = require("feline.providers.git").git_info_exists()

    feline.setup({
      force_inactive = {
        filetypes = {
          "^NvimTree$",
          "^packer$",
          "^startify$",
          "^fugitive$",
          "^fugitiveblame$",
          "^qf$",
          "^help$",
        },
        buftypes = { "^terminal$", "prompt" },
        bufnames = {},
      },
      components = {
        active = {
          {
            space,
            component({
              provider = {
                name = "file_info",
                opts = {
                  type = "relative",
                  colored_icon = true,
                  file_modified_icon = "",
                },
              },
              hl = { fg = colors.default_fg, style = "italic" },
              short_provider = {
                name = "file_info",
                opts = { type = "base_only" },
              },
            }),
            component({
              truncate_hide = true,
              provider = " on ",
              enabled = function()
                return git_branch
              end,
              hl = { fg = colors.light_blue },
            }),
            component({
              truncate_hide = true,
              enabled = function()
                return git_branch
              end,
              provider = function()
                return "" .. " " .. git_branch
              end,
              hl = { fg = colors.git_red, style = "italic" },
            }),
          },
          {
            component({
              truncate_hide = true,
              provider = "lsp_client_names",
              hl = { fg = colors.light_blue, style = "italic" },
            }),
            space,
          },
        },
        inactive = {},
      },
    })

    local navic = require("nvim-navic")
    local winbarComponents = {
      space,
      component({
        truncate_hide = true,
        provider = function(c)
          return require("feline.providers.file").file_info(c, {
            type = "unique",
            colored_icon = true,
            file_modified_icon = "",
          })
        end,
        hl = { fg = colors.default_fg, style = "italic" },
        short_provider = function(c)
          return require("feline.providers.file").file_info(c, {
            type = "base-only",
            colored_icon = true,
            file_modified_icon = "",
          })
        end,
      }),
      space,
      component({
        provider = "position",
        hl = { fg = colors.light_blue, gui = "italic" },
      }),
      space,
      component({
        truncate_hide = true,
        provider = function()
          return navic.get_location()
        end,
        enabled = function()
          return navic.is_available()
        end,
      }),
      component({
        truncate_hide = true,
        provider = "git_diff_added",
        enabled = function()
          return require("feline.providers.git").git_info_exists()
        end,
        hl = { fg = colors.git_green },
      }),
      component({
        truncate_hide = true,
        provider = "git_diff_changed",
        enabled = function()
          return require("feline.providers.git").git_info_exists()
        end,
        hl = { fg = colors.git_yellow },
      }),
      component({
        truncate_hide = true,
        provider = "git_diff_removed",
        enabled = function()
          require("feline.providers.git").git_info_exists()
        end,
        hl = { fg = colors.git_red },
      }),
      component({
        truncate_hide = true,
        provider = "diagnostic_errors",
        enabled = function()
          return require("feline.providers.lsp").diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,
        hl = { fg = colors.diagnostic_error, gui = "italic" },
      }),
      component({
        truncate_hide = true,
        provider = "diagnostic_warnings",
        enabled = function()
          return require("feline.providers.lsp").diagnostics_exist(vim.diagnostic.severity.WARN)
        end,
        hl = { fg = colors.diagnostic_warn, gui = "italic" },
      }),
    }
    feline.winbar.setup({
      components = {
        active = { winbarComponents },
        inactive = { winbarComponents },
      },
    })
  end,
}
