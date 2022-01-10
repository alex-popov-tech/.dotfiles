return function()
    au("VimEnter", ".env", "Dotenv .env")
    au("BufWritePost", ".env", "Dotenv .env")
end
