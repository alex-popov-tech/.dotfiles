/**
 * Prettier Skill Matcher (v2.0)
 *
 * Detects when the user wants to format code using Prettier.
 * Matches on keywords like "prettier", "format", "cosmetic", ".prettierrc", etc.
 *
 * @param {Object} context - Matcher context
 * @param {string} context.prompt - User's prompt text
 * @returns {Object} Matcher result {version, matchCount, type}
 */
module.exports = function (context) {
  const prompt = context.prompt.toLowerCase();

  const keywords = [
    "quality",
    "quality gates",
    "prettier",
    "format",
    "formatters",
    "formaters",
    "formatting",
    "formatted",
  ];

  // Count matching keywords
  const matchCount = keywords.filter((keyword) =>
    prompt.includes(keyword),
  ).length;

  // IMPORTANT: All fields are MANDATORY and must not be undefined/null
  return {
    version: "2.0",
    matchCount: matchCount,
    type: "skill",
  };
};
