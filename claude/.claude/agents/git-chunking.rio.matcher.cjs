/**
 * Matcher for git-chunking agent
 * Detects user prompts related to organizing and committing changes
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @returns {Object} Matcher result {version, matchCount, type}
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  // Keywords for git commit organization and chunking
  const keywords = [
    "commit",
    "organize commits",
    "split commits",
    "categorize changes",
  ];

  // Count matching keywords
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0",
    matchCount: matchCount,
    type: "agent",
  };
};
