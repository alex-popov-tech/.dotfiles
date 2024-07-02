return {

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
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
    cmd = "Twilight",
    opts = {},
  },

  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
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
