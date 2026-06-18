-- tools — utility plugins loaded on demand.
local defer = require("defer")

-- snap.nvim — screenshot code snippets (:Snap, :Screen)
defer.on_cmd({ "Snap", "Screen" }, function()
  vim.pack.add({ { src = "https://github.com/mistweaverco/snap.nvim", version = "v1.5.0" } })
  require("snap").setup({
    save_to_disk = { image = false, html = false },
    copy_to_clipboard = { image = true, html = true },
  })
  vim.api.nvim_create_user_command("Screen", function()
    vim.cmd("Snap")
  end, { desc = "Screenshot code snippet", nargs = "*", range = "%" })
end)

-- store.nvim — plugin/note manager (:Store)
defer.on_cmd({ "Store" }, function()
  vim.pack.add({
    "https://github.com/alex-popov-tech/store.nvim",
    "https://github.com/OXY2DEV/markview.nvim",
    "https://github.com/3rd/image.nvim",
  })
  require("markview").setup({})
  require("image").setup({ integrations = { markdown = { enabled = false } } })
  require("store").setup({
    -- logging = "debug",
    layout = "tab",
    proportions = { list = 0.6, preview = 0.4 },
    preview_debounce = 50,
  })
end)

-- no-neck-pain.nvim — center buffer for distraction-free editing (:NoNeckPain)
defer.on_cmd({ "NoNeckPain" }, function()
  vim.pack.add({ "https://github.com/shortcuts/no-neck-pain.nvim" })
end)
