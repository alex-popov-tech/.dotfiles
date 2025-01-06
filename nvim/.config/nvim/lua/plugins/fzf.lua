return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    oldfiles = {
      prompt = "History❯ ",
      cwd_only = true,
    },
  },
  cmd = { "FzfLua" },
  keys = {
    {
      "gr",
      function()
        require("fzf-lua").resume()
      end,
    },
    {
      "gf",
      function()
        require("fzf-lua").git_files()
      end,
    },
    {
      "gF",
      function()
        require("fzf-lua").files()
      end,
    },
    {
      "gx",
      function()
        require("fzf-lua").live_grep_native()
      end,
    },
    {
      "gX",
      function()
        require("fzf-lua").live_grep_native({
          cmd = "rg --column --no-heading --color=always --max-columns=4096 --trim --no-ignore --hidden --no-ignore -i -e",
        })
      end,
    },
    {
      "go",
      function()
        require("fzf-lua").grep_cword()
      end,
    },
    {
      "gh",
      function()
        require("fzf-lua").oldfiles()
      end,
    },
    {
      "z=",
      function()
        require("fzf-lua").spell_suggest()
      end,
    },
    {
      "'a",
      function()
        require("fzf-lua").lsp_code_actions()
      end,
    },
  },
}
