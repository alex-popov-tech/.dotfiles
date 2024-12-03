return {
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = function()
      -- Toggle the profiler
      Snacks.toggle.profiler():map("<leader>pp")
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map("<leader>ph")
    end,
    keys = {
      {
        "<leader>ps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch Bufer",
      },
    },
  },

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
    cmd = "Screenkey",
    version = "*",
    config = true,
  },

  -- screen code snippets
  {
    "mistricky/codesnap.nvim",
    cmd = { "Screen", "Take", "TakeScreen" },
    build = "make",
    config = function()
      local codesnap = require("codesnap")
      for _, name in ipairs({ "Screen", "Take", "TakeScreen" }) do
        vim.api.nvim_create_user_command(name, function()
          codesnap.copy_into_clipboard()
        end, { nargs = "*", range = "%" })
      end
    end,
  },
}
