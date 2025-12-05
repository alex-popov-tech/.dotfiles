/**
 * UserPromptSubmit Matcher for typescript-fixer Agent (v2.0)
 *
 * This matcher detects when users need the typescript-fixer agent,
 * which handles complex TypeScript error analysis and intelligent fixes.
 *
 * The agent is specialized in:
 * - Analyzing structured TypeScript compilation errors
 * - Understanding type relationships and type safety
 * - Applying fixes in dependency order (root causes first)
 * - Handling cascading errors and error patterns
 *
 * Matcher schema v2.0: Returns matchCount (number of keyword matches)
 * Higher count = higher relevance score.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @param {string} context.cwd - Current working directory
 * @param {string} context.transcriptPath - Path to conversation transcript
 * @param {string} context.permissionMode - "ask" | "allow"
 * @param {string} context.sessionId - Session ID
 * @param {Object} context.meta - Meta information
 * @param {Object} context.transcript - Transcript utilities
 * @returns {{version: string, matchCount: number, type: string}} Matcher result
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  // Keywords for typescript-fixer delegation
  // Focus on: type errors, error fixing, type analysis, TypeScript concepts
  const keywords = [
    "quality",
    "quality gates",
    "compile",
    "compiler",
    "compilation",
    "typescript",
    "type check",
    "type mismatch",
  ];

  // Count matching keywords (v2.0 schema: matchCount = number of matches)
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0", // Required: always "2.0"
    matchCount: matchCount, // Required: number of matches (0+)
    type: "agent", // Required: this is an agent matcher
  };
};
