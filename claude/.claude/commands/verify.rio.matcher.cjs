/**
 * Matcher for verify-and-commit command
 *
 * Detects user requests to verify code quality, fix issues, and create organized commits.
 * The command runs comprehensive quality checks (ESLint, TypeScript), fixes issues,
 * formats code, and organizes commits into logical chunks.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @returns {Object} Matcher result {version: "2.0", matchCount: number, type: "command"}
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  const keywords = [
    "quality",
    "quality gates",
    "check",
    "checks",
    "validate",
    "verify",
    "verification",
  ];

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0",
    matchCount: keywords.filter((it) => prompt.includes(it)).length,
    type: "command",
  };
};
