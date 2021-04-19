return function()
    au("VimEnter", "*", "if !empty(glob('.env')) | Dotenv .env | endif")
    au("BufWritePost", ".env", "Dotenv .env")
end
