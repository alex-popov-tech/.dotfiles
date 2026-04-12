# Syntax & Highlights

> Curated reference from `:help syntax.txt`, `:help api.txt`, `:help treesitter.txt`, and `:help vimfn.txt`.

## Table of Contents

- [nvim_set_hl() API](#nvim_set_hl-api)
- [nvim_get_hl() API](#nvim_get_hl-api)
- [Highlight Attributes](#highlight-attributes)
- [:highlight Command](#highlight-command)
- [Highlight Group Linking](#highlight-group-linking)
- [Default Highlight Groups (Editor)](#default-highlight-groups-editor)
- [Default Highlight Groups (Syntax)](#default-highlight-groups-syntax)
- [Treesitter Highlight Groups](#treesitter-highlight-groups)
- [:syntax Command Basics](#syntax-command-basics)
- [matchadd() / matchdelete() / matchaddpos()](#matchadd--matchdelete--matchaddpos)
- [Group Naming Conventions](#group-naming-conventions)
- [Colorscheme Commands](#colorscheme-commands)

---

## nvim_set_hl() API

Sets a highlight group. **Unlike `:highlight`, this completely replaces the definition** -- it does not merge with existing attributes.

```lua
vim.api.nvim_set_hl(ns_id, name, val)
```

**Parameters:**

| Param | Type | Description |
|-------|------|-------------|
| `ns_id` | `integer` | Namespace id (`0` for global). Non-global namespaces require `nvim_set_hl_ns()` or `nvim_win_set_hl_ns()` to activate. |
| `name` | `string` | Highlight group name, e.g. `"ErrorMsg"` |
| `val` | `table` | Highlight definition map (see below) |

**Highlight definition keys (`val`):**

| Key | Type | Description |
|-----|------|-------------|
| `fg` | `string` | Foreground color: name or `"#RRGGBB"`. Also accepts `"fg"` / `"bg"` to alias Normal group colors. |
| `bg` | `string` | Background color: name or `"#RRGGBB"`. Same alias support as `fg`. |
| `sp` | `string` | Special color (used for underlines): name or `"#RRGGBB"` |
| `blend` | `integer` | Opacity blend (0-100), used with `pumblend` / `winblend` |
| `bold` | `boolean` | Bold text |
| `italic` | `boolean` | Italic text |
| `underline` | `boolean` | Underline |
| `undercurl` | `boolean` | Curly underline (falls back to underline) |
| `underdouble` | `boolean` | Double underline |
| `underdotted` | `boolean` | Dotted underline |
| `underdashed` | `boolean` | Dashed underline |
| `strikethrough` | `boolean` | Strikethrough text |
| `reverse` | `boolean` | Reverse fg/bg |
| `standout` | `boolean` | Standout mode |
| `nocombine` | `boolean` | Override rather than combine attributes |
| `link` | `string` | Link to another highlight group. **If `link` is set, all other attributes are ignored.** |
| `default` | `boolean` | Don't override existing definition |
| `ctermfg` | `integer\|string` | Terminal foreground color |
| `ctermbg` | `integer\|string` | Terminal background color |
| `cterm` | `table` | Terminal attribute map (if unset, mirrors gui attributes) |
| `force` | `boolean` | Force update if the group already exists |
| `fg_indexed` | `boolean` | Treat `fg` as terminal palette index (0-255) |
| `bg_indexed` | `boolean` | Treat `bg` as terminal palette index (0-255) |

**Examples:**

```lua
-- Set a custom highlight group
vim.api.nvim_set_hl(0, "MyGroup", { fg = "#ff0000", bg = "#000000", bold = true })

-- Link one group to another
vim.api.nvim_set_hl(0, "MyGroup", { link = "Comment" })

-- Clear a highlight group
vim.api.nvim_set_hl(0, "Visual", {})

-- Set with special (underline) color
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff0000" })

-- Default: only applies if not already defined
vim.api.nvim_set_hl(0, "MyGroup", { fg = "Red", default = true })
```

### nvim_set_hl_ns()

Activate a non-global highlight namespace:

```lua
vim.api.nvim_set_hl_ns(ns_id)
```

### nvim_win_set_hl_ns()

Activate a highlight namespace for a specific window (takes precedence over `winhighlight`):

```lua
vim.api.nvim_win_set_hl_ns(window, ns_id)
```

---

## nvim_get_hl() API

Gets all or specific highlight groups in a namespace.

```lua
vim.api.nvim_get_hl(ns_id, opts)
```

**Parameters:**

| Param | Type | Description |
|-------|------|-------------|
| `ns_id` | `integer` | Namespace (`0` for global) |
| `opts.name` | `string?` | Get a highlight definition by name |
| `opts.id` | `integer?` | Get a highlight definition by id |
| `opts.link` | `boolean?` | Show linked group name instead of effective definition (default `true`) |
| `opts.create` | `boolean?` | Create group if it doesn't exist (default `true`) |

**Returns** a map from group name to highlight definition map (same keys as `nvim_set_hl()`), or a single definition map if requested by name or id.

```lua
-- Get a specific group
local hl = vim.api.nvim_get_hl(0, { name = "Comment" })
-- hl = { fg = 7110911, italic = true }  (fg is integer color value)

-- Get all groups
local all = vim.api.nvim_get_hl(0, {})
```

---

## Highlight Attributes

Two UI categories exist for highlighting:

- **cterm** -- terminal UI (TUI)
- **gui** -- GUI or RGB-capable TUI (`termguicolors`)

### Attribute List

Used in both `cterm={attr-list}` and `gui={attr-list}`:

| Attribute | Description |
|-----------|-------------|
| `bold` | Bold text |
| `underline` | Underline |
| `undercurl` | Curly underline (color set via `guisp`) |
| `underdouble` | Double underline |
| `underdotted` | Dotted underline |
| `underdashed` | Dashed underline |
| `strikethrough` | Strikethrough |
| `reverse` / `inverse` | Swap fg/bg |
| `italic` | Italic |
| `standout` | Standout mode |
| `altfont` | Alternative font |
| `nocombine` | Override attributes instead of combining |
| `NONE` | No attributes (reset) |

`undercurl`, `underdouble`, `underdotted`, and `underdashed` fall back to `underline` in terminals that do not support them. Their color is set using `guisp`.

### GUI Color Keys

| Key | Description |
|-----|-------------|
| `guifg` | Foreground color |
| `guibg` | Background color |
| `guisp` | Special color (used for underlines) |

Special values: `NONE` (transparent), `fg`/`foreground`, `bg`/`background`.

Colors can be specified as names (e.g., `Red`, `DarkBlue`) or hex `#RRGGBB`.

### Nvim Default Color Palette

Colors that define the Nvim default color scheme:

```
NvimDarkBlue    NvimLightBlue
NvimDarkCyan    NvimLightCyan
NvimDarkGray1   NvimLightGray1
NvimDarkGray2   NvimLightGray2
NvimDarkGray3   NvimLightGray3
NvimDarkGray4   NvimLightGray4
NvimDarkGreen   NvimLightGreen
NvimDarkMagenta NvimLightMagenta
NvimDarkRed     NvimLightRed
NvimDarkYellow  NvimLightYellow
```

---

## :highlight Command

```vim
:hi[ghlight]                            " List all groups with attributes
:hi[ghlight] {group}                    " List one group
:hi[ghlight] clear                      " Reset all to defaults
:hi[ghlight] clear {group}              " Disable highlighting for group
:hi[ghlight] {group} NONE              " Same as clear {group}

:hi[ghlight] [default] {group} {key}={arg} ...
                                        " Add/change a highlight group
```

The `[default]` argument makes the command only take effect if the group has no existing settings. Useful in syntax files to allow user overrides.

**Examples:**

```vim
:hi Comment gui=bold
:hi Comment ctermfg=Cyan guifg=#80a0ff gui=bold
:hi Normal guibg=Black guifg=White
:highlight Visual ctermfg=bg ctermbg=fg
```

Use `:verbose hi Comment` to see where a group was last defined.

---

## Highlight Group Linking

Link one group to another so they share the same highlighting:

```vim
:hi[ghlight][!] [default] link {from-group} {to-group}
:hi[ghlight][!] [default] link {from-group} NONE        " remove link
```

**Notes:**
- If `{from-group}` already has highlight settings, the link is not made unless `!` is given.
- Using `:highlight` directly on a linked group removes the link.
- `[default]` link can be overridden by user config; survives `:highlight clear` when set with `highlight! default link`.

```vim
" In a syntax file (allows user override):
:highlight default link cComment Comment

" User override in vimrc:
:highlight link cComment Question
```

Lua equivalent:

```lua
-- Link
vim.api.nvim_set_hl(0, "cComment", { link = "Comment" })

-- Default link (won't override existing)
vim.api.nvim_set_hl(0, "cComment", { link = "Comment", default = true })
```

---

## Default Highlight Groups (Editor)

Built-in editor highlight groups (depends on `background` setting):

| Group | Description |
|-------|-------------|
| `Normal` | Normal text |
| `NormalFloat` | Normal text in floating windows |
| `NormalNC` | Normal text in non-current windows |
| `FloatBorder` | Border of floating windows |
| `FloatTitle` | Title of floating windows |
| `FloatFooter` | Footer of floating windows |
| `Cursor` | Character under the cursor |
| `CursorLine` | Screen-line at cursor (when `cursorline` set) |
| `CursorColumn` | Screen-column at cursor (when `cursorcolumn` set) |
| `CursorLineNr` | Line number for cursor line |
| `LineNr` | Line numbers |
| `LineNrAbove` | Relative line numbers above cursor |
| `LineNrBelow` | Relative line numbers below cursor |
| `Visual` | Visual mode selection |
| `VisualNOS` | Visual mode when not owning selection |
| `Search` | Last search pattern highlighting (`hlsearch`) |
| `IncSearch` | Incremental search highlighting |
| `CurSearch` | Current match for last search pattern |
| `Substitute` | `:substitute` replacement text |
| `MatchParen` | Matching bracket under cursor |
| `Pmenu` | Popup menu: normal item |
| `PmenuSel` | Popup menu: selected item |
| `PmenuKind` | Popup menu: item "kind" |
| `PmenuKindSel` | Popup menu: selected item "kind" |
| `PmenuExtra` | Popup menu: item "extra text" |
| `PmenuExtraSel` | Popup menu: selected "extra text" |
| `PmenuSbar` | Popup menu: scrollbar |
| `PmenuThumb` | Popup menu: scrollbar thumb |
| `PmenuMatch` | Popup menu: matched text |
| `PmenuMatchSel` | Popup menu: matched text (selected) |
| `PmenuBorder` | Popup menu: border |
| `ComplMatchIns` | Matched text of currently inserted completion |
| `StatusLine` | Status line of current window |
| `StatusLineNC` | Status line of non-current windows |
| `StatusLineTerm` | Status line of terminal window |
| `StatusLineTermNC` | Status line of non-current terminal windows |
| `TabLine` | Tab page line: inactive tab |
| `TabLineFill` | Tab page line: empty area |
| `TabLineSel` | Tab page line: active tab |
| `WinBar` | Window bar of current window |
| `WinBarNC` | Window bar of non-current windows |
| `WinSeparator` | Window split separators |
| `ColorColumn` | Columns set with `colorcolumn` |
| `Conceal` | Placeholder for concealed text |
| `Directory` | Directory names in listings |
| `EndOfBuffer` | Filler lines (`~`) after last buffer line |
| `Folded` | Closed fold line |
| `FoldColumn` | Fold column |
| `SignColumn` | Sign column |
| `DiffAdd` | Diff: added line |
| `DiffChange` | Diff: changed line |
| `DiffDelete` | Diff: deleted line |
| `DiffText` | Diff: changed text within a changed line |
| `DiffTextAdd` | Diff: added text within a changed line |
| `SpellBad` | Unrecognized word |
| `SpellCap` | Word that should be capitalized |
| `SpellLocal` | Word from another region |
| `SpellRare` | Rarely used word |
| `ErrorMsg` | Error messages |
| `WarningMsg` | Warning messages |
| `OkMsg` | Success messages |
| `ModeMsg` | `showmode` message (e.g., `-- INSERT --`) |
| `MsgArea` | Message/command-line area |
| `MsgSeparator` | Separator for scrolled messages |
| `MoreMsg` | More-prompt |
| `Question` | Hit-enter prompt and yes/no questions |
| `NonText` | `@` at end of window, `showbreak` chars |
| `Whitespace` | Listchars whitespace characters |
| `SpecialKey` | Unprintable characters |
| `Title` | Titles for `:set all`, `:autocmd`, etc. |
| `WildMenu` | Current match in wildmenu completion |
| `QuickFixLine` | Current quickfix item |
| `TermCursor` | Cursor in a focused terminal |
| `SnippetTabstop` | Tabstops in snippets |

---

## Default Highlight Groups (Syntax)

Standard syntax group names (not case sensitive). Language-specific groups should link to these:

| Group | Description |
|-------|-------------|
| **`Comment`** | Any comment |
| **`Constant`** | Any constant |
| `String` | String constant: `"this is a string"` |
| `Character` | Character constant: `'c'`, `'\n'` |
| `Number` | Number constant: `234`, `0xff` |
| `Boolean` | Boolean constant: `TRUE`, `false` |
| `Float` | Floating point constant: `2.3e10` |
| **`Identifier`** | Any variable name |
| `Function` | Function name (also methods) |
| **`Statement`** | Any statement |
| `Conditional` | `if`, `then`, `else`, `endif`, `switch` |
| `Repeat` | `for`, `do`, `while` |
| `Label` | `case`, `default` |
| `Operator` | `sizeof`, `+`, `*` |
| `Keyword` | Any other keyword |
| `Exception` | `try`, `catch`, `throw` |
| **`PreProc`** | Generic preprocessor |
| `Include` | Preprocessor `#include` |
| `Define` | Preprocessor `#define` |
| `Macro` | Same as Define |
| `PreCondit` | Preprocessor `#if`, `#else`, `#endif` |
| **`Type`** | `int`, `long`, `char` |
| `StorageClass` | `static`, `register`, `volatile` |
| `Structure` | `struct`, `union`, `enum` |
| `Typedef` | A typedef |
| **`Special`** | Any special symbol |
| `SpecialChar` | Special character in a constant |
| `Tag` | You can use CTRL-] on this |
| `Delimiter` | Character that needs attention |
| `SpecialComment` | Special things inside a comment |
| `Debug` | Debugging statements |
| **`Underlined`** | Text that stands out, HTML links |
| **`Ignore`** | Left blank, hidden |
| **`Error`** | Any erroneous construct |
| **`Todo`** | `TODO`, `FIXME`, `XXX` |
| **`Added`** | Added line in a diff |
| **`Changed`** | Changed line in a diff |
| **`Removed`** | Removed line in a diff |

Bold entries are the top-level groups; others are sub-groups that typically link to them.

**Reserved names** (cannot be used as group names): `NONE`, `ALL`, `ALLBUT`, `contains`, `contained`.

---

## Treesitter Highlight Groups

Treesitter capture names, prefixed with `@`, are directly usable as highlight groups. They are linked to standard `highlight-groups` by default but can be overridden.

### Fallback System

More specific groups fall back to more generic ones. For example, `@comment.documentation` falls back to `@comment` if not defined.

Captures can also be specialized **by language** with an additional dot suffix:

```vim
hi @comment.c guifg=Blue
hi @comment.lua guifg=DarkBlue
hi link @comment.documentation.java String
```

### Standard Treesitter Captures

**Variables:**

| Capture | Description |
|---------|-------------|
| `@variable` | Various variable names |
| `@variable.builtin` | Built-in variables (`this`, `self`) |
| `@variable.parameter` | Function parameters |
| `@variable.parameter.builtin` | Special parameters (`_`, `it`) |
| `@variable.member` | Object and struct fields |

**Constants:**

| Capture | Description |
|---------|-------------|
| `@constant` | Constant identifiers |
| `@constant.builtin` | Built-in constants |
| `@constant.macro` | Preprocessor constants |

**Modules & Labels:**

| Capture | Description |
|---------|-------------|
| `@module` | Modules or namespaces |
| `@module.builtin` | Built-in modules |
| `@label` | GOTO labels, heredoc labels |

**Strings:**

| Capture | Description |
|---------|-------------|
| `@string` | String literals |
| `@string.documentation` | Documenting strings (e.g., Python docstrings) |
| `@string.regexp` | Regular expressions |
| `@string.escape` | Escape sequences |
| `@string.special` | Other special strings (e.g., dates) |
| `@string.special.symbol` | Symbols or atoms |
| `@string.special.path` | Filenames |
| `@string.special.url` | URIs / hyperlinks |

**Literals:**

| Capture | Description |
|---------|-------------|
| `@character` | Character literals |
| `@character.special` | Special characters (e.g., wildcards) |
| `@boolean` | Boolean literals |
| `@number` | Numeric literals |
| `@number.float` | Floating-point literals |

**Types:**

| Capture | Description |
|---------|-------------|
| `@type` | Type/class definitions and annotations |
| `@type.builtin` | Built-in types |
| `@type.definition` | Identifiers in type definitions |
| `@attribute` | Attribute annotations (decorators, lifetimes) |
| `@attribute.builtin` | Builtin annotations (`@property`) |
| `@property` | Key in key/value pairs |

**Functions:**

| Capture | Description |
|---------|-------------|
| `@function` | Function definitions |
| `@function.builtin` | Built-in functions |
| `@function.call` | Function calls |
| `@function.macro` | Preprocessor macros |
| `@function.method` | Method definitions |
| `@function.method.call` | Method calls |
| `@constructor` | Constructor calls/definitions |
| `@operator` | Symbolic operators (`+`, `*`) |

**Keywords:**

| Capture | Description |
|---------|-------------|
| `@keyword` | General keywords |
| `@keyword.coroutine` | Coroutine keywords (`go`, `async`, `await`) |
| `@keyword.function` | Function-defining keywords (`func`, `def`) |
| `@keyword.operator` | English-word operators (`and`, `or`) |
| `@keyword.import` | Import/export keywords |
| `@keyword.type` | Namespace/composite type keywords (`struct`, `enum`) |
| `@keyword.modifier` | Modifiers (`const`, `static`, `public`) |
| `@keyword.repeat` | Loop keywords (`for`, `while`) |
| `@keyword.return` | `return`, `yield` |
| `@keyword.debug` | Debugging keywords |
| `@keyword.exception` | Exception keywords (`throw`, `catch`) |
| `@keyword.conditional` | Conditional keywords (`if`, `else`) |
| `@keyword.conditional.ternary` | Ternary operator (`?`, `:`) |
| `@keyword.directive` | Preprocessor directives, shebangs |
| `@keyword.directive.define` | Preprocessor definition directives |

**Punctuation:**

| Capture | Description |
|---------|-------------|
| `@punctuation.delimiter` | Delimiters (`;`, `.`, `,`) |
| `@punctuation.bracket` | Brackets (`()`, `{}`, `[]`) |
| `@punctuation.special` | Special symbols (`{}` in interpolation) |

**Comments:**

| Capture | Description |
|---------|-------------|
| `@comment` | Line and block comments |
| `@comment.documentation` | Documentation comments |
| `@comment.error` | Error-type comments (`ERROR`, `FIXME`, `DEPRECATED`) |
| `@comment.warning` | Warning-type comments (`WARNING`, `FIX`, `HACK`) |
| `@comment.todo` | Todo-type comments (`TODO`, `WIP`) |
| `@comment.note` | Note-type comments (`NOTE`, `INFO`, `XXX`) |

**Markup:**

| Capture | Description |
|---------|-------------|
| `@markup.strong` | Bold text |
| `@markup.italic` | Italic text |
| `@markup.strikethrough` | Struck-through text |
| `@markup.underline` | Underlined text (literal markup only) |
| `@markup.heading` | Headings/titles |
| `@markup.heading.1` through `.6` | Heading levels 1-6 |
| `@markup.quote` | Block quotes |
| `@markup.math` | Math environments |
| `@markup.link` | Text references, footnotes, citations |
| `@markup.link.label` | Link/reference descriptions |
| `@markup.link.url` | URL-style links |
| `@markup.raw` | Inline code / verbatim text |
| `@markup.raw.block` | Code blocks |
| `@markup.list` | List markers |
| `@markup.list.checked` | Checked todo list markers |
| `@markup.list.unchecked` | Unchecked todo list markers |

**Diff:**

| Capture | Description |
|---------|-------------|
| `@diff.plus` | Added text |
| `@diff.minus` | Deleted text |
| `@diff.delta` | Changed text |

**Tags (XML/HTML):**

| Capture | Description |
|---------|-------------|
| `@tag` | Tag names |
| `@tag.builtin` | Builtin tag names (HTML5) |
| `@tag.attribute` | Tag attributes |
| `@tag.delimiter` | Tag delimiters |

**Special captures:** `@spell` (enable spell check), `@nospell` (disable spell check on `@spell` regions).

### Treesitter Highlight Priority

Treesitter highlights use `nvim_buf_set_extmark()` with a default priority of **100**. Override per-query pattern:

```query
((super_important_node) @superimportant (#set! priority 105))
```

---

## :syntax Command Basics

### syntax keyword

Defines keywords that match whole words only. Keywords always have higher priority than match/region.

```vim
:syntax keyword {group-name} [{options}] {keyword} ... [{options}]
```

```vim
:syntax keyword Type int long char
:syntax keyword vimCommand ab[breviate] n[ext]   " optional tail in []
:syntax keyword Type contained int long char      " options anywhere in line
```

Max keyword length: 80 characters.

### syntax match

Defines a single regex pattern match.

```vim
:syntax match {group-name} [{options}] [excludenl] [keepend] {pattern} [{options}]
```

```vim
:syntax match Character /'.'/hs=s+1,he=e-1
```

### syntax region

Defines a region between start and end patterns, optionally with a skip pattern.

```vim
:syntax region {group-name} [{options}]
    [matchgroup={group-name}]
    [keepend] [extend] [excludenl]
    start={start-pattern} ...
    [skip={skip-pattern}]
    end={end-pattern} ...
    [{options}]
```

```vim
:syntax region String start=+"+ skip=+\\"+ end=+"+
:syntax region String matchgroup=Quote start=+"+ skip=+\\"+ end=+"+
```

### Priority Rules

1. When multiple Match or Region items start at the same position, the **last defined** wins.
2. A **Keyword** always has priority over Match and Region.
3. An item starting at an **earlier position** has priority over later ones.

### Other :syntax Commands

```vim
:syntax enable                " Enable syntax highlighting
:syntax on                    " Same as enable
:syntax off                   " Disable syntax highlighting
:syntax clear                 " Clear syntax for current buffer
:syntax clear {group} ...     " Clear specific groups
:syntax reset                 " Reset highlight colors to defaults
:syntax list                  " List all syntax items
:syntax list {group}          " List items for one group
:syntax case match            " Case-sensitive matching
:syntax case ignore           " Case-insensitive matching
```

---

## matchadd() / matchdelete() / matchaddpos()

Window-local pattern highlighting that always overrules syntax highlighting regardless of priority.

### matchadd()

```lua
-- Vimscript signature:
-- matchadd({group}, {pattern} [, {priority} [, {id} [, {dict}]]])
```

```lua
-- Lua:
local id = vim.fn.matchadd("MyGroup", "TODO")
-- With priority (default is 10; hlsearch priority is 0):
local id = vim.fn.matchadd("MyGroup", "TODO", 15)
```

```vim
" Vimscript:
highlight MyGroup ctermbg=green guibg=green
let m = matchadd("MyGroup", "TODO")
call matchdelete(m)
```

**Parameters:**
- `{group}` -- highlight group name (use `"Conceal"` for concealment)
- `{pattern}` -- regex pattern (case sensitive, magic; ignores `magic`/`smartcase`/`ignorecase` options)
- `{priority}` -- integer, default `10`. Higher overrules lower. `hlsearch` is `0`.
- `{id}` -- specific match ID (positive integer, or `-1` for auto). IDs 1-3 are reserved.
- `{dict}` -- optional: `{ conceal = "X", window = win_id }`

Returns match ID (integer), or `-1` on error.

### matchaddpos()

Same as `matchadd()` but takes a list of positions instead of a pattern. **Faster** because it skips regex processing.

```lua
-- Vimscript signature:
-- matchaddpos({group}, {pos} [, {priority} [, {id} [, {dict}]]])
```

Position formats in `{pos}`:
- `23` -- whole line 23
- `[23]` -- whole line 23
- `[23, 11]` -- line 23, column 11 (byte index), single character
- `[23, 11, 3]` -- line 23, column 11, length 3 bytes

```vim
highlight MyGroup ctermbg=green guibg=green
let m = matchaddpos("MyGroup", [[23, 24], 34])
call matchdelete(m)
```

### matchdelete()

```lua
-- matchdelete({id} [, {win}])
vim.fn.matchdelete(id)         -- current window
vim.fn.matchdelete(id, win)    -- specific window
```

Returns `0` on success, `-1` on failure. Use `clearmatches()` to delete all matches at once.

---

## Group Naming Conventions

- Group names: ASCII letters, digits, underscores, dots, hyphens, or `@`. Regex: `[a-zA-Z0-9_.@-]*`. Max ~200 bytes.
- Group names are **not case sensitive** (`String` == `string`).
- Language-specific syntax groups should be prefixed with the language name (e.g., `cComment`, `pythonString`), then linked to a standard group.
- Treesitter groups use `@` prefix with dots for hierarchy (e.g., `@keyword.function.lua`).

---

## Colorscheme Commands

```vim
:colorscheme              " Show current colorscheme name
:colorscheme {name}       " Load colorscheme from colors/{name}.{vim,lua}
```

Events: `ColorSchemePre` fires before loading, `ColorScheme` fires after.

To customize an existing colorscheme:

```vim
" ~/.config/nvim/colors/mine.vim
runtime colors/evening.vim
hi Statement ctermfg=Blue guifg=Blue
```
