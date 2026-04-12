# Lua Guide for Neovim

Guide to using Lua in Nvim. Assumes familiarity with the basics of Nvim (commands, options, mappings, autocommands).

## The API Layers

1. **Vim API** (inherited from Vim): Ex-commands and vimscript functions, accessed via `vim.cmd()` and `vim.fn`.
2. **Nvim API** (C, for remote plugins/GUIs): accessed via `vim.api`.
3. **Lua API** (Lua-specific): other `vim.*` functions; see `lua-stdlib`.

API functions inherit behavior from their original layer (e.g., Nvim API functions require all arguments; Vim API functions may use 0-based indexing).

## Using Lua

```vim
:lua print("Hello!")
:lua =package           " equivalent to :lua vim.print(...)
:source ~/myluafile.lua
```

Lua in Vimscript via heredoc:
```vim
lua << EOF
  local tbl = {1, 2, 3}
  for k, v in ipairs(tbl) do print(v) end
EOF
```

### Lua Files on Startup

Use `init.lua` (or `init.vim`, not both) in config directory. Put auto-run scripts in `plugin/` on `'runtimepath'`.

### Lua Modules

Place in `lua/` directory on `'runtimepath'`, load with `require()`:

```
~/.config/nvim
|-- lua/
|   |-- myluamodule.lua
|   |-- other_modules/
|       |-- anothermodule.lua
|       |-- init.lua
|-- plugin/
|-- init.lua
```

```lua
require("myluamodule")
require('other_modules.anothermodule')
require('other_modules') -- loads other_modules/init.lua
```

`require()` caches modules. To reload:
```lua
package.loaded['myluamodule'] = nil
require('myluamodule')
```

Use `pcall()` for error handling:
```lua
local ok, mymod = pcall(require, 'module_with_error')
if not ok then print("Module had an error") else mymod.func() end
```

## Vim Commands from Lua

```lua
vim.cmd("colorscheme habamax")
vim.cmd([[%s/\Vfoo/bar/g]])
vim.cmd([[
  highlight Error guibg=red
  highlight link Warning Error
]])

-- Programmatic form
vim.cmd.colorscheme("habamax")
vim.cmd.highlight({ "Error", "guibg=red" })
vim.cmd.highlight({ "link", "Warning", "Error" })
```

## Vimscript Functions from Lua

```lua
print(vim.fn.printf('Hello from %s', 'Lua'))
local reversed = vim.fn.reverse({ 'a', 'b', 'c' })
vim.fn.jobstart('ls', { on_stdout = print_stdout })

-- Autoload functions
vim.fn['my#autoload#function']()
```

## Variables

| Wrapper | Scope | Vimscript |
|---------|-------|-----------|
| `vim.g` | global | `g:` |
| `vim.b` | buffer | `b:` |
| `vim.w` | window | `w:` |
| `vim.t` | tabpage | `t:` |
| `vim.v` | predefined | `v:` |
| `vim.env` | environment | `$` |

```lua
vim.g.some_global_variable = { key1 = "value", key2 = 300 }
vim.b[2].myvar = 1               -- buffer number 2
vim.w[1005].myothervar = true     -- window ID 1005
vim.g.myvar = nil                 -- delete variable
```

**Note:** Cannot directly change fields of table variables. Copy to local, modify, reassign:
```lua
local temp = vim.g.some_global_variable
temp.key2 = 400
vim.g.some_global_variable = temp
```

## Options

### vim.opt (recommended for init.lua)

| Wrapper | Behaves like |
|---------|-------------|
| `vim.opt` | `:set` |
| `vim.opt_global` | `:setglobal` |
| `vim.opt_local` | `:setlocal` |

```lua
vim.opt.smarttab = true
vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
vim.opt.listchars = { space = '_', tab = '>~' }
vim.opt.formatoptions = { n = true, j = true, t = true }

vim.opt.shortmess:append({ I = true })
vim.opt.wildignore:prepend('*.o')
vim.opt.whichwrap:remove({ 'b', 's' })

-- Must use :get() to read values
print(vim.opt.smarttab:get())    --> false
vim.print(vim.opt.listchars:get()) --> { space = '_', tab = '>~' }
```

### vim.o (direct access)

| Wrapper | Behaves like |
|---------|-------------|
| `vim.o` | `:set` |
| `vim.go` | `:setglobal` |
| `vim.bo` | buffer-scoped |
| `vim.wo` | window-scoped |

```lua
vim.o.smarttab = false
vim.o.listchars = 'space:_,tab:>~'
vim.bo.shiftwidth = 4
vim.bo[4].expandtab = true    -- buffer 4
vim.wo.number = true           -- current window
vim.wo[0][0].number = true     -- current buffer in current window only
```

## Mappings

### Creating Mappings

`vim.keymap.set({mode}, {lhs}, {rhs}, {opts})`

```lua
vim.keymap.set('n', '<Leader>ex1', '<cmd>echo "Example 1"<cr>')
vim.keymap.set({'n', 'c'}, '<Leader>ex2', '<cmd>echo "Example 2"<cr>')
vim.keymap.set('n', '<Leader>ex3', vim.treesitter.start)
vim.keymap.set('n', '<Leader>ex4', function() print('Example 4') end)

-- Deferred loading
vim.keymap.set('n', '<Leader>pl2', function() require('plugin').action() end)
```

**Options:**
- `buffer`: set for specific buffer (`0` or `true` = current)
- `silent`: suppress output
- `expr`: use return value as input
- `desc`: description string (shown in `:map`)
- `remap`: make recursive (`false` by default, i.e. `noremap`)

```lua
-- expr mapping
vim.keymap.set('c', '<down>', function()
  if vim.fn.pumvisible() == 1 then return '<c-n>' end
  return '<down>'
end, { expr = true })
```

### Removing Mappings

```lua
vim.keymap.del('n', '<Leader>ex1')
vim.keymap.del({'n', 'c'}, '<Leader>ex2', {buffer = true})
```

## Autocommands

### Creating Autocommands

```lua
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.c", "*.h"},
  callback = function() print("Entering a C or C++ file") end,
})

-- User event
vim.api.nvim_create_autocmd("User", {
  pattern = "MyPlugin",
  callback = function() print("My Plugin Works!") end,
})
```

Callback receives table with: `match`, `buf`, `file`, `data`.

```lua
-- Buffer-local mappings for filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  end
})

-- Buffer-local autocommand
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = 0,
  callback = function() print("hold") end,
})
```

### Grouping Autocommands

```lua
local mygroup = vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.html',
  group = mygroup,
  command = 'set shiftwidth=4',
})
```

### Deleting Autocommands

```lua
vim.api.nvim_clear_autocmds({event = {"BufEnter", "InsertLeave"}})
vim.api.nvim_clear_autocmds({pattern = "*.py"})
vim.api.nvim_clear_autocmds({group = "scala"})
```

Related: `nvim_get_autocmds()`, `nvim_exec_autocmds()`.

## User Commands

### Creating User Commands

```lua
vim.api.nvim_create_user_command('Upper',
  function(opts)
    print(string.upper(opts.fargs[1]))
  end,
  { nargs = 1 })
```

Callback table keys: `name`, `fargs`, `bang`, `line1`, `line2`, `range`, `count`, `smods`.

With completion:
```lua
vim.api.nvim_create_user_command('Upper',
  function(opts) print(string.upper(opts.fargs[1])) end,
  { nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
      return { "foo", "bar", "baz" }
    end,
  })
```

Buffer-local: `vim.api.nvim_buf_create_user_command(0, 'Upper', ...)`

### Deleting User Commands

```lua
vim.api.nvim_del_user_command('Upper')
vim.api.nvim_buf_del_user_command(4, 'Upper')
```
