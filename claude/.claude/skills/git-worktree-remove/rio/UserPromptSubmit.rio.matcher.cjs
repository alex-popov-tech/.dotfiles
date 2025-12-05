/**
 * UserPromptSubmit Matcher for git-worktree-remove skill (v2.0)
 *
 * This matcher detects when users want to remove or delete git worktrees
 * from the .worktrees/ directory and clean up associated files.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @param {string} context.cwd - Current working directory
 * @param {string} context.transcriptPath - Path to conversation transcript
 * @param {string} context.permissionMode - "ask" | "allow"
 * @param {string} context.sessionId - Session ID
 * @param {Object} context.meta - Meta information
 * @param {Object} context.transcript - Transcript utilities (for async usage)
 * @returns {Object} Matcher result {version, matchCount, type}
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  // Keywords for detecting git worktree removal workflows
  const keywords = ["git", "git worktree", "worktree", "cleanup"];

  // Count matching keywords
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0", // Required: always "2.0"
    matchCount: matchCount, // Required: number of matches (0+)
    type: "skill", // Required: identifies this as a skill matcher
  };
};
