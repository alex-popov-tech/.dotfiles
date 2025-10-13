local util = require("util")
local common = require("lsp.servers.common")

return util.t.merge("force", common, {
  settings = {
    -- ["harper-ls"] = {
    userDictPath = "/Users/alex/.dotfiles/nvim.config/nvim/spell/en.utf-8.add",
    --   fileDictPath = "",
    --   linters = {
    --     SpellCheck = true,
    --     SpelledNumbers = false,
    --     AnA = true,
    --     SentenceCapitalization = true,
    --     UnclosedQuotes = true,
    --     WrongQuotes = false,
    --     LongSentences = true,
    --     RepeatedWords = true,
    --     Spaces = true,
    --     Matcher = true,
    --     CorrectNumberSuffix = true,
    --   },
    --   codeActions = {
    --     ForceStable = false,
    --   },
    --   markdown = {
    --     IgnoreLinkTitle = false,
    --   },
    --   diagnosticSeverity = "hint",
    --   isolateEnglish = false,
    -- },
  },
})
