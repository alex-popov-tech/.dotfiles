return {

  -- needed for my custom lsp rename
  { "MunifTanjim/nui.nvim", event = "VeryLazy" },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown", -- If you decide to lazy-load anyway
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
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
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      hide_cursor = true,
      duration_multiplier = 0.75,
      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      stiffness = 0.7,
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim", lazy = true },
      { "rcarriga/nvim-notify", lazy = true },
      {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        lazy = true,
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
    },
    opts = {
      routes = {
        {
          view = "notify",
          filter = {
            event = "msg_showmode",
            any = {
              { find = "recording" },
            },
          },
        },
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
      lsp = {
        progress = {
          enabled = false,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      local macro_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
      vim.api.nvim_create_autocmd("RecordingLeave", {
        group = macro_group,
        callback = function()
          -- Display a message when macro recording stops
          print("Macro recording stopped")
        end,
      })
    end,
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local twilight = require("twilight")
      twilight.setup(opts)
      vim.api.nvim_create_autocmd("InsertLeave", {
        group = vim.api.nvim_create_augroup("UserTwilight", { clear = false }),
        callback = function(args)
          vim.cmd("TwilightDisable")
        end,
      })
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("UserTwilight", { clear = false }),
        callback = function(args)
          vim.cmd("TwilightEnable")
        end,
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        on_colors = function() end,
        on_highlights = function() end,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.opt.fillchars:append({
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┨",
        vertright = "┣",
        verthoriz = "╋",
      })
      require("kanagawa").setup({ transparent = true, globalStatus = true })
      -- load the colorscheme here
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- highlight text as color
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = { render = "virtual", enable_tailwind = true },
  },

  -- fancy notification messages
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")
      notify.setup({
        fps = 60,
        level = 2,
        render = "compact",
        stages = "fade",
        timeout = 5,
        top_down = false,
        background_colour = "#000000",
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      })
      vim.notify = notify
      -- table from lsp severity to vim severity.
      local severity = {
        "error",
        "warn",
        "info",
        "info", -- map both hint and info to info?
      }
      vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
        vim.notify(method.message, severity[params.type])
      end
    end,
  },
}
