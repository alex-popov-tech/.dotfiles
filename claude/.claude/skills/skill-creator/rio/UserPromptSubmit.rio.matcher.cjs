/**
 * UserPromptSubmit Matcher for skill-creator skill (v2.0)
 *
 * This matcher detects when users want to create, develop, or update
 * Claude Code skills. It triggers on keywords related to skill creation,
 * structure, resources (scripts/references/assets), and packaging.
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

  if (!prompt.includes("skill")) {
    return {
      version: "2.0",
      matchCount: 0,
      type: "skill",
    };
  }

  const keywords = ["skill", "create", "build", "make"];

  // Count matching keywords
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0", // Required: always "2.0"
    matchCount: matchCount, // Required: number of matches (0+)
    type: "skill", // Required: "skill" for skill matchers
  };
};
