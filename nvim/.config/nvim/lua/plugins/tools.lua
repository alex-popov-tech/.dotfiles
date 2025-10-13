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
  {
    -- dir = "/Users/alex/me/pet/store.nvim",
    -- name = "store.nvim",
    "alex-popov-tech/store.nvim",
    dependencies = { "OXY2DEV/markview.nvim" },
    -- opts = {},
    opts = {
      logging = "off",
      width = 0.95,
      height = 0.95,
      proportions = { list = 0.5, preview = 0.5 },
      preview_debounce = 50,
      -- plugin_manager = "lazy.nvim",
      repository_renderer = function(repo, isInstalled) -- Function to render repository data for list display
        return {
          {
            content = "⭐" .. repo.pretty.stars,
            limit = 10,
          },
          {
            content = repo.full_name,
            limit = 30,
          },
          {
            content = repo.pretty.updated_at,
            limit = 25,
          },
          {
            content = repo.tags and #repo.tags > 0 and table.concat(repo.tags, ", ") or "",
            limit = 100,
          },
          {
            content = repo.description,
            limit = 200,
          },
        }
      end,
    },
    cmd = { "Store" },
  },
}
