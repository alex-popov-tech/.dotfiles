return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false, -- last release is way too old and doesn't work on Windows
    -- event = "VeryLazy",
    lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    build = ":TSUpdate",
    opts = {
      parsers = {
        "astro",
        "bash",
        "c",
        "clojure",
        "cmake",
        "comment",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "editorconfig",
        "elixir",
        "erlang",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "gleam",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "gpg",
        "graphql",
        "html",
        "http",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "ocaml",
        "ocaml_interface",
        "ocamllex",
        "python",
        "regex",
        "requirements",
        "ruby",
        "rust",
        "query",
        "scss",
        "sql",
        "svelte",
        "tmux",
        "tsx",
        "toml",
        "twig",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
        "zsh",
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      TS.setup({})

      TS.install(opts.parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("my_treesitter", { clear = true }),
        callback = function(ev)
          local buf = ev.buf

          -- skip non-file buffers (most plugin UIs: noice/notify/lazy/mason/etc)
          if vim.bo[buf].buftype ~= "" then
            return
          end

          if vim.bo[buf].filetype == "" then
            return
          end
          -- try start highlighting
          if pcall(vim.treesitter.start, buf) then
            return
          end
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "templ",
      "astro",
      "glimmer",
      "handlebars",
      "html",
      "jsx",
      "markdown",
      "php",
      "rescript",
      "svelte",
      "tsx",
      "twig",
      "vue",
      "xml",
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local map = vim.keymap.set

      -- Textobject selections
      map({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end, { desc = "outer function" })
      map({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end, { desc = "inner function" })
      map({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end, { desc = "outer class" })
      map({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end, { desc = "inner class" })
      map({ "x", "o" }, "aa", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
      end, { desc = "outer argument" })
      map({ "x", "o" }, "ia", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
      end, { desc = "inner argument" })

      -- Movement
      map({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end, { desc = "next function start" })
      map({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end, { desc = "previous function start" })
      map({ "n", "x", "o" }, "]F", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
      end, { desc = "next function end" })
      map({ "n", "x", "o" }, "[F", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
      end, { desc = "previous function end" })
      map({ "n", "x", "o" }, "]c", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
      end, { desc = "next class start" })
      map({ "n", "x", "o" }, "[c", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
      end, { desc = "previous class start" })
    end,
  },
}
