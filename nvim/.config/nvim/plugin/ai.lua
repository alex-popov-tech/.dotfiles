-- AI-assisted editing
local defer = require("defer")


-- neocodeium — AI code completion (codeium)
defer.later(function()
  vim.pack.add({ "https://github.com/monkoose/neocodeium" })
  local neocodeium = require("neocodeium")
  neocodeium.setup({
    show_label = false,
  })

  vim.keymap.set("i", "<A-a>", neocodeium.accept, { desc = "Accept suggestion" })
  vim.keymap.set("i", "<A-e>", neocodeium.accept_line, { desc = "Accept line" })
  vim.keymap.set("i", "<A-w>", function() neocodeium.cycle_or_complete(1) end, { desc = "Next suggestion" })
  vim.keymap.set("i", "<A-u>", function() neocodeium.cycle_or_complete(-1) end, { desc = "Previous suggestion" })
end)


-- claudecode.nvim — Claude Code integration (:ClaudeCode)
defer.on_cmd({ "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd",
  "ClaudeCodeSelectModel", "ClaudeCodeTreeAdd", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" }, function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/coder/claudecode.nvim",
  })
  require("claudecode").setup({})
end)

vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
