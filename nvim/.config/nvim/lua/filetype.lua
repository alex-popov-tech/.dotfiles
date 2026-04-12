vim.filetype.add({
  extension = {
    png = "png",
    jpeg = "jpeg",
    jpg = "jpg",
    pug = "pug",
    jade = "pug",
    http = "http",
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
  },
  pattern = {
    -- match .env.example, .env.local, etc.
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
