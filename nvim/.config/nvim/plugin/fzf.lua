-- fzf-lua — finders for files, buffers, grep, lsp, etc.
local defer = require("defer")
-- everything is deferred via vim.schedule EXCEPT the LspAttach autocmd,
-- which must register synchronously so it catches the first buffer's
-- LSP attach (which can fire before vim.schedule runs).

defer.later(function()
  vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-mini/mini.icons",
  })

  require("fzf-lua").setup({
    oldfiles = {
      prompt = "History❯ ",
      cwd_only = true,
    },
  })

  -- bare g* mappings — fzf family (files/buffers/grep/etc.)
  vim.keymap.set("n", "gr", function() require("fzf-lua").resume() end, { desc = "fzf: resume" })
  vim.keymap.set("n", "gb", function() require("fzf-lua").buffers() end, { desc = "fzf: buffers" })
  vim.keymap.set("n", "gf", function() require("fzf-lua").git_files() end, { desc = "fzf: git files" })
  vim.keymap.set("n", "gF", function() require("fzf-lua").files() end, { desc = "fzf: all files" })
  vim.keymap.set("n", "gx", function() require("fzf-lua").live_grep_native() end, { desc = "fzf: live grep" })
  vim.keymap.set("n", "gX", function()
    require("fzf-lua").live_grep_native({
      cmd = "rg --column --no-heading --color=always --max-columns=4096 --trim --no-ignore --hidden -i -e",
    })
  end, { desc = "fzf: live grep (unignored + hidden)" })
  vim.keymap.set("n", "go", function() require("fzf-lua").grep_cword() end, { desc = "fzf: grep word under cursor" })
  vim.keymap.set("n", "gh", function() require("fzf-lua").oldfiles() end, { desc = "fzf: history" })
  vim.keymap.set("n", "z=", function() require("fzf-lua").spell_suggest() end, { desc = "fzf: spell suggest" })
end)

-- LspAttach override: swap list-style lsp pickers to fzf-lua variants.
-- the base <leader>gr/<leader>ca/<leader>gs are set in lua/lsp.lua as plain
-- vim.lsp.buf.* calls. this autocmd runs per-buffer and its buffer-local
-- mappings shadow the base ones. fzf-lua is required lazily inside the
-- keymap callback — by the time the user presses a key, vim.schedule has
-- already fired and the plugin is on rtp.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspFzf", { clear = true }),
  callback = function(args)
    local bufopts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "<leader>gr", function() require("fzf-lua").lsp_references() end, bufopts)
    vim.keymap.set("n", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end, bufopts)
    vim.keymap.set("n", "<leader>gs", function() require("fzf-lua").lsp_document_symbols() end, bufopts)
  end,
})
