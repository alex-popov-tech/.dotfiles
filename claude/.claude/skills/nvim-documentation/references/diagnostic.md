# Diagnostics

Nvim provides a framework for displaying errors or warnings from external tools, otherwise known as "diagnostics". These diagnostics can come from a variety of sources, such as linters or LSP servers. The diagnostic framework is an extension to existing error handling functionality such as the quickfix list.

## Quickstart

Diagnostic producers need only follow a few simple steps to report diagnostics:

1. Create a namespace `nvim_create_namespace()`. Note that the namespace must have a name. Anonymous namespaces WILL NOT WORK.
2. (Optional) Configure options for the diagnostic namespace `vim.diagnostic.config()`.
3. Generate diagnostics.
4. Set the diagnostics for the buffer `vim.diagnostic.set()`.
5. Repeat from step 3.

The API is split between functions meant to be used by diagnostic producers and those meant for diagnostic consumers. The APIs for producers require a `{namespace}` as their first argument, while those for consumers generally do not require a namespace (though often one may be optionally supplied).

### Severity

The `severity` key in a diagnostic is one of the values defined in `vim.diagnostic.severity`:

```lua
vim.diagnostic.severity.ERROR
vim.diagnostic.severity.WARN
vim.diagnostic.severity.INFO
vim.diagnostic.severity.HINT
```

Functions that take a severity as an optional parameter (e.g. `vim.diagnostic.get()`) accept one of three forms:

1. A single `vim.diagnostic.severity` value:
```lua
vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
```

2. A table with a `min` or `max` key (or both) for a range of severities:
```lua
vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
```

3. A list-like table for filtering specific severities:
```lua
vim.diagnostic.get(0, { severity = {
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
} })
```

## Defaults

These diagnostic keymaps are created unconditionally when Nvim starts:

- `]d` jumps to the next diagnostic in the buffer.
- `[d` jumps to the previous diagnostic in the buffer.
- `]D` jumps to the last diagnostic in the buffer.
- `[D` jumps to the first diagnostic in the buffer.
- `<C-w>d` shows diagnostic at cursor in a floating window.

## Handlers

Diagnostics are shown to the user with `vim.diagnostic.show()`. The display of diagnostics is managed through handlers. A handler is a table with a `show` and (optionally) a `hide` function.

The `show` function has the signature:
```
function(namespace, bufnr, diagnostics, opts)
```

The `hide` function has the signature:
```
function(namespace, bufnr)
```

Handlers can be configured with `vim.diagnostic.config()` and added by creating a new key in `vim.diagnostic.handlers`.

The `{opts}` table passed to a handler is the full set of configuration options (not limited to just the options for the handler itself). The values in the table are already resolved (i.e. if a user specifies a function for a config option, the function has already been evaluated).

Nvim provides these handlers by default: `virtual_text`, `virtual_lines`, `signs`, and `underline`.

### Handler Example

```lua
-- It's good practice to namespace custom handlers to avoid collisions
vim.diagnostic.handlers["my/notify"] = {
  show = function(namespace, bufnr, diagnostics, opts)
    -- In our example, the opts table has a "log_level" option
    local level = opts["my/notify"].log_level

    local name = vim.diagnostic.get_namespace(namespace).name
    local msg = string.format("%d diagnostics in buffer %d from %s",
                              #diagnostics,
                              bufnr,
                              name)
    vim.notify(msg, level)
  end,
}

-- Users can configure the handler
vim.diagnostic.config({
  ["my/notify"] = {
    log_level = vim.log.levels.INFO,

    -- This handler will only receive "error" diagnostics.
    severity = vim.diagnostic.severity.ERROR,
  }
})
```

### Override Signs Handler Example

Show only a sign for the highest severity diagnostic on a given line:

```lua
local ns = vim.api.nvim_create_namespace("my_namespace")
local orig_signs_handler = vim.diagnostic.handlers.signs

vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, _, opts)
    local diagnostics = vim.diagnostic.get(bufnr)

    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end

    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,
  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}
```

### Toggle Virtual Lines Example

```lua
vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
```

### On Jump Example

Use `virtual_lines` handler when jumping to a diagnostic:

```lua
local virt_lines_ns = vim.api.nvim_create_namespace 'on_diagnostic_jump'

--- @param diagnostic? vim.Diagnostic
--- @param bufnr integer
local function on_jump(diagnostic, bufnr)
  if not diagnostic then return end

  vim.diagnostic.show(
    virt_lines_ns,
    bufnr,
    { diagnostic },
    { virtual_lines = { current_line = true }, virtual_text = false }
  )
end

vim.diagnostic.config({ jump = { on_jump = on_jump } })
```

### Loclist Handler Example

```lua
vim.diagnostic.handlers.loclist = {
  show = function(_, _, _, opts)
    opts.loclist.open = opts.loclist.open or false
    local winid = vim.api.nvim_get_current_win()
    vim.diagnostic.setloclist(opts.loclist)
    vim.api.nvim_set_current_win(winid)
  end
}

-- Open the location list on every diagnostic change (warnings/errors only).
vim.diagnostic.config({
  loclist = {
    open = true,
    severity = { min = vim.diagnostic.severity.WARN },
  }
})
```

## Highlights

All highlights defined for diagnostics begin with `Diagnostic` followed by the type of highlight (e.g., `Sign`, `Underline`, etc.) and the severity (e.g. `Error`, `Warn`, etc.)

By default, highlights for signs, floating windows, and virtual text are linked to the corresponding default highlight. Underline highlights are not linked and use their own default highlight groups.

### Base Highlights

| Highlight | Description |
|-----------|-------------|
| `DiagnosticError` | Base highlight group. Other Diagnostic highlights link to this by default (except Underline) |
| `DiagnosticWarn` | Base highlight group. Other Diagnostic highlights link to this by default (except Underline) |
| `DiagnosticInfo` | Base highlight group. Other Diagnostic highlights link to this by default (except Underline) |
| `DiagnosticHint` | Base highlight group. Other Diagnostic highlights link to this by default (except Underline) |
| `DiagnosticOk` | Base highlight group. Other Diagnostic highlights link to this by default (except Underline) |

### Virtual Text Highlights

`DiagnosticVirtualTextError`, `DiagnosticVirtualTextWarn`, `DiagnosticVirtualTextInfo`, `DiagnosticVirtualTextHint`, `DiagnosticVirtualTextOk`

### Virtual Lines Highlights

`DiagnosticVirtualLinesError`, `DiagnosticVirtualLinesWarn`, `DiagnosticVirtualLinesInfo`, `DiagnosticVirtualLinesHint`, `DiagnosticVirtualLinesOk`

### Underline Highlights

`DiagnosticUnderlineError`, `DiagnosticUnderlineWarn`, `DiagnosticUnderlineInfo`, `DiagnosticUnderlineHint`, `DiagnosticUnderlineOk`

### Floating Highlights

`DiagnosticFloatingError`, `DiagnosticFloatingWarn`, `DiagnosticFloatingInfo`, `DiagnosticFloatingHint`, `DiagnosticFloatingOk`

### Sign Highlights

`DiagnosticSignError`, `DiagnosticSignWarn`, `DiagnosticSignInfo`, `DiagnosticSignHint`, `DiagnosticSignOk`

### Special Highlights

| Highlight | Description |
|-----------|-------------|
| `DiagnosticDeprecated` | Used for deprecated or obsolete code |
| `DiagnosticUnnecessary` | Used for unnecessary or unused code |

## Signs

Signs are defined for each diagnostic severity. The default text for each sign is the first letter of the severity name (for example, "E" for ERROR). Signs can be customized with `vim.diagnostic.config()`.

```lua
-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
})
```

When `severity_sort` is set, the priority of each sign depends on the severity of the associated diagnostic. Otherwise, all signs have the same priority (the value of the `priority` option in the `signs` table or 10 if unset).

## Events

### DiagnosticChanged

After diagnostics have changed. When used from Lua, the new diagnostics are passed to the autocmd callback in the `data` table. Triggered per buffer.

```lua
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local diagnostics = args.data.diagnostics
    vim.print(diagnostics)
  end,
})
```

## Lua module: vim.diagnostic

### vim.Diagnostic

Extends: `vim.Diagnostic.Set`

Diagnostics use the same indexing as the rest of the Nvim API (i.e. 0-based rows and columns).

Fields:
- `{bufnr}` (`integer`) Buffer number
- `{end_lnum}` (`integer`) The final line of the diagnostic (0-indexed)
- `{col}` (`integer`) The starting column of the diagnostic (0-indexed)
- `{end_col}` (`integer`) The final column of the diagnostic (0-indexed)
- `{severity}` (`vim.diagnostic.Severity`) The severity of the diagnostic
- `{namespace}?` (`integer`)

### vim.Diagnostic.Set

Fields:
- `{lnum}` (`integer`) The starting line of the diagnostic (0-indexed)
- `{col}?` (`integer`, default: `0`) The starting column of the diagnostic (0-indexed)
- `{end_lnum}?` (`integer`, default: `lnum`) The final line of the diagnostic (0-indexed)
- `{end_col}?` (`integer`, default: `col`) The final column of the diagnostic (0-indexed)
- `{severity}?` (`vim.diagnostic.Severity`, default: `vim.diagnostic.severity.ERROR`) The severity of the diagnostic
- `{message}` (`string`) The diagnostic text
- `{source}?` (`string`) The source of the diagnostic
- `{code}?` (`string|integer`) The diagnostic code
- `{user_data}?` (`any`) arbitrary data plugins can add

### vim.diagnostic.GetOpts

Fields:
- `{namespace}?` (`integer[]|integer`) Limit diagnostics to one or more namespaces.
- `{lnum}?` (`integer`) Limit diagnostics to those spanning the specified line number.
- `{severity}?` (`vim.diagnostic.SeverityFilter`) See diagnostic-severity.
- `{enabled}?` (`boolean`, default: `nil`) Limit diagnostics to only enabled or disabled. If nil, enablement is ignored. See `vim.diagnostic.enable()`.

### vim.diagnostic.JumpOpts

Extends: `vim.diagnostic.GetOpts`

Fields:
- `{diagnostic}?` (`vim.Diagnostic`) The diagnostic to jump to. Mutually exclusive with `{count}`, `{namespace}`, and `{severity}`.
- `{count}?` (`integer`) The number of diagnostics to move by, starting from `{pos}`. A positive integer moves forward, a negative integer moves backward. Mutually exclusive with `{diagnostic}`.
- `{pos}?` (`[integer,integer]`) Cursor position as a `(row, col)` tuple. Used to find the nearest diagnostic when `{count}` is used. Default is the current cursor position.
- `{wrap}?` (`boolean`, default: `true`) Whether to loop around file or not. Similar to 'wrapscan'.
- `{severity}?` (`vim.diagnostic.SeverityFilter`) See diagnostic-severity.
- `{on_jump}?` (`fun(diagnostic:vim.Diagnostic?, bufnr:integer)`) Optional callback invoked with the diagnostic that was jumped to.
- `{winid}?` (`integer`, default: `0`) Window ID

### vim.diagnostic.NS

Fields:
- `{name}` (`string`)
- `{opts}` (`vim.diagnostic.Opts`)
- `{user_data}` (`table`)
- `{disabled}?` (`boolean`)

### vim.diagnostic.Opts

Many of the configuration options below accept one of the following:
- `false`: Disable this feature
- `true`: Enable this feature, use default settings.
- `table`: Enable this feature with overrides. Use an empty table to use default values.
- `function`: Function with signature `(namespace, bufnr)` that returns any of the above.

Fields:
- `{underline}?` (`boolean|vim.diagnostic.Opts.Underline|fun(namespace: integer, bufnr:integer): vim.diagnostic.Opts.Underline`, default: `true`) Use underline for diagnostics.
- `{virtual_text}?` (`boolean|vim.diagnostic.Opts.VirtualText|fun(namespace: integer, bufnr:integer): vim.diagnostic.Opts.VirtualText`, default: `false`) Use virtual text for diagnostics. If multiple diagnostics are set for a namespace, one prefix per diagnostic + the last diagnostic message are shown.
- `{virtual_lines}?` (`boolean|vim.diagnostic.Opts.VirtualLines|fun(namespace: integer, bufnr:integer): vim.diagnostic.Opts.VirtualLines`, default: `false`) Use virtual lines for diagnostics.
- `{signs}?` (`boolean|vim.diagnostic.Opts.Signs|fun(namespace: integer, bufnr:integer): vim.diagnostic.Opts.Signs`, default: `true`) Use signs for diagnostics.
- `{float}?` (`boolean|vim.diagnostic.Opts.Float|fun(namespace: integer, bufnr:integer): vim.diagnostic.Opts.Float`) Options for floating windows.
- `{status}?` (`vim.diagnostic.Opts.Status`) Options for the statusline component.
- `{update_in_insert}?` (`boolean`, default: `false`) Update diagnostics in Insert mode (if `false`, diagnostics are updated on InsertLeave).
- `{severity_sort}?` (`boolean|{reverse?:boolean}`, default: `false`) Sort diagnostics by severity. When true, higher severities are displayed before lower severities (e.g. ERROR before WARN). Options: `{reverse}?` (boolean) Reverse sort order.
- `{jump}?` (`vim.diagnostic.Opts.Jump`) Default values for `vim.diagnostic.jump()`.

### vim.diagnostic.Opts.Float

Extends: `vim.lsp.util.open_floating_preview.Opts`

Fields:
- `{bufnr}?` (`integer`, default: current buffer) Buffer number to show diagnostics from.
- `{namespace}?` (`integer|integer[]`) Limit diagnostics to the given namespace(s).
- `{scope}?` (`'line'|'buffer'|'cursor'|'c'|'l'|'b'`, default: `line`) Show diagnostics from the whole buffer (`buffer`), the current cursor line (`line`), or the current cursor position (`cursor`). Shorthand versions also accepted (`c` for `cursor`, `l` for `line`, `b` for `buffer`).
- `{pos}?` (`integer|[integer,integer]`) If `{scope}` is `line` or `cursor`, use this position rather than the cursor position. If a number, interpreted as a line number; otherwise, a `(row, col)` tuple.
- `{severity_sort}?` (`boolean|{reverse?:boolean}`, default: `false`) Sort diagnostics by severity. Overrides the setting from `vim.diagnostic.config()`.
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Overrides the setting from `vim.diagnostic.config()`.
- `{header}?` (`string|[string,any]`) String to use as the header for the floating window. If a table, it is interpreted as a `[text, hl_group]` tuple. Overrides the setting from `vim.diagnostic.config()`.
- `{source}?` (`boolean|'if_many'`) Include the diagnostic source in the message. Use `if_many` to only show sources if there is more than one source of diagnostics in the buffer.
- `{format}?` (`fun(diagnostic:vim.Diagnostic): string?`) A function that takes a diagnostic as input and returns a string or nil. If nil, the diagnostic is not displayed. Overrides the setting from `vim.diagnostic.config()`.
- `{prefix}?` (`string|table|(fun(diagnostic:vim.Diagnostic,i:integer,total:integer): string, string)`) Prefix each diagnostic in the floating window. If a function, `{i}` is the index, `{total}` is total count; returns string and optional highlight group. If a table, interpreted as `[text, hl_group]` tuple. If a string, prepended with no highlight.
- `{suffix}?` (`string|table|(fun(diagnostic:vim.Diagnostic,i:integer,total:integer): string, string)`) Same as `{prefix}`, but appends to the diagnostic.

### vim.diagnostic.Opts.Jump

Fields:
- `{on_jump}?` (`fun(diagnostic:vim.Diagnostic?, bufnr:integer)`) Default value of the `{on_jump}` parameter of `vim.diagnostic.jump()`.
- `{wrap}?` (`boolean`, default: `true`) Default value of the `{wrap}` parameter of `vim.diagnostic.jump()`.
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Default value of the `{severity}` parameter of `vim.diagnostic.jump()`.

### vim.diagnostic.Opts.Signs

Fields:
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Only show signs for diagnostics matching the given severity.
- `{priority}?` (`integer`, default: `10`) Base priority to use for signs. When `{severity_sort}` is used, the priority is adjusted based on severity. Otherwise, all signs use the same priority.
- `{text}?` (`table<vim.diagnostic.Severity,string>`) A table mapping severity to the sign text to display in the sign column. Defaults: `"E"`, `"W"`, `"I"`, `"H"`.
  ```lua
  vim.diagnostic.config({
    signs = { text = { [vim.diagnostic.severity.ERROR] = 'E', ... } }
  })
  ```
- `{numhl}?` (`table<vim.diagnostic.Severity,string>`) A table mapping severity to the highlight group used for the line number where the sign is placed.
- `{linehl}?` (`table<vim.diagnostic.Severity,string>`) A table mapping severity to the highlight group used for the whole line the sign is placed in.

### vim.diagnostic.Opts.Status

Fields:
- `{text}?` (`table<vim.diagnostic.Severity,string>`) A table mapping severity to the text to use for each severity section.

### vim.diagnostic.Opts.Underline

Fields:
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Only underline diagnostics matching the given severity.

### vim.diagnostic.Opts.VirtualLines

Fields:
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Only show virtual lines for diagnostics matching the given severity.
- `{current_line}?` (`boolean`, default: `false`) Only show diagnostics for the current line.
- `{format}?` (`fun(diagnostic:vim.Diagnostic): string?`) A function that takes a diagnostic as input and returns a string or nil. If nil, the diagnostic is not displayed.

### vim.diagnostic.Opts.VirtualText

Fields:
- `{severity}?` (`vim.diagnostic.SeverityFilter`) Only show virtual text for diagnostics matching the given severity.
- `{current_line}?` (`boolean`) Show or hide diagnostics based on the current cursor line. If `true`, only diagnostics on the current cursor line are shown. If `false`, all diagnostics are shown except on the current cursor line. If `nil`, all diagnostics are shown. (default `nil`)
- `{source}?` (`boolean|"if_many"`) Include the diagnostic source in virtual text. Use `'if_many'` to only show sources if there is more than one diagnostic source in the buffer.
- `{spacing}?` (`integer`) Amount of empty spaces inserted at the beginning of the virtual text.
- `{prefix}?` (`string|(fun(diagnostic:vim.Diagnostic,i:integer,total:integer): string)`) Prepend diagnostic message with prefix. If a function, `{i}` is the index and `{total}` is the total count for the line.
- `{suffix}?` (`string|(fun(diagnostic:vim.Diagnostic): string)`) Append diagnostic message with suffix. Can be used to render an LSP diagnostic error code.
- `{format}?` (`fun(diagnostic:vim.Diagnostic): string?`) If not nil, the return value is the text used to display the diagnostic. If returns nil, the diagnostic is not displayed.
  ```lua
  function(diagnostic)
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      return string.format("E: %s", diagnostic.message)
    end
    return diagnostic.message
  end
  ```
- `{hl_mode}?` (`'replace'|'combine'|'blend'`) See `nvim_buf_set_extmark()`.
- `{virt_text}?` (`[string,any][]`) See `nvim_buf_set_extmark()`.
- `{virt_text_pos}?` (`'eol'|'eol_right_align'|'inline'|'overlay'|'right_align'`) See `nvim_buf_set_extmark()`.
- `{virt_text_win_col}?` (`integer`) See `nvim_buf_set_extmark()`.
- `{virt_text_hide}?` (`boolean`) See `nvim_buf_set_extmark()`.

## API Functions

### `vim.diagnostic.config({opts}, {namespace})`

Configure diagnostic options globally or for a specific diagnostic namespace.

Configuration can be specified globally, per-namespace, or ephemerally (i.e. only for a single call to `vim.diagnostic.set()` or `vim.diagnostic.show()`). Ephemeral configuration has highest priority, followed by namespace configuration, and finally global configuration.

```lua
vim.diagnostic.config({ virtual_text = true })
```

**Parameters:**
- `{opts}` (`vim.diagnostic.Opts?`) When omitted or `nil`, retrieve the current configuration. Otherwise, a configuration table (see `vim.diagnostic.Opts`).
- `{namespace}` (`integer?`) Update the options for the given namespace. When omitted, update the global diagnostic options.

**Return:** (`vim.diagnostic.Opts?`) Current diagnostic config if `{opts}` is omitted.

---

### `vim.diagnostic.count({bufnr}, {opts})`

Get current diagnostics count.

**Parameters:**
- `{bufnr}` (`integer?`) Buffer number to get diagnostics from. Use 0 for current buffer or nil for all buffers.
- `{opts}` (`vim.diagnostic.GetOpts?`)

**Return:** (`table<integer, integer>`) Table with actually present severity values as keys and integer counts as values.

---

### `vim.diagnostic.enable({enable}, {filter})`

Enables or disables diagnostics.

To "toggle", pass the inverse of `is_enabled()`:
```lua
vim.diagnostic.enable(not vim.diagnostic.is_enabled())
```

**Parameters:**
- `{enable}` (`boolean?`) true/nil to enable, false to disable
- `{filter}` (`table?`) Optional filters, or `nil` for all.
  - `{ns_id}?` (`integer`) Diagnostic namespace, or `nil` for all.
  - `{bufnr}?` (`integer`) Buffer number, or 0 for current buffer, or `nil` for all buffers.

---

### `vim.diagnostic.fromqflist({list})`

Convert a list of quickfix items to a list of diagnostics.

**Parameters:**
- `{list}` (`table[]`) List of quickfix items from `getqflist()` or `getloclist()`.

**Return:** (`vim.Diagnostic[]`)

---

### `vim.diagnostic.get({bufnr}, {opts})`

Get current diagnostics.

Modifying diagnostics in the returned table has no effect. To set diagnostics in a buffer, use `vim.diagnostic.set()`.

**Parameters:**
- `{bufnr}` (`integer?`) Buffer number to get diagnostics from. Use 0 for current buffer or nil for all buffers.
- `{opts}` (`vim.diagnostic.GetOpts?`)

**Return:** (`vim.Diagnostic[]`) Fields `bufnr`, `end_lnum`, `end_col`, and `severity` are guaranteed to be present.

---

### `vim.diagnostic.get_namespace({namespace})`

Get namespace metadata.

**Parameters:**
- `{namespace}` (`integer`) Diagnostic namespace

**Return:** (`vim.diagnostic.NS`) Namespace metadata.

---

### `vim.diagnostic.get_namespaces()`

Get current diagnostic namespaces.

**Return:** (`table<integer,vim.diagnostic.NS>`) List of active diagnostic namespaces.

---

### `vim.diagnostic.get_next({opts})`

Get the next diagnostic closest to the cursor position.

**Parameters:**
- `{opts}` (`vim.diagnostic.JumpOpts?`)

**Return:** (`vim.Diagnostic?`) Next diagnostic.

---

### `vim.diagnostic.get_prev({opts})`

Get the previous diagnostic closest to the cursor position.

**Parameters:**
- `{opts}` (`vim.diagnostic.JumpOpts?`)

**Return:** (`vim.Diagnostic?`) Previous diagnostic.

---

### `vim.diagnostic.hide({namespace}, {bufnr})`

Hide currently displayed diagnostics.

This only clears the decorations displayed in the buffer. Diagnostics can be redisplayed with `vim.diagnostic.show()`. To completely remove diagnostics, use `vim.diagnostic.reset()`.

To hide diagnostics and prevent them from re-displaying, use `vim.diagnostic.enable()`.

**Parameters:**
- `{namespace}` (`integer?`) Diagnostic namespace. When omitted, hide diagnostics from all namespaces.
- `{bufnr}` (`integer?`) Buffer number, or 0 for current buffer. When omitted, hide diagnostics in all buffers.

---

### `vim.diagnostic.is_enabled({filter})`

Check whether diagnostics are enabled.

Since: 0.10.0

**Parameters:**
- `{filter}` (`table?`) Optional filters, or `nil` for all.
  - `{ns_id}?` (`integer`) Diagnostic namespace, or `nil` for all.
  - `{bufnr}?` (`integer`) Buffer number, or 0 for current buffer, or `nil` for all buffers.

**Return:** (`boolean`)

---

### `vim.diagnostic.jump({opts})`

Move to a diagnostic.

**Parameters:**
- `{opts}` (`vim.diagnostic.JumpOpts`)

**Return:** (`vim.Diagnostic?`) The diagnostic that was moved to.

---

### `vim.diagnostic.match({str}, {pat}, {groups}, {severity_map}, {defaults})`

Parse a diagnostic from a string.

Example:
```lua
local s = "WARNING filename:27:3: Variable 'foo' does not exist"
local pattern = "^(%w+) %w+:(%d+):(%d+): (.+)$"
local groups = { "severity", "lnum", "col", "message" }
vim.diagnostic.match(s, pattern, groups, { WARNING = vim.diagnostic.WARN })
```

**Parameters:**
- `{str}` (`string`) String to parse diagnostics from.
- `{pat}` (`string`) Lua pattern with capture groups.
- `{groups}` (`string[]`) List of fields in a `vim.Diagnostic` structure to associate with captures from `{pat}`.
- `{severity_map}` (`table`) A table mapping the severity field from `{groups}` with an item from `vim.diagnostic.severity`.
- `{defaults}` (`table?`) Table of default values for any fields not listed in `{groups}`. When omitted, numeric values default to 0 and `severity` defaults to ERROR.

**Return:** (`vim.Diagnostic?`) or `nil` if `{pat}` fails to match `{str}`.

---

### `vim.diagnostic.open_float({opts})`

Show diagnostics in a floating window.

**Parameters:**
- `{opts}` (`vim.diagnostic.Opts.Float?`)

**Return (multiple):**
- (`integer?`) float_bufnr
- (`integer?`) winid

---

### `vim.diagnostic.reset({namespace}, {bufnr})`

Remove all diagnostics from the given namespace.

Unlike `vim.diagnostic.hide()`, this function removes all saved diagnostics. They cannot be redisplayed using `vim.diagnostic.show()`. To simply remove diagnostic decorations in a way that they can be re-displayed, use `vim.diagnostic.hide()`.

**Parameters:**
- `{namespace}` (`integer?`) Diagnostic namespace. When omitted, remove diagnostics from all namespaces.
- `{bufnr}` (`integer?`) Remove diagnostics for the given buffer. When omitted, diagnostics are removed for all buffers.

---

### `vim.diagnostic.set({namespace}, {bufnr}, {diagnostics}, {opts})`

Set diagnostics for the given namespace and buffer.

**Parameters:**
- `{namespace}` (`integer`) The diagnostic namespace
- `{bufnr}` (`integer`) Buffer number
- `{diagnostics}` (`vim.Diagnostic.Set[]`)
- `{opts}` (`vim.diagnostic.Opts?`) Display options to pass to `vim.diagnostic.show()`.

---

### `vim.diagnostic.setloclist({opts})`

Add buffer diagnostics to the location list.

**Parameters:**
- `{opts}` (`table?`) Configuration table with the following keys:
  - `{namespace}?` (`integer[]|integer`) Only add diagnostics from the given namespace(s).
  - `{winnr}?` (`integer`, default: `0`) Window number to set location list for.
  - `{open}?` (`boolean`, default: `true`) Open the location list after setting.
  - `{title}?` (`string`) Title of the location list. Defaults to "Diagnostics".
  - `{severity}?` (`vim.diagnostic.SeverityFilter`)
  - `{format}?` (`fun(diagnostic:vim.Diagnostic): string?`) A function that takes a diagnostic as input and returns a string or nil. If nil, the diagnostic is not displayed in the location list.

---

### `vim.diagnostic.setqflist({opts})`

Add all diagnostics to the quickfix list.

**Parameters:**
- `{opts}` (`table?`) Configuration table with the following keys:
  - `{namespace}?` (`integer[]|integer`) Only add diagnostics from the given namespace(s).
  - `{open}?` (`boolean`, default: `true`) Open quickfix list after setting.
  - `{title}?` (`string`) Title of quickfix list. Defaults to "Diagnostics". If there's already a quickfix list with this title, it's updated. If not, a new one is created.
  - `{severity}?` (`vim.diagnostic.SeverityFilter`)
  - `{format}?` (`fun(diagnostic:vim.Diagnostic): string?`) A function that takes a diagnostic as input and returns a string or nil. If nil, the diagnostic is not displayed in the quickfix list.

---

### `vim.diagnostic.show({namespace}, {bufnr}, {diagnostics}, {opts})`

Display diagnostics for the given namespace and buffer.

**Parameters:**
- `{namespace}` (`integer?`) Diagnostic namespace. When omitted, show diagnostics from all namespaces.
- `{bufnr}` (`integer?`) Buffer number, or 0 for current buffer. When omitted, show diagnostics in all buffers.
- `{diagnostics}` (`vim.Diagnostic[]?`) The diagnostics to display. When omitted, use the saved diagnostics for the given namespace and buffer. This can be used to display a list of diagnostics without saving them or to display only a subset. May not be used when `{namespace}` or `{bufnr}` is nil.
- `{opts}` (`vim.diagnostic.Opts?`) Display options.

---

### `vim.diagnostic.status({bufnr})`

Returns formatted string with diagnostics for the current buffer. The severities with 0 diagnostics are left out. Example: `E:2 W:3 I:4 H:5`

To customise appearance:
```lua
vim.diagnostic.config({
  status = { text = { [vim.diagnostic.severity.ERROR] = 'e', ... } }
})
```

**Parameters:**
- `{bufnr}` (`integer?`) Buffer number to get diagnostics from. Defaults to 0 for the current buffer.

**Return:** (`string`)

---

### `vim.diagnostic.toqflist({diagnostics})`

Convert a list of diagnostics to a list of quickfix items that can be passed to `setqflist()` or `setloclist()`.

**Parameters:**
- `{diagnostics}` (`vim.Diagnostic[]`)

**Return:** (`table[]`) Quickfix list items.
