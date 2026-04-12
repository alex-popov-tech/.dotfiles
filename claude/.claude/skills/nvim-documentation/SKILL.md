---
name: nvim-documentation
description: >
  Neovim built-in documentation reference for plugin development, Lua scripting,
  API usage, LSP, treesitter, diagnostics, autocommands, keymaps, options, UI,
  syntax/highlights, vimscript, terminal/jobs, filetypes, health checks, and news.
  Use when working on Neovim plugins, init.lua configuration, or any Lua code
  that interacts with Neovim APIs.
---

# Neovim Documentation

Curated reference from Neovim's built-in help files.

**Source**: `/opt/homebrew/Cellar/neovim/HEAD-16680e5/share/nvim/runtime/doc/*.txt`

For exhaustive lookup of very large files (options.txt, vimfn.txt, luaref.txt), Read/Grep the source `.txt` files directly.

## References

| Topic | Reference | Source file(s) | When to consult |
|---|---|---|---|
| Lua Guide | [lua-guide.md](references/lua-guide.md) | lua-guide.txt | Getting started with Lua in Neovim, vim.keymap, vim.autocmd patterns |
| Lua Plugin Dev | [lua-plugin.md](references/lua-plugin.md) | lua-plugin.txt | Plugin structure, runtimepath, ftplugin, autoload patterns |
| Lua Reference | [lua-reference.md](references/lua-reference.md) | lua.txt, luaref.txt | vim.* stdlib functions, vim.fn, vim.api, Lua/Nvim bridge |
| API | [api.md](references/api.md) | api.txt | nvim_buf_*, nvim_win_*, nvim_create_*, all C API functions |
| LSP | [lsp.md](references/lsp.md) | lsp.txt | vim.lsp.*, LSP client config, handlers, on_attach |
| Treesitter | [treesitter.md](references/treesitter.md) | treesitter.txt | vim.treesitter.*, query, parser, highlighting, folds |
| Diagnostics | [diagnostic.md](references/diagnostic.md) | diagnostic.txt | vim.diagnostic.*, signs, virtual text, severity |
| Autocommands | [autocmd.md](references/autocmd.md) | autocmd.txt | Events list, nvim_create_autocmd, augroups, patterns |
| Keymaps | [keymaps.md](references/keymaps.md) | map.txt | vim.keymap.set, map modes, <Cmd>, <Plug>, operator-pending |
| Options | [options.md](references/options.md) | options.txt | vim.opt, vim.o, vim.bo, vim.wo, all option names |
| UI (Windows/Tabs) | [ui.md](references/ui.md) | windows.txt, tabpage.txt, sign.txt, quickfix.txt | Window splits, tabs, signs, quickfix/location lists |
| Syntax & Highlights | [syntax-highlights.md](references/syntax-highlights.md) | syntax.txt | nvim_set_hl, highlight groups, syntax commands, matchadd |
| Vimscript | [vimscript.md](references/vimscript.md) | vimeval.txt, vimfn.txt | vim.fn.*, Vimscript builtins, expressions, vim.cmd |
| Terminal & Jobs | [terminal-jobs.md](references/terminal-jobs.md) | terminal.txt, job_control.txt, channel.txt | Terminal buffers, jobstart, channels, RPC |
| Filetype | [filetype.md](references/filetype.md) | filetype.txt | Filetype detection, ftplugin, filetype.lua |
| Health | [health.md](references/health.md) | health.txt | vim.health.*, checkhealth, plugin health checks |
| News | [news.md](references/news.md) | news.txt | Latest Neovim changes, new features, breaking changes |

## Quick Patterns

```lua
-- Keymap
vim.keymap.set("n", "<leader>x", function() ... end, { desc = "..." })

-- Autocommand
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("MyGroup", { clear = true }),
  pattern = "*.lua",
  callback = function(ev) ... end,
})

-- Highlight
vim.api.nvim_set_hl(0, "MyHL", { fg = "#ff0000", bold = true })

-- User command
vim.api.nvim_create_user_command("MyCmd", function(opts) ... end, {
  nargs = "?", desc = "...",
})

-- Buffer/window operations
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_open_win(buf, true, { relative = "editor", width = 80, height = 24, row = 1, col = 1 })

-- Options
vim.opt.number = true
vim.bo.filetype = "lua"
```
