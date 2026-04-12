-- helper: run a search motion and briefly highlight the match
local function blink_search(key)
  return function()
    vim.cmd("normal! " .. key .. "zz")
    vim.opt.hlsearch = true
    vim.defer_fn(function()
      vim.opt.hlsearch = false
    end, 200)
  end
end

-- buffer navigation
vim.keymap.set("n", "<up>", "<cmd>bn<cr>")
vim.keymap.set("n", "<down>", "<cmd>bp<cr>")

-- splits (with splitbelow/splitright cursor lands in new window automatically)
vim.keymap.set("n", "<leader>s", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>")

-- write and exit current buffer
vim.keymap.set("n", "<C-q>", "ZZ")

-- if pressing 'a' on an empty line, use 'S' instead (respects indent)
vim.keymap.set("n", "a", "len(getline('.')) == 0 ? 'S' : 'a'", { expr = true })

-- open command history window (trim the stray trailing empty line)
vim.keymap.set("n", "Q", "q:dd")

-- replace last searched pattern: after /foo, press R to substitute
vim.keymap.set("n", "R", ":%s///gI<left><left><left>")

-- blink on search match
vim.keymap.set("n", "n", blink_search("n"))
vim.keymap.set("n", "N", blink_search("N"))
vim.keymap.set("n", "*", blink_search("*"))

-- force very-magic regex in search and substitute
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("v", ":s/", ":s/\\v")
vim.keymap.set("c", "%s/", "%s/\\v")

-- <C-a>: toggle true/false under cursor, else default increment
vim.keymap.set("n", "<C-a>", function()
  local word_under_cursor = vim.fn.expand("<cword>")
  if word_under_cursor == "true" then
    vim.cmd("normal ciwfalse")
    return
  elseif word_under_cursor == "false" then
    vim.cmd("normal ciwtrue")
    return
  end
  vim.cmd.normal({ vim.keycode("<C-a>"), bang = true })
end)

-- comment aliases (remap to neovim built-in gc/gcc, enhanced by ts-comments)
vim.keymap.set("n", "<leader>c", "gc", { remap = true })
vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
vim.keymap.set("v", "<leader>c", "gc", { remap = true })

-- wrap-aware j/k (move by visual line when wrap is on)
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- command abbreviations: :W and :WA = :noa w / :noa wa (no autocmds on save)
vim.keymap.set("ca", "W", "noa w")
vim.keymap.set("ca", "WA", "noa wa")

-- copy visual selection as @path#L<start>-<end> (for claude)
vim.keymap.set("v", "ai", function()
  local a, b = vim.fn.line("v"), vim.fn.line(".")
  local start_line, end_line = math.min(a, b), math.max(a, b)
  local filepath = vim.fn.expand("%:p")
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local rel_path = (git_root and vim.v.shell_error == 0)
      and filepath:sub(#git_root + 2)
    or filepath

  local result = string.format("@%s#L%d-%d", rel_path, start_line, end_line)
  vim.fn.setreg("+", result)
  vim.notify("📋 Copied: " .. result, vim.log.levels.INFO)
  vim.cmd.normal({ vim.keycode("<Esc>"), bang = true })
end, { desc = "Copy file reference for Claude" })
