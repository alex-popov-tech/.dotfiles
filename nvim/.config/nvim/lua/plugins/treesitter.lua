return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      indent = { enable = true },
      ensure_installed = {
        "angular",
        "arduino",
        "asm",
        "astro",
        "awk",
        "bash",
        "c",
        "clojure",
        "cmake",
        "comment",
        "commonlisp",
        "cpp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "dot",
        "erlang",
        "fish",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "gpg",
        "graphql",
        "html",
        "http",
        "ini",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "kconfig",
        "kotlin",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "nim",
        "nim_format_string",
        "perl",
        "prisma",
        "properties",
        "pug",
        "python",
        "ruby",
        "rust",
        "scala",
        "scss",
        "solidity",
        "sql",
        "ssh_config",
        "svelte",
        "tmux",
        "tsx",
        "toml",
        "twig",
        "typescript",
        "typoscript",
        "vim",
        "vue",
        "xml",
        "yaml",
        "zig",
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        indent = { enable = true },
        use_languagetree = true,
      },
      autotag = { enable = true },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },
    })
  end,
}