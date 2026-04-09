return {
  -- open terminal in floating window
  {
    "numToStr/FTerm.nvim",
    opts = {
      border = "rounded",
      dimensions = { height = 0.99, width = 0.99 },
    },
    init = function()
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
    keys = {
      {
        "<F11>",
        function()
          require("FTerm").toggle()
        end,
        mode = { "t", "n" },
      },
    },
  },

  -- global replace
  {
    "windwp/nvim-spectre",
    dependencies = { { "nvim-lua/plenary.nvim", lazy = true }, { "nvim-lua/popup.nvim", lazy = true } },
    cmd = "Replace",
    opts = {
      color_devicons = true,
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffDelete",
        replace = "DiffChange",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Replace", function()
        require("spectre").open()
      end, {})
    end,
  },

  -- screenkey logging
  {
    "NStefan002/screenkey.nvim",
    event = "VeryLazy",
    cmd = "Screenkey",
    version = "*",
    -- config = function()
    --   vim.cmd("Screenkey")
    -- end,
  },

  -- screen code snippets
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0-beta.17",
    cmd = { "Screen", "Take", "TakeScreen" },
    config = function()
      for _, name in ipairs({ "Screen", "Take", "TakeScreen" }) do
        vim.api.nvim_create_user_command(name, function()
          vim.cmd("CodeSnap")
        end, { nargs = "*", range = "%" })
      end
    end,
  },
  {
    "mistweaverco/snap.nvim",
    version = "v1.5.0",
    cmd = "Snap",
    ---@type SnapUserConfig
    opts = {
      save_to_disk = { image = false, html = false },
      copy_to_clipboard = { image = true, html = true },
    },
    event = "VeryLazy",
  },

  {
    -- dir = "/Users/alex/me/pet/store.nvim",
    -- name = "store.nvim",
    "alex-popov-tech/store.nvim",
    dependencies = {
      { "OXY2DEV/markview.nvim", opts = {} },
      { "3rd/image.nvim", opts = { integrations = { markdown = { enabled = false } } } },
    },
    -- opts = {},
    opts = {
      layout = "tab",
      proportions = { list = 0.6, preview = 0.4 },
      preview_debounce = 50,
    },
    cmd = { "Store" },
  },
  {
    -- "alex-popov-tech/stt-whisper.nvim",
    dir = "/Users/alex/me/pet/talk-to-me.nvim/",
    name = "stt-whisper.nvim",
    event = "VeryLazy",
    config = function()
      require("stt_whisper").setup()
    end,
  },
}
