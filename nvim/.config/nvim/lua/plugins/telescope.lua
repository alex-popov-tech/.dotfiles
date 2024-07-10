return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    "benfowler/telescope-luasnip.nvim",
    { "danielfalk/smart-open.nvim", dependencies = { "kkharji/sqlite.lua" } },
  },
  cmd = { "Telescope" },
  keys = {
    {
      "gr",
      function()
        require("telescope.builtin").resume()
      end,
    },
    {
      "gf",
      function()
        require("telescope.builtin").git_files()
      end,
    },
    {
      "gF",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
        })
      end,
    },
    {
      "gx",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      { noremap = true, expr = true },
    },
    {
      "go",
      function()
        require("telescope.builtin").grep_string()
      end,
    },
    {
      "gb",
      function()
        require("telescope.builtin").buffers({ sort_lastused = true })
      end,
    },
    {
      "gh",
      function()
        require("telescope.builtin").oldfiles({ cwd_only = true })
      end,
    },
    {
      "z=",
      function()
        require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor())
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        layout_strategy = "flex",
        layout_config = { width = 0.9, height = 0.9 },
        mappings = {
          i = {
            ["<C-q>"] = function()
              require("telescope.actions").send_selected_to_qflist()
            end,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")
    telescope.load_extension("luasnip")
    telescope.load_extension("smart_open")
    telescope.load_extension("rest")
    vim.cmd("cnoreabbrev tel Telescope")
    vim.cmd("hi TelescopeBorder guibg=none")
  end,
}
