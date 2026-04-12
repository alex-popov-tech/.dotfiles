local defer = require("defer")

-- nvim-treesitter -----------------------------------------------------------
-- the new main branch explicitly does NOT support lazy loading: the plugin
-- must be on rtp so parsers and query files are discoverable, and
-- vim.treesitter.start() needs it available when FileType fires.

local parsers = {
  "bash",
  "c",
  "cmake",
  "comment",
  "css",
  "diff",
  "dockerfile",
  "elixir",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "gleam",
  "go",
  "html",
  "http",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "requirements",
  "rust",
  "scss",
  "sql",
  "toml",
  "typescript",
  "xml",
  "yaml",
  "zig",
  "zsh",
}

-- PackChanged hook: refresh parsers when the plugin itself is updated.
-- MUST be registered before vim.pack.add() so install hooks fire correctly.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "nvim-treesitter" then
      return
    end
    if ev.data.kind ~= "update" then
      return
    end
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

-- install missing parsers (idempotent; no-op if already present).
-- async by design — fresh installs compile parsers in the background.
require("nvim-treesitter").install(parsers)

-- enable treesitter highlighting per buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter_highlight", { clear = true }),
  callback = function(ev)
    -- skip non-file buffers (plugin UIs like mason/lazy/etc)
    if vim.bo[ev.buf].buftype ~= "" then
      return
    end
    if vim.bo[ev.buf].filetype == "" then
      return
    end
    pcall(vim.treesitter.start, ev.buf)
  end,
})


-- nvim-ts-autotag -----------------------------------------------------------
-- auto-close html/jsx/templ tags. depends on treesitter being loaded.
-- eagerly loaded; the plugin auto-hooks the relevant filetypes itself.
vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })
require("nvim-ts-autotag").setup({})


-- nvim-treesitter-textobjects -----------------------------------------------
-- treesitter-aware text objects and movements. deferred to next event loop
-- tick so it doesn't block startup.
defer.later(function()
  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" })
  require("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
    move = { set_jumps = true },
  })

  local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
  local ts_move = require("nvim-treesitter-textobjects.move")

  -- text object selections
  vim.keymap.set({ "x", "o" }, "af", function() ts_select("@function.outer", "textobjects") end, { desc = "outer function" })
  vim.keymap.set({ "x", "o" }, "if", function() ts_select("@function.inner", "textobjects") end, { desc = "inner function" })
  vim.keymap.set({ "x", "o" }, "ac", function() ts_select("@class.outer", "textobjects") end, { desc = "outer class" })
  vim.keymap.set({ "x", "o" }, "ic", function() ts_select("@class.inner", "textobjects") end, { desc = "inner class" })
  vim.keymap.set({ "x", "o" }, "aa", function() ts_select("@parameter.outer", "textobjects") end, { desc = "outer argument" })
  vim.keymap.set({ "x", "o" }, "ia", function() ts_select("@parameter.inner", "textobjects") end, { desc = "inner argument" })

  -- movements
  vim.keymap.set({ "n", "x", "o" }, "]f", function() ts_move.goto_next_start("@function.outer", "textobjects") end, { desc = "next function start" })
  vim.keymap.set({ "n", "x", "o" }, "[f", function() ts_move.goto_previous_start("@function.outer", "textobjects") end, { desc = "previous function start" })
  vim.keymap.set({ "n", "x", "o" }, "]F", function() ts_move.goto_next_end("@function.outer", "textobjects") end, { desc = "next function end" })
  vim.keymap.set({ "n", "x", "o" }, "[F", function() ts_move.goto_previous_end("@function.outer", "textobjects") end, { desc = "previous function end" })
  vim.keymap.set({ "n", "x", "o" }, "]c", function() ts_move.goto_next_start("@class.outer", "textobjects") end, { desc = "next class start" })
  vim.keymap.set({ "n", "x", "o" }, "[c", function() ts_move.goto_previous_start("@class.outer", "textobjects") end, { desc = "previous class start" })
end)
