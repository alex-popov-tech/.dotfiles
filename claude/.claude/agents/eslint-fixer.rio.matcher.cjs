/**
 * UserPromptSubmit Matcher for eslint-fixer agent
 *
 * This matcher identifies prompts that request ESLint error fixing,
 * code quality improvements, and intelligent linting analysis.
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

  const keywords = [
    "linter",
    "lint",
    "linting",
    "eslint",
    "quality",
    "quality gates",
  ];

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0", // Required: always "2.0"
    matchCount: keywords.filter((it) => prompt.includes(it)).length, // Required: number of matches (0+)
    type: "agent", // Required: 'skill', 'agent', or 'command'
  };
};
