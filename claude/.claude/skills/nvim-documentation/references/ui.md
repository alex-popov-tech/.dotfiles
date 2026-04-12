# UI: Windows, Tabs, Signs & Quickfix

For full details, grep the source files in `/opt/homebrew/Cellar/neovim/HEAD-16680e5/share/nvim/runtime/doc/`.

## Windows

### Splitting

```vim
:split [file]       " Horizontal split (or Ctrl-W s)
:vsplit [file]      " Vertical split (or Ctrl-W v)
:new                " New horizontal split with empty buffer
:vnew               " New vertical split with empty buffer
:only               " Close all other windows (or Ctrl-W o)
```

### Navigation

| Key | Action |
|---|---|
| `<C-w>h/j/k/l` | Move to left/down/up/right window |
| `<C-w>w` | Cycle through windows |
| `<C-w>p` | Go to previous (last accessed) window |
| `<C-w>t` | Go to top-left window |
| `<C-w>b` | Go to bottom-right window |

### Resizing

| Key | Action |
|---|---|
| `<C-w>=` | Equalize all window sizes |
| `<C-w>+/-` | Increase/decrease height |
| `<C-w>>/<` | Increase/decrease width |
| `<C-w>_` | Maximize height |
| `<C-w>\|` | Maximize width |
| `:resize N` | Set height to N |
| `:vertical resize N` | Set width to N |

### Moving Windows

| Key | Action |
|---|---|
| `<C-w>H/J/K/L` | Move window to far left/bottom/top/right |
| `<C-w>T` | Move window to new tab |
| `<C-w>r/R` | Rotate windows down/right or up/left |
| `<C-w>x` | Exchange with next window |

### Floating Windows (API)

```lua
local buf = vim.api.nvim_create_buf(false, true)
local win = vim.api.nvim_open_win(buf, true, {
  relative = 'editor',  -- 'editor', 'win', 'cursor', 'mouse'
  width = 80,
  height = 20,
  row = 5,
  col = 10,
  anchor = 'NW',        -- 'NW', 'NE', 'SW', 'SE'
  style = 'minimal',    -- removes number, signcolumn, etc.
  border = 'rounded',   -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow', or list
  title = 'My Window',
  title_pos = 'center', -- 'left', 'center', 'right'
  footer = 'Footer',
  zindex = 50,
})

-- Reconfigure
vim.api.nvim_win_set_config(win, { width = 100 })

-- Close
vim.api.nvim_win_close(win, true)
```

Split windows via API:
```lua
vim.api.nvim_open_win(buf, true, {
  split = 'below',  -- 'left', 'right', 'above', 'below'
  win = 0,          -- relative to current window
  height = 15,
})
```

### Window Options

```lua
vim.wo.number = true
vim.wo[win_id].number = true
vim.wo[win_id][buf_nr].number = true  -- window+buffer specific
```

## Tab Pages

### Commands

```vim
:tabnew [file]      " New tab
:tabclose           " Close current tab
:tabnext / gt       " Next tab
:tabprev / gT       " Previous tab
:tabmove N          " Move tab to position N
:tabonly            " Close all other tabs
:tabs               " List all tabs
```

### Lua API

```lua
vim.cmd.tabnew()
vim.api.nvim_list_tabpages()
vim.api.nvim_get_current_tabpage()
vim.api.nvim_tabpage_list_wins(tabpage)
vim.api.nvim_tabpage_get_win(tabpage)
vim.api.nvim_tabpage_set_win(tabpage, win)
vim.api.nvim_tabpage_get_number(tabpage)
vim.api.nvim_tabpage_get_var(tabpage, name)
vim.api.nvim_tabpage_set_var(tabpage, name, value)
vim.api.nvim_tabpage_is_valid(tabpage)
```

## Signs

Signs are displayed in the sign column (left of line numbers). Modern Nvim uses extmarks for signs.

### Extmark-based Signs (Preferred)

```lua
local ns = vim.api.nvim_create_namespace('my_signs')
vim.api.nvim_buf_set_extmark(bufnr, ns, line - 1, 0, {
  sign_text = '>>',
  sign_hl_group = 'DiagnosticSignError',
  number_hl_group = 'DiagnosticSignError',
  line_hl_group = 'CursorLine',
  priority = 10,
})

-- Clear all signs in namespace
vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
```

### Sign Column Options

```lua
vim.opt.signcolumn = 'yes'    -- always show
vim.opt.signcolumn = 'auto'   -- show when signs present
vim.opt.signcolumn = 'no'     -- never show
vim.opt.signcolumn = 'yes:2'  -- always, 2 columns wide
```

## Quickfix & Location Lists

### Commands

```vim
:copen              " Open quickfix window
:cclose             " Close quickfix window
:cnext / :cprev     " Next/previous item
:cfirst / :clast    " First/last item
:cc N               " Go to item N
:colder / :cnewer   " Older/newer quickfix list
:cdo {cmd}          " Execute cmd on each quickfix entry
:cfdo {cmd}         " Execute cmd on each file in quickfix

" Location list (window-local)
:lopen / :lclose
:lnext / :lprev
:lfirst / :llast
```

### Lua API

```lua
-- Set quickfix list
vim.fn.setqflist({}, ' ', {
  title = 'My Results',
  items = {
    { filename = 'foo.lua', lnum = 10, col = 5, text = 'Found here' },
    { filename = 'bar.lua', lnum = 20, text = 'And here' },
  },
})

-- Get quickfix list
local items = vim.fn.getqflist()

-- Set location list (for current window)
vim.fn.setloclist(0, items)

-- Get location list
local items = vim.fn.getloclist(0)

-- Using diagnostics
vim.diagnostic.setqflist()       -- all diagnostics to quickfix
vim.diagnostic.setloclist()      -- buffer diagnostics to location list
```

### Quickfix Stack

Multiple quickfix lists are maintained in a stack. Navigate with `:colder`/`:cnewer`.

```lua
vim.fn.setqflist({}, ' ', { title = 'New List', items = ... })  -- push new list
vim.fn.setqflist({}, 'a', { items = ... })  -- append to current list
vim.fn.setqflist({}, 'r', { items = ... })  -- replace current list items
```
