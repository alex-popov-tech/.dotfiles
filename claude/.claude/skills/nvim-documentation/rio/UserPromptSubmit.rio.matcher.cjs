/**
 * UserPromptSubmit Matcher for nvim-documentation Skill (v2.0)
 *
 * Triggers when user prompt involves Neovim plugin development,
 * Lua scripting, or Neovim API usage.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @returns {Object} Matcher result with all required fields
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  const keywords = [
    "neovim",
    "nvim",
    "vim.api",
    "vim.lsp",
    "vim.treesitter",
    "vim.keymap",
    "vim.diagnostic",
    "vim.fn",
    "vim.opt",
    "vim.cmd",
    "vim.bo",
    "vim.wo",
    "vim.o.",
    "vim.g.",
    "nvim_create",
    "nvim_buf_",
    "nvim_win_",
    "nvim_set_hl",
    "nvim_open_win",
    "nvim_get_current",
    "init.lua",
    "lua plugin",
    "nvim plugin",
    "autocommand",
    "autocmd",
    "runtimepath",
    "ftplugin",
    "checkhealth",
    "vim.health",
    "nvim_create_autocmd",
    "nvim_create_user_command",
  ];

  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  return {
    version: "2.0",
    matchCount: matchCount,
    type: "skill",
  };
};
