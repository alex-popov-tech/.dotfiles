/**
 * UserPromptSubmit Matcher for git-worktree-create Skill (v2.0)
 *
 * Triggers when user needs to create git worktrees for working on
 * multiple branches simultaneously without affecting current work.
 *
 * IMPORTANT: All return fields are MANDATORY and must not be undefined/null.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @param {string} context.cwd - Current working directory
 * @param {string} context.transcriptPath - Path to conversation transcript
 * @param {string} context.permissionMode - "ask" | "allow"
 * @param {string} context.sessionId - Session ID
 * @param {Object} context.meta - Meta information
 * @param {Object} context.transcript - Transcript utilities (for async usage)
 * @returns {Object} Matcher result with all required fields
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  // Keywords matching git-worktree-create skill patterns
  const keywords = [
    "git",
    "git worktree",
    "worktree",
    "switch branch",
    "temporary work",
    "uncommitted changes",
    "quick fix",
    "hotfix",
  ];

  // Count matching keywords
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0", // Required: always "2.0"
    matchCount: matchCount, // Required: number of matches (0+)
    type: "skill", // Required: type of matcher
  };
};
