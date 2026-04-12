-- nvim-ufo — advanced folding with treesitter/indent providers.
-- settings.lua has foldlevel=99 and foldlevelstart=99 for ufo.
local defer = require("defer")

defer.later(function()
  vim.pack.add({
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/kevinhwang91/promise-async",
  })

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local totalLines = vim.api.nvim_buf_line_count(0)
    local foldedLines = endLnum - lnum
    local suffix = (" 🙏 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
    suffix = (" "):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end

  require("ufo").setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
    fold_virt_text_handler = handler,
  })

  vim.keymap.set("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
  vim.keymap.set("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
end)
