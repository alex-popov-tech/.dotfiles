# Keymaps & Mappings

Key mapping changes the meaning of typed keys.

For full details, grep `/opt/homebrew/Cellar/neovim/HEAD-16680e5/share/nvim/runtime/doc/map.txt`.

## Lua API

### `vim.keymap.set(mode, lhs, rhs, opts)`

```lua
-- Normal mode, Vim command
vim.keymap.set('n', '<Leader>x', '<cmd>echo "hello"<cr>')

-- Multiple modes
vim.keymap.set({'n', 'v'}, '<Leader>x', function() ... end)

-- Buffer-local
vim.keymap.set('n', '<Leader>x', function() ... end, { buffer = 0 })
```

**opts:**
- `buffer` - buffer number or `true`/`0` for current
- `silent` - suppress output (default false)
- `expr` - use return value as keystrokes
- `desc` - description string (shown in `:map`)
- `remap` - make recursive (default false = noremap)
- `nowait` - don't wait for longer key sequences
- `unique` - error if mapping already exists
- `replace_keycodes` - for expr mappings, replace keycodes in result

### `vim.keymap.del(mode, lhs, opts)`

```lua
vim.keymap.del('n', '<Leader>x')
vim.keymap.del({'n', 'v'}, '<Leader>x', { buffer = 0 })
```

### `nvim_set_keymap(mode, lhs, rhs, opts)` / `nvim_buf_set_keymap(...)`

Lower-level API; `vim.keymap.set` is preferred.

### `nvim_get_keymap(mode)` / `nvim_buf_get_keymap(buffer, mode)`

Returns list of all mappings for the given mode.

## Map Modes

| Mode | Command | Vim cmd | Applies to |
|---|---|---|---|
| Normal | `:nmap` | `n` | Normal mode |
| Visual + Select | `:vmap` | `v` | Visual and Select |
| Visual only | `:xmap` | `x` | Visual mode only |
| Select only | `:smap` | `s` | Select mode only |
| Operator-pending | `:omap` | `o` | After operator (d, y, c, etc.) |
| Insert | `:imap` | `i` | Insert mode |
| Command-line | `:cmap` | `c` | Command-line mode |
| Terminal | `:tmap` | `t` | Terminal mode |
| Lang-arg | `:lmap` | `l` | Insert, Cmd, Lang-Arg |
| Normal + Visual + Op-pending | `:map` | `` | n + v + o |
| Insert + Command-line | `:map!` | `!` | i + c |

## Noremap vs Map

| Recursive | Non-recursive |
|---|---|
| `:map` | `:noremap` |
| `:nmap` | `:nnoremap` |
| `:vmap` | `:vnoremap` |
| `:imap` | `:inoremap` |
| `:cmap` | `:cnoremap` |
| `:tmap` | `:tnoremap` |
| `:omap` | `:onoremap` |
| `:xmap` | `:xnoremap` |
| `:smap` | `:snoremap` |

`vim.keymap.set` is non-recursive by default (`remap = false`).

## Special Keys

| Key | Meaning |
|---|---|
| `<Cmd>` | Execute command without leaving current mode (preferred over `:` in mappings) |
| `<cmd>` | Same (case-insensitive) |
| `<CR>` | Enter/Return |
| `<Esc>` | Escape |
| `<C-x>` | Ctrl+x |
| `<A-x>` / `<M-x>` | Alt/Meta+x |
| `<S-x>` | Shift+x |
| `<Leader>` | Leader key (default `\`) |
| `<LocalLeader>` | Local leader key |
| `<Plug>` | Special prefix for plugin mappings (always expanded even with noremap) |
| `<SID>` | Script ID for script-local mappings |
| `<Nop>` | No operation (disable a key) |
| `<Space>` | Space |
| `<Tab>` | Tab |
| `<BS>` | Backspace |
| `<Up>` `<Down>` `<Left>` `<Right>` | Arrow keys |
| `<F1>`-`<F12>` | Function keys |

## `<Plug>` Mappings

For plugin authors to expose actions:

```lua
-- Plugin defines
vim.keymap.set('n', '<Plug>(MyAction)', function() ... end)

-- User maps
vim.keymap.set('n', '<leader>a', '<Plug>(MyAction)')
```

`<Plug>` mappings are always expanded even with `noremap`.

Check if user has a mapping: `vim.fn.hasmapto('<Plug>(MyAction)')`.

## `<Cmd>` Mappings

Preferred over `:` because `<Cmd>` doesn't change mode:

```lua
vim.keymap.set('n', '<leader>x', '<Cmd>write<CR>')
-- vs
vim.keymap.set('n', '<leader>x', ':write<CR>')  -- briefly enters cmdline mode
```

## Expr Mappings

```lua
vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then return '<C-n>' end
  return '<Tab>'
end, { expr = true })
```

## Vimscript Commands

```vim
:map {lhs} {rhs}           " Show or create mapping
:noremap {lhs} {rhs}       " Non-recursive mapping
:unmap {lhs}                " Remove mapping
:mapclear                   " Remove all mappings

" List all mappings
:map                        " Normal + Visual + Op-pending
:nmap                       " Normal mode only
:verbose nmap <leader>      " Show where mapping was defined
```

## User Commands

### `nvim_create_user_command(name, command, opts)`

```lua
vim.api.nvim_create_user_command('Greet', function(opts)
  print('Hello ' .. opts.args)
end, {
  nargs = '?',      -- 0 or 1 args. Also: '0', '1', '*', '+'
  bang = true,       -- allow !
  range = true,      -- accept range
  count = true,      -- accept count
  desc = 'Greeting', -- description
  complete = function(ArgLead, CmdLine, CursorPos)
    return { 'World', 'Neovim' }
  end,
})
```

Callback table keys: `name`, `args`, `fargs` (split by whitespace), `bang`, `line1`, `line2`, `range`, `count`, `reg`, `smods`.

### Buffer-local commands

```lua
vim.api.nvim_buf_create_user_command(0, 'BufGreet', ...)
vim.api.nvim_buf_del_user_command(0, 'BufGreet')
```

### Delete command

```lua
vim.api.nvim_del_user_command('Greet')
```
