# Options

Quick reference for Neovim options. Converted from `:help options` (options.txt).

For the complete list of all options, see `:help option-list` or grep the source file at
`$VIMRUNTIME/doc/options.txt` (~7600 lines).

## Table of Contents

- [Setting Options in Lua](#setting-options-in-lua)
- [Option Scopes](#option-scopes)
- [Setting Options with :set](#setting-options-with-set)
- [Option Reference Table](#option-reference-table)
  - [Display and UI](#display-and-ui)
  - [Line Numbers](#line-numbers)
  - [Indentation and Tabs](#indentation-and-tabs)
  - [Search](#search)
  - [Folding](#folding)
  - [Completion](#completion)
  - [Splits and Windows](#splits-and-windows)
  - [Buffers and Files](#buffers-and-files)
  - [Backup, Swap, Undo](#backup-swap-undo)
  - [Input and Mouse](#input-and-mouse)
  - [Timing](#timing)
  - [Scrolling](#scrolling)
  - [Whitespace Visualization](#whitespace-visualization)
  - [Spell Checking](#spell-checking)
  - [Filetype and Syntax](#filetype-and-syntax)
  - [File Encoding](#file-encoding)
  - [Text Formatting](#text-formatting)
  - [Command Line and Wildmenu](#command-line-and-wildmenu)
  - [Status Line and Tab Line](#status-line-and-tab-line)
  - [Transparency and Blending](#transparency-and-blending)
  - [Messages](#messages)
  - [Security and Modeline](#security-and-modeline)
  - [Terminal and Color](#terminal-and-color)
  - [Cursor Appearance](#cursor-appearance)
  - [Miscellaneous](#miscellaneous)

---

## Setting Options in Lua

Neovim provides several Lua APIs for setting options. They differ in scope and behavior:

| API | Description | Example |
|-----|-------------|---------|
| `vim.opt` | Like `:set`. Supports `append()`, `prepend()`, `remove()`, `get()`. Returns an `Option` object. | `vim.opt.number = true` |
| `vim.o` | Like `:set`. Direct read/write to the option's effective value (string/number/boolean). | `vim.o.number = true` |
| `vim.bo` | Like `:setlocal` for **buffer**-local options. Indexed by bufnr: `vim.bo[bufnr].ft`. | `vim.bo.filetype = "lua"` |
| `vim.wo` | Like `:setlocal` for **window**-local options. Indexed by winid: `vim.wo[winid].wrap`. | `vim.wo.wrap = false` |
| `vim.go` | Like `:setglobal`. Reads/writes only the **global** value, never the local one. | `vim.go.mouse = "a"` |

Key differences:

- `vim.opt` is the most versatile -- it wraps values in an `Option` object so you can call `:append()` on list/flag options (e.g., `vim.opt.shortmess:append("c")`). Use `:get()` to extract the raw value.
- `vim.o` and `vim.opt` both behave like `:set` -- for global-local options, they set both the global and local values.
- `vim.bo` / `vim.wo` behave like `:setlocal` -- they only touch the local value.
- `vim.go` behaves like `:setglobal` -- it only touches the global value, the local value is unaffected.

```lua
-- Examples
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.completeopt = { "menu", "menuone", "noselect" }  -- list assignment
vim.opt.shortmess:append("c")                             -- append flag
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }  -- dict-like

-- Equivalent with vim.o:
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.completeopt = "menu,menuone,noselect"  -- must be raw string

-- Buffer/window local:
vim.bo.filetype = "markdown"
vim.wo.signcolumn = "yes"
vim.wo[0].cursorline = true    -- current window
vim.bo[42].modifiable = false  -- buffer 42
```

## Option Scopes

Options come in three scopes:

| Scope | Meaning |
|-------|---------|
| **global** | One value shared across all buffers and windows |
| **local to buffer** | Each buffer has its own copy |
| **local to window** | Each window has its own copy |
| **global-local** | Has both a global default and a local override; `:set` writes both, `:setlocal` writes only local |

Options have three types: **boolean**, **number**, and **string**.

## Setting Options with :set

```vim
:set number          " Turn on boolean option
:set nonumber        " Turn off boolean option
:set number!         " Toggle boolean option
:set number?         " Show current value
:set number&         " Reset to default
:set shiftwidth=4    " Set number option
:set shortmess+=c    " Append to string/flags option
:set shortmess-=c    " Remove from string/flags option
:set shortmess^=I    " Prepend to string option
```

Use `:verbose set {option}?` to see where an option was last set.

---

## Option Reference Table

Legend: **B** = boolean, **N** = number, **S** = string. Scope: **g** = global, **b** = buffer-local, **w** = window-local, **gl** = global-local.

### Display and UI

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `wrap` | | B | w | `on` | Wrap long lines (display only, does not alter text) |
| `linebreak` | `lbr` | B | w | `off` | Wrap at `breakat` chars instead of mid-word |
| `showbreak` | `sbr` | S | gl | `""` | String shown at the start of wrapped lines |
| `breakindent` | `bri` | B | w | `off` | Wrapped lines continue visually indented |
| `cursorline` | `cul` | B | w | `off` | Highlight the line of the cursor |
| `cursorcolumn` | `cuc` | B | w | `off` | Highlight the column of the cursor |
| `signcolumn` | `scl` | S | w | `"auto"` | When/how to draw the sign column: `"auto"`, `"yes"`, `"no"`, `"yes:N"`, `"auto:N-M"`, `"number"` |
| `colorcolumn` | `cc` | S | w | `""` | Comma-separated list of highlighted screen columns (e.g. `"80"`, `"+1"`) |
| `lazyredraw` | `lz` | B | g | `off` | Don't redraw screen while executing macros/registers |
| `redrawtime` | `rdt` | N | g | `2000` | Max time (ms) for syntax highlighting/redrawing |
| `title` | | B | g | `off` | Set terminal window title |
| `titlestring` | | S | g | `""` | Custom window title format |
| `smoothscroll` | `sms` | B | w | `off` | Scroll by screen lines (not text lines) when `wrap` is on |

### Line Numbers

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `number` | `nu` | B | w | `off` | Show absolute line numbers |
| `relativenumber` | `rnu` | B | w | `off` | Show relative line numbers |
| `numberwidth` | `nuw` | N | w | `4` | Minimum columns for line number gutter |

### Indentation and Tabs

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `expandtab` | `et` | B | b | `off` | Insert spaces instead of tab characters |
| `tabstop` | `ts` | N | b | `8` | Number of columns a `<Tab>` counts for |
| `shiftwidth` | `sw` | N | b | `8` | Columns per indent level (0 = use `tabstop`) |
| `softtabstop` | `sts` | N | b | `0` | Columns for `<Tab>` in insert mode (0 = off, negative = use `shiftwidth`) |
| `autoindent` | `ai` | B | b | `on` | Copy indent from current line when starting a new line |
| `smartindent` | `si` | B | b | `off` | Smart autoindenting for C-like programs |

### Search

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `ignorecase` | `ic` | B | g | `off` | Ignore case in search patterns |
| `smartcase` | `scs` | B | g | `off` | Override `ignorecase` if pattern has uppercase chars |
| `incsearch` | `is` | B | g | `on` | Show matches incrementally while typing search |
| `hlsearch` | `hls` | B | g | `on` | Highlight all matches of the last search pattern |
| `inccommand` | `icm` | S | g | `"nosplit"` | Live preview for `:substitute` and friends: `""`, `"nosplit"`, `"split"` |
| `wrapscan` | `ws` | B | g | `on` | Searches wrap around end of file |

### Folding

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `foldmethod` | `fdm` | S | w | `"manual"` | Folding mode: `"manual"`, `"indent"`, `"expr"`, `"marker"`, `"syntax"`, `"diff"` |
| `foldlevel` | `fdl` | N | w | `0` | Folds above this level are closed (set to `99` to open all) |

### Completion

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `completeopt` | `cot` | S | gl | `"menu,popup"` | Completion behavior flags: `"menu"`, `"menuone"`, `"longest"`, `"preview"`, `"popup"`, `"noinsert"`, `"noselect"`, `"fuzzy"` |
| `pumheight` | `ph` | N | g | `0` | Max items in popup menu (0 = use available space) |
| `omnifunc` | `ofu` | S | b | `""` | Function for omni completion (`<C-x><C-o>`) |
| `completefunc` | `cfu` | S | b | `""` | Function for user-defined completion (`<C-x><C-u>`) |

### Splits and Windows

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `splitbelow` | `sb` | B | g | `off` | New horizontal splits go below current window |
| `splitright` | `spr` | B | g | `off` | New vertical splits go right of current window |
| `splitkeep` | `spk` | S | g | `"cursor"` | Scroll behavior when splitting: `"cursor"`, `"screen"`, `"topline"` |
| `winminheight` | `wmh` | N | g | `1` | Minimum height of non-current windows |
| `winminwidth` | `wmw` | N | g | `1` | Minimum width of non-current windows |

### Buffers and Files

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `hidden` | `hid` | B | g | `on` | Allow switching buffers without saving (keeps undo) |
| `autoread` | `ar` | B | gl | `on` | Auto-reload file when changed outside Neovim |
| `autowrite` | `aw` | B | g | `off` | Auto-write buffer when switching away |
| `confirm` | `cf` | B | g | `off` | Prompt to save on `:q` of modified buffer instead of failing |

### Backup, Swap, Undo

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `backup` | `bk` | B | g | `off` | Keep backup file after overwriting |
| `backupdir` | `bdir` | S | g | `".,$XDG_STATE_HOME/nvim/backup//"` | Directories for backup files |
| `swapfile` | `swf` | B | b | `on` | Use a swapfile for the buffer |
| `directory` | `dir` | S | g | `"$XDG_STATE_HOME/nvim/swap//"` | Directories for swap files |
| `undofile` | `udf` | B | b | `off` | Persist undo history to a file |
| `undodir` | `udir` | S | g | `"$XDG_STATE_HOME/nvim/undo//"` | Directories for undo files |

### Input and Mouse

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `mouse` | | S | g | `"nvi"` | Enable mouse in modes: `"n"`, `"v"`, `"i"`, `"c"`, `"a"` (all) |
| `clipboard` | `cb` | S | g | `""` | System clipboard integration: `"unnamed"` (use `*`), `"unnamedplus"` (use `+`) |
| `backspace` | `bs` | S | g | `"indent,eol,start"` | What `<BS>` can delete in insert mode |
| `virtualedit` | `ve` | S | gl | `""` | Allow cursor beyond end of line: `"block"`, `"insert"`, `"all"`, `"onemore"`, `"none"` |
| `selection` | `sel` | S | g | `"inclusive"` | Selection behavior: `"inclusive"`, `"exclusive"`, `"old"` |
| `selectmode` | `slm` | S | g | `""` | When to use Select mode instead of Visual |
| `keymodel` | `km` | S | g | `""` | Enable special shift-key selection behavior |
| `startofline` | `sol` | B | g | `off` | Move cursor to first non-blank on line jumps |
| `whichwrap` | `ww` | S | g | `"b,s"` | Keys that wrap to next/prev line at line edges |

### Timing

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `updatetime` | `ut` | N | g | `4000` | Milliseconds of idle before swap write and `CursorHold` event |
| `timeoutlen` | `tm` | N | g | `1000` | Milliseconds to wait for a mapped key sequence |
| `matchtime` | `mat` | N | g | `5` | Tenths of a second to show matching paren (when `showmatch` on) |

### Scrolling

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `scrolloff` | `so` | N | gl | `0` | Min lines to keep above/below cursor |
| `sidescrolloff` | `siso` | N | gl | `0` | Min columns to keep left/right of cursor (with `nowrap`) |

### Whitespace Visualization

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `list` | | B | w | `off` | Show tabs, trailing spaces, and other invisible chars |
| `listchars` | `lcs` | S | gl | `"tab:> ,trail:-,nbsp:+"` | Characters to display in `list` mode |
| `fillchars` | `fcs` | S | gl | `""` | Characters for statuslines, separators, folds, diffs, etc. |
| `conceallevel` | `cole` | N | w | `0` | How to show concealed text: `0`=show, `1`=replace with one char, `2`=hide unless replacement, `3`=fully hide |

### Spell Checking

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `spell` | | B | w | `off` | Enable spell checking |
| `spelllang` | `spl` | S | b | `"en"` | Comma-separated list of spell-check languages |

### Filetype and Syntax

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `filetype` | `ft` | S | b | `""` | Detected filetype (triggers `FileType` autocommand) |
| `syntax` | `syn` | S | b | `""` | Syntax highlighting name to load |

### File Encoding

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `fileencoding` | `fenc` | S | b | `""` | File content encoding for current buffer (empty = `encoding`) |
| `fileformat` | `ff` | S | b | Unix: `"unix"` | EOL style: `"unix"` (LF), `"dos"` (CRLF), `"mac"` (CR) |

### Text Formatting

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `textwidth` | `tw` | N | b | `0` | Max line width for auto-formatting (0 = off) |
| `formatoptions` | `fo` | S | b | `"tcqj"` | Flags controlling auto-format behavior (see `:help fo-table`) |
| `comments` | `com` | S | b | `"s1:/*,mb:*,ex:*/,://,b:#,..."` | Patterns for comment leaders |
| `commentstring` | `cms` | S | b | `""` | Template for comment wrapping (`"%s"` is replaced) |

### Command Line and Wildmenu

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `wildmenu` | `wmnu` | B | g | `on` | Enhanced command-line completion with visual menu |
| `wildmode` | `wim` | S | g | `"full"` | Completion mode: `"full"`, `"longest"`, `"list"`, `"lastused"`, or colon-separated combo |
| `wildoptions` | `wop` | S | g | `"pum,tagfile"` | Completion options: `"fuzzy"`, `"pum"` (popup), `"tagfile"` |
| `cmdheight` | `ch` | N | g | `1` | Number of lines for command-line area (0 = hide when not in use) |

### Status Line and Tab Line

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `laststatus` | `ls` | N | g | `2` | When to show statusline: `0`=never, `1`=if 2+ windows, `2`=always, `3`=global statusline |
| `statusline` | `stl` | S | gl | (long default) | Format string for the status line (see `:help statusline`) |
| `showtabline` | `stal` | N | g | `1` | When to show tabline: `0`=never, `1`=if 2+ tabs, `2`=always |
| `tabline` | `tal` | S | g | `""` | Custom tab page line format |
| `winbar` | `wbr` | S | gl | `""` | Window bar format (like statusline but at top of window) |
| `showmode` | `smd` | B | g | `on` | Show `-- INSERT --` etc. in last line |
| `showcmd` | `sc` | B | g | `on` | Show partial command in last line |
| `ruler` | `ru` | B | g | `on` | Show cursor position in statusline |
| `showmatch` | `sm` | B | g | `off` | Briefly jump to matching bracket on insert |

### Transparency and Blending

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `winblend` | `winbl` | N | w | `0` | Pseudo-transparency for floating windows (0-100) |
| `pumblend` | `pb` | N | g | `0` | Pseudo-transparency for popup menu (0-100) |

### Messages

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `shortmess` | `shm` | S | g | `"ltToOCF"` | Flags to shorten messages and avoid hit-enter prompts (see `:help shortmess`) |

### Security and Modeline

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `modeline` | `ml` | B | b | `on` (off for root) | Parse modelines in files |
| `modelines` | `mls` | N | g | `5` | Number of lines checked for modelines at start/end of file |
| `exrc` | `ex` | B | g | `off` | Execute `.nvim.lua` / `.exrc` / `.nvimrc` in current directory (use `:trust`) |

### Terminal and Color

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `termguicolors` | `tgc` | B | g | `off` | Enable 24-bit RGB color in TUI (uses `gui` highlight attrs) |

### Cursor Appearance

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `guicursor` | `gcr` | S | g | `"n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,..."` | Cursor shape/blink per mode |

### Miscellaneous

| Option | Abbr | Type | Scope | Default | Description |
|--------|------|------|-------|---------|-------------|
| `grepprg` | `gp` | S | gl | (platform-dependent) | External program for `:grep` |
| `grepformat` | `gfm` | S | gl | `"%f:%l:%m,%f:%l%m,..."` | Format of `:grep` output |
| `makeprg` | `mp` | S | gl | `"make"` | Program for `:make` |
| `path` | `pa` | S | gl | `".,,,"` | Directories to search with `gf`, `:find`, etc. |
| `tagfunc` | `tfu` | S | b | `""` | Function for custom tag lookups |
| `operatorfunc` | `opfunc` | S | g | `""` | Function called by `g@` operator |

---

> **Note:** This file covers ~90 commonly-used options. Neovim has many more.
> Run `:help option-list` for the full index, or grep the source:
> `$VIMRUNTIME/doc/options.txt`
