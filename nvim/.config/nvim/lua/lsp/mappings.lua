local Input = require("nui.input")
local event = require("nui.utils.autocmd").event
local options = { noremap = true, silent = true }

local rename = function()
  local word = vim.fn.expand("<cword>")
  local word_len = #word
  local size = math.max(30, word_len * 2)

  local popup_options = {
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = size,
    border = {
      style = "rounded",
    },
  }

  local input = Input(popup_options, {
    prompt = "> ",
    default_value = word,
    on_close = function()
      vim.notify("Renaming cancelled!")
    end,
    on_submit = function(value)
      vim.lsp.buf.rename(value)
      vim.notify("Renamed '" .. word .. "' to '" .. value .. "'")
    end,
  })

  input:map("i", "<Esc>", function()
    input:unmount()
  end, { noremap = true })
  input:map("n", "<Esc>", function()
    input:unmount()
  end, { noremap = true })
  input:on(event.BufLeave, function()
    input:unmount()
  end)

  input:mount()
end

return function(client)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, options)
  vim.keymap.set("n", "'gd", vim.lsp.buf.definition, options)
  vim.keymap.set("n", "'rn", rename, options)

  vim.keymap.set("n", "'gr", function()
    require("telescope.builtin").lsp_references({
      layout_strategy = "vertical",
      layout_settings = { width = 0.9, height = 0.9 },
    })
  end, options)

  vim.keymap.set("n", "'gi", function()
    if vim.bo.filetype == "go" then
      vim.lsp.buf.definition()
    else
      vim.lsp.buf.implementation()
    end
  end, options)

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ float = { border = "single" } })
  end, options)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ float = { border = "single" } })
  end, options)

  vim.keymap.set("n", "'d", function()
    vim.diagnostic.open_float(0, {
      scope = "line",
      source = "if_many",
      border = "rounded",
      focusable = false,
    })
  end, options)
end
