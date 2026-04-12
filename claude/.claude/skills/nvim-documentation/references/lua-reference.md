# Lua Reference (vim.* stdlib)

Curated reference for Neovim's Lua standard library (`vim.*` modules) and Lua 5.1 built-ins.
Source: `:help lua.txt`, `:help luaref.txt` (Neovim HEAD-16680e5).

## Table of Contents

- [Scheduling and Async](#scheduling-and-async)
- [vim.uv (libuv bindings)](#vimuv-libuv-bindings)
- [vim.system](#vimsystem)
- [Core Utilities](#core-utilities)
- [String Functions](#string-functions)
- [Table Functions](#table-functions)
- [List Functions](#list-functions)
- [Type Checking](#type-checking)
- [vim.iter](#vimiter)
- [vim.fs (Filesystem)](#vimfs-filesystem)
- [vim.json](#vimjson)
- [vim.base64](#vimbase64)
- [vim.text](#vimtext)
- [vim.lpeg](#vimlpeg)
- [vim.re](#vimre)
- [vim.version](#vimversion)
- [Vimscript Bridge](#vimscript-bridge)
- [Lua 5.1 Standard Library Summary](#lua-51-standard-library-summary)

---

## Scheduling and Async

### `vim.schedule(fn)`
Schedules `fn` to be invoked soon by the main event-loop. Use to avoid textlock or other temporary restrictions.
Returns `nil, err_string?`.

### `vim.schedule_wrap(fn)`
Returns a function that calls `fn` via `vim.schedule()`. Essential for `vim.uv` callbacks that need to call `vim.api`.

```lua
vim.uv.fs_access(path, "R", vim.schedule_wrap(function(err, readable)
  vim.notify("readable? " .. tostring(readable))
end))
```

### `vim.defer_fn(fn, timeout)`
Defers calling `fn` until `timeout` ms passes (one-shot timer). `fn` is automatically `vim.schedule()`d. Returns the luv timer object.

```lua
vim.defer_fn(function() vim.g.timer_result = true end, 100)
```

### `vim.wait(time, callback?, interval?, fast_only?)`
Waits up to `time` ms until `callback` returns `true`. Processes other events while waiting.
- Returns: `true` on success, `false, -1` on timeout, `false, -2` on interrupt.

```lua
vim.wait(100)  -- just wait 100ms
vim.wait(1000, function() return vim.g.foo end, 500)  -- poll every 500ms
```

### `vim.on_key(fn, ns_id?, opts?)`
Adds `fn` as a listener to every input key. `fn(key, typed)` receives raw keycodes after and before mappings. Return empty string to discard. Pass `fn=nil` to remove.

### `vim.notify(msg, level?, opts?)`
Displays a notification. Can be overridden by plugins (e.g. nvim-notify). `level` is one of `vim.log.levels.{DEBUG,INFO,WARN,ERROR,TRACE,OFF}`.

### `vim.notify_once(msg, level?, opts?)`
Like `vim.notify()` but only shows once per unique message. Returns `true` if displayed.

### `vim.print(...)`
Pretty-prints arguments using `vim.inspect()` and returns them unmodified.

```lua
local hl = vim.print(vim.api.nvim_get_hl(0, { name = 'Normal' }))
```

---

## vim.uv (libuv bindings)

`vim.uv` exposes the "luv" Lua bindings for libUV (networking, filesystem, process management, event loop). See `:help luvref.txt` for full API.

**Important:** Do NOT call `vim.api` functions directly in `vim.uv` callbacks. Use `vim.schedule_wrap()` to defer them.

```lua
-- Repeating timer
local timer = vim.uv.new_timer()
timer:start(1000, 750, function()
  print('timer fired')
  timer:close()  -- always close handles to avoid leaks
end)
```

```lua
-- File-change detection
local w = vim.uv.new_fs_event()
w:start(fullpath, {}, vim.schedule_wrap(function(err, fname, status)
  vim.cmd('checktime')
  w:stop()
end))
```

### Common vim.uv functions

| Function | Description |
|---|---|
| `vim.uv.new_timer()` | Create a timer handle |
| `vim.uv.new_fs_event()` | Watch filesystem changes |
| `vim.uv.fs_stat(path)` | Stat a file (check existence/type) |
| `vim.uv.fs_access(path, mode, cb)` | Check file access permissions |
| `vim.uv.new_tcp()` | Create a TCP handle |
| `vim.uv.new_thread(fn)` | Spawn an OS-level thread |

### Threading

Each thread gets its own Lua interpreter (no shared globals). Available in threads: `vim.uv`, `vim.mpack`, `vim.json`, `require`, `print`, `vim.inspect`, `vim.text.diff`, most pure-Lua `vim.*` utilities (`vim.split`, `vim.tbl_*`, `vim.list_*`). Check `vim.is_thread()`.

---

## vim.system

### `vim.system(cmd, opts?, on_exit?)`
Runs a system command. Runs directly (not in shell). Throws on failure to launch.

```lua
-- Synchronous:
local obj = vim.system({'echo', 'hello'}, { text = true }):wait()
-- { code = 0, signal = 0, stdout = 'hello\n', stderr = '' }

-- Asynchronous:
vim.system({'echo', 'hello'}, { text = true }, function(obj)
  print(obj.code, obj.stdout)
end)
```

**opts fields:**
- `cwd` (string) -- working directory
- `env` (table) -- environment variables
- `clear_env` (bool) -- don't inherit current env
- `stdin` (string|string[]|true) -- pipe input; `true` enables `obj:write()`
- `stdout` / `stderr` (fun|bool) -- output handlers; default `true` (collect)
- `text` (bool) -- normalize `\r\n` to `\n`
- `timeout` (integer) -- ms, sends SIGTERM on timeout, exit code 124
- `detach` (bool) -- spawn as process group leader

### SystemObj methods

| Method | Description |
|---|---|
| `obj:wait(timeout?)` | Block until exit or timeout. Returns `vim.SystemCompleted` |
| `obj:kill(signal)` | Send signal (integer or string like `'sigterm'`) |
| `obj:write(data)` | Write string/string[] to stdin; `nil` closes stdin |
| `obj:is_closing()` | Check if process handle is closing |

### vim.SystemCompleted fields
`code` (int), `signal` (int), `stdout` (string?), `stderr` (string?)

---

## Core Utilities

### `vim.inspect(x, opts?)`
Returns a human-readable string representation of any Lua value.

### `vim.deepcopy(orig, noref?)`
Deep copies a table. `noref=true` is faster for tables with unique sub-tables; `noref=false` (default) preserves shared references.

### `vim.deep_equal(a, b)`
Recursively compares two values for equality.

### `vim.defaulttable(createfn?)`
Creates a table whose missing keys are auto-created by `createfn`. Defaults to nested defaulttable.

```lua
local a = vim.defaulttable()
a.b.c = 1
```

### `vim.validate(name, value, validator, optional?, message?)`
Validates function arguments. `validator` can be a type string (`'string'`, `'table'`, `'callable'`, etc.), list of type strings, or a predicate function.

```lua
vim.validate('s', s, 'string')
vim.validate('opts', opts, 'table', true)  -- optional
vim.validate('n', n, function(v) return v % 2 == 0 end, 'even number')
```

### `vim.cmd(command)`
Executes Vimscript. String form supports multiline. Can be indexed: `vim.cmd.echo('"foo"')`.

```lua
vim.cmd('echo 42')
vim.cmd.write { 'myfile.txt', bang = true }
```

### `vim.keycode(str)`
Translates keycodes: `vim.g.mapleader = vim.keycode'<bs>'`

### `vim.ringbuf(size)`
Creates a ring buffer. Methods: `push(item)`, `pop()`, `peek()`, `clear()`. Iterable with `for val in ringbuf do`.

### `vim.empty_dict()`
Creates a special empty table that converts to an empty dict (not array) in Vimscript/API.

### `vim.iconv(str, from, to)`
Converts string encoding. Returns nil on failure.

### `vim.stricmp(a, b)`
Case-insensitive string comparison. Returns `0|1|-1`.

### `vim.pesc(s)`
Escapes magic chars in Lua patterns.

### `vim.in_fast_event()`
Returns true if running in a fast (low-level) event handler where most API is disabled.

---

## String Functions

### `vim.split(s, sep, opts?)`
Splits string into a table. `opts`: `{plain=bool, trimempty=bool}`.

```lua
vim.split(':aa::b:', ':')                   --> {'','aa','','b',''}
vim.split('|x|y|z|', '|', {trimempty=true}) --> {'x', 'y', 'z'}
```

### `vim.gsplit(s, sep, opts?)`
Lazy iterator version of `vim.split()`.

```lua
for s in vim.gsplit(':aa::b:', ':', {plain=true}) do
  print(s)
end
```

### `vim.trim(s)`
Trims whitespace from both sides of a string.

### `vim.startswith(s, prefix)`
Returns `true` if `s` starts with `prefix`.

### `vim.endswith(s, suffix)`
Returns `true` if `s` ends with `suffix`.

### `vim.spairs(t)`
Iterates key-value pairs of a table, ordered by key.

---

## Table Functions

### `vim.tbl_extend(behavior, ...)`
Merges two or more tables (shallow). `behavior`: `'error'|'keep'|'force'` or a function `fun(key, prev, val)`.

```lua
local merged = vim.tbl_extend('force', defaults, user_opts)
```

### `vim.tbl_deep_extend(behavior, ...)`
Recursively merges tables. Non-list sub-tables are merged; lists are overwritten.

```lua
local config = vim.tbl_deep_extend('force', default_config, user_config)
```

### `vim.tbl_keys(t)`
Returns a list of all keys (order not guaranteed).

### `vim.tbl_values(t)`
Returns a list of all values (order not guaranteed).

### `vim.tbl_map(fn, t)`
Applies `fn` to all values, returns new table.

### `vim.tbl_filter(fn, t)`
Filters values by predicate, returns new table.

### `vim.tbl_contains(t, value, opts?)`
Checks if table contains a value. Set `opts.predicate=true` to use `value` as a predicate function.

```lua
vim.tbl_contains({ 'a', { 'b', 'c' } }, function(v)
  return vim.deep_equal(v, { 'b', 'c' })
end, { predicate = true })
-- true
```

### `vim.tbl_isempty(t)`
Returns `true` if table is empty.

### `vim.tbl_count(t)`
Counts non-nil values.

### `vim.tbl_get(o, ...)`
Safe nested table access. Returns nil if any key is missing.

```lua
vim.tbl_get({ key = { nested = true }}, 'key', 'nested') -- true
vim.tbl_get({ key = {}}, 'key', 'nested') -- nil
```

---

## List Functions

### `vim.list_extend(dst, src, start?, finish?)`
Appends values from `src` to `dst` (mutates `dst`). Returns `dst`.

### `vim.list_contains(t, value)`
Checks if a list (contiguous integer keys) contains `value`.

### `vim.list_slice(list, start?, finish?)`
Returns a copy of elements from `start` to `finish` (inclusive).

### `vim.list.bisect(t, val, opts?)`
Binary search in a sorted list. `opts.bound`: `'lower'` (default) or `'upper'`. Returns insertion index.

### `vim.list.unique(t, key?)`
Removes duplicates in-place. Optional `key` function for complex values.

```lua
local t = {1, 2, 2, 3, 1}
vim.list.unique(t)  -- t is now {1, 2, 3}
```

---

## Type Checking

### `vim.islist(t)`
Returns `true` if `t` is a list (contiguous integer keys starting from 1).

### `vim.isarray(t)`
Returns `true` if `t` is indexed only by integers (possibly non-contiguous).

### `vim.is_callable(f)`
Returns `true` if `f` can be called as a function.

---

## vim.iter

`vim.iter()` wraps a table or iterator function into a chainable pipeline.

- **Lists/arrays:** yield values only. Use `ipairs()` or `:enumerate()` to also get indices.
- **Dicts:** yield key, value pairs.
- **Function iterators:** yield all return values.

```lua
vim.iter({ 1, 2, 3, 4, 5 })
  :map(function(v) return v * 3 end)
  :rev()
  :skip(2)
  :totable()
-- { 9, 6, 3 }

vim.iter({ a = 1, b = 2, c = 3, z = 26 }):any(function(k, v)
  return k == 'z'
end)
-- true
```

### Iter methods

| Method | Description |
|---|---|
| `:map(f)` | Transform values. Nil returns filter the value out. |
| `:filter(f)` | Keep only values where `f(...)` is truthy. |
| `:each(f)` | Call `f` for each item (drains iterator). |
| `:find(f)` | First match (value or predicate). Advances iterator. |
| `:rfind(f)` | Find from end (list-iterator only). |
| `:any(pred)` | True if any item matches. |
| `:all(pred)` | True if all items match. |
| `:totable()` | Collect into a table. |
| `:join(delim)` | Collect into a delimited string. |
| `:fold(init, f)` | Reduce/accumulate. |
| `:flatten(depth?)` | Flatten nested lists (default depth 1). |
| `:next()` | Get next value. |
| `:peek()` | Get next value without consuming (list only). |
| `:pop()` | Get last value and shrink (list only). |
| `:rpeek()` | Get last value without consuming (list only). |
| `:last()` | Drain and return last value. |
| `:nth(n)` | Get nth value (negative = from end, list only). |
| `:skip(n\|pred)` | Skip first n values or while predicate is true. |
| `:rskip(n)` | Discard n values from end (list only). |
| `:take(n\|pred)` | Yield only first n values or while predicate is true. |
| `:slice(first, last)` | Set start/end range (list only). |
| `:rev()` | Reverse (list only). |
| `:enumerate()` | Yield `(index, value)` pairs. |

---

## vim.fs (Filesystem)

### `vim.fs.find(names, opts?)`
Find files/directories by name, pattern function, upward/downward traversal.

```lua
-- Find project root markers
vim.fs.find({ '.git', 'Makefile' }, { upward = true, path = vim.fn.expand('%:p:h') })

-- Find all .lua files recursively
vim.fs.find(function(name) return name:match('%.lua$') end, {
  limit = math.huge, type = 'file', path = './lua/'
})
```

**opts:** `path`, `upward` (bool), `stop` (string), `type` (file|directory|link|...), `limit` (default 1), `follow` (bool).

### `vim.fs.root(source, marker)`
Find first parent directory containing a marker. `source`: buffer number or file path.

```lua
vim.fs.root(0, '.git')
vim.fs.root(0, { 'pyproject.toml', 'setup.py' })
```

### `vim.fs.dirname(file)`
Parent directory of a path (not resolved).

### `vim.fs.basename(file)`
Basename of a path.

### `vim.fs.joinpath(...)`
Join path segments, normalizing slashes.

### `vim.fs.normalize(path, opts?)`
Normalize path: expand `~`, env vars, resolve `.`/`..`, convert `\` to `/`.

### `vim.fs.abspath(path)`
Convert to absolute path. Expands `~` but does NOT resolve symlinks or `..`.

### `vim.fs.relpath(base, target, opts?)`
Get `target` relative to `base`. Returns nil if `base` is not an ancestor.

### `vim.fs.dir(path, opts?)`
Iterator over directory items. `opts`: `depth` (default 1), `skip` (predicate), `follow` (bool). Yields `(name, type)`.

### `vim.fs.parents(start)`
Iterator over parent directories.

```lua
for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
  if vim.uv.fs_stat(dir .. '/.git') then
    print('Git root:', dir)
    break
  end
end
```

### `vim.fs.rm(path, opts?)`
Remove files/directories. `opts`: `recursive` (bool), `force` (bool).

### File existence check (no `vim.fs.exists`)
Use `vim.uv.fs_stat(file)` -- returns truthy if file exists.

---

## vim.json

### `vim.json.decode(str, opts?)`
Decode JSON string to Lua. `null` becomes `vim.NIL` (or Lua `nil` if `opts.luanil={object=true, array=true}`). Empty objects become `vim.empty_dict()`.

### `vim.json.encode(obj, opts?)`
Encode Lua value to JSON string. `opts`: `escape_slash` (bool), `indent` (string), `sort_keys` (bool).

```lua
vim.json.encode({ foo = 'bar' }, { indent = '  ', sort_keys = true })
```

---

## vim.base64

### `vim.base64.encode(str)`
Encode string to Base64.

### `vim.base64.decode(str)`
Decode Base64 string.

---

## vim.text

### `vim.text.diff(a, b, opts?)`
Compute diff of two strings. Returns unified diff string or index array.

```lua
vim.text.diff('a\n', 'b\nc\n')
-- @@ -1 +1,2 @@
-- -a
-- +b
-- +c

vim.text.diff('a\n', 'b\nc\n', {result_type = 'indices'})
-- { {1, 1, 1, 2} }
```

**opts:** `result_type` (`'unified'|'indices'`), `algorithm` (`'myers'|'minimal'|'patience'|'histogram'`), `on_hunk` (callback), `linematch`, `ctxlen`, `ignore_whitespace`, etc.

### `vim.text.hexencode(str)`
Hex encode a string.

### `vim.text.hexdecode(enc)`
Hex decode a string. Returns `decoded?, err?`.

### `vim.text.indent(size, text, opts?)`
Set indent of non-empty lines to `size` spaces/tabs. Pass `size=0` to dedent.

```lua
vim.text.indent(0, '  a\n    b\n')  -- removes common indent
```

---

## vim.lpeg

LPeg pattern-matching library based on Parsing Expression Grammars. Available as `vim.lpeg`.

### Pattern constructors

| Function | Description |
|---|---|
| `vim.lpeg.P(value)` | Literal string, character count, bool, grammar table, or function |
| `vim.lpeg.R(...)` | Character range: `R('az')` matches `a-z` |
| `vim.lpeg.S(string)` | Character set: `S('+-*/')` matches any of those |
| `vim.lpeg.V(v)` | Grammar non-terminal (variable) |
| `vim.lpeg.B(patt)` | Behind predicate (match if preceded by `patt`) |

### Captures

| Function | Description |
|---|---|
| `vim.lpeg.C(patt)` | Simple capture (matched substring) |
| `vim.lpeg.Cc(...)` | Constant capture |
| `vim.lpeg.Cg(patt, name?)` | Group capture |
| `vim.lpeg.Cp()` | Position capture |
| `vim.lpeg.Cs(patt)` | Substitution capture |
| `vim.lpeg.Ct(patt)` | Table capture |
| `vim.lpeg.Cf(patt, func)` | Fold capture |
| `vim.lpeg.Cb(name)` | Back capture |
| `vim.lpeg.Carg(n)` | Argument capture |
| `vim.lpeg.Cmt(patt, fn)` | Match-time capture |

### Other

| Function | Description |
|---|---|
| `vim.lpeg.match(pattern, subject, init?)` | Match pattern against string |
| `vim.lpeg.locale(tab?)` | Character class patterns for current locale |
| `vim.lpeg.type(value)` | Returns `"pattern"` or nil |
| `vim.lpeg.setmaxstack(max)` | Set backtrack stack limit (default 400) |
| `vim.lpeg.version()` | LPeg version string |

```lua
local lpeg = vim.lpeg
local pattern = lpeg.R('az') ^ 1 * -1
assert(pattern:match('hello') == 6)
```

---

## vim.re

Regex-like syntax for LPeg patterns. See https://www.inf.puc-rio.br/~roberto/lpeg/re.html.

### `vim.re.compile(string, defs?)`
Compile regex-like string to LPeg pattern.

### `vim.re.match(subject, pattern, init?)`
Match pattern against subject, return captures.

### `vim.re.find(subject, pattern, init?)`
Find pattern in subject. Returns start, end indices or nil.

### `vim.re.gsub(subject, pattern, replacement)`
Global substitution.

### `vim.re.updatelocale()`
Update pre-defined character classes to current locale.

---

## vim.version

Semver-compliant version comparison. `vim.version()` returns the current Nvim version.

### `vim.version.parse(version, opts?)`
Parse version string. `opts.strict=false` (default) coerces loose input like `"tmux 3.2a"`.

```lua
local v = vim.version.parse('1.2.3-rc1+build.2')
-- { major=1, minor=2, patch=3, prerelease="rc1", build="build.2" }
```

### Comparison functions

| Function | Description |
|---|---|
| `vim.version.cmp(v1, v2)` | Returns `-1`, `0`, or `1` |
| `vim.version.eq(v1, v2)` | Equal |
| `vim.version.lt(v1, v2)` | Less than |
| `vim.version.le(v1, v2)` | Less than or equal |
| `vim.version.gt(v1, v2)` | Greater than |
| `vim.version.ge(v1, v2)` | Greater than or equal |

Versions can be `vim.Version` objects, `{major, minor, patch}` tuples, or strings.

### `vim.version.range(spec)`
Parse a semver range spec. Returns a `vim.VersionRange` with `:has(version)` method.

```lua
local r = vim.version.range('>=1.0.0 <2.0.0')
r:has('1.5.0')  -- true
r:has('2.0.0')  -- false
```

**Range spec examples:** `^1.2.3` (compatible), `~1.2.3` (close), `>=1.0`, `1.x`, `1.2.3 - 2.3.4`.

---

## Vimscript Bridge

### `vim.fn.{func}(...)`
Call any Vimscript function. Autoload: `vim.fn['some#function'](...)`. Values are copied (marshalled), not referenced.

### `vim.api.{func}(...)`
Call Nvim API functions directly.

### Variables

| Accessor | Scope |
|---|---|
| `vim.g` | Global (`g:`) |
| `vim.b` / `vim.b[bufnr]` | Buffer (`b:`) |
| `vim.w` / `vim.w[winid]` | Window (`w:`) |
| `vim.t` / `vim.t[tabnr]` | Tab (`t:`) |
| `vim.v` | `v:` variables |
| `vim.env` | Environment variables |

### Options

| Accessor | Equivalent |
|---|---|
| `vim.o` | `:set` |
| `vim.bo` / `vim.bo[bufnr]` | `:setlocal` (buffer) |
| `vim.wo` / `vim.wo[winid]` | `:setlocal` (window) |
| `vim.go` | `:setglobal` |
| `vim.opt` | Rich list/map option interface with `:get()`, `:append()`, `:prepend()`, `:remove()` |

---

## Lua 5.1 Standard Library Summary

Nvim embeds Lua 5.1. These are the standard library modules available:

### `string` -- String Manipulation
Functions for finding, extracting, and pattern matching on strings. First character is at index 1; negative indices count from the end.

Key functions: `string.byte`, `string.char`, `string.find`, `string.format`, `string.gmatch`, `string.gsub`, `string.len`, `string.lower`, `string.match`, `string.rep`, `string.reverse`, `string.sub`, `string.upper`, `string.dump`.

### `table` -- Table Manipulation
Generic functions for array/list-style tables.

Key functions: `table.concat`, `table.insert`, `table.remove`, `table.sort`, `table.maxn`.

### `math` -- Mathematical Functions
Interface to standard C math library.

Key functions/values: `math.abs`, `math.ceil`, `math.floor`, `math.max`, `math.min`, `math.random`, `math.randomseed`, `math.sqrt`, `math.pow`, `math.huge`, `math.pi`, `math.fmod`, `math.sin`, `math.cos`, `math.atan2`, `math.exp`, `math.log`.

### `io` -- Input and Output
Two styles: implicit file descriptors (via `io` table) and explicit descriptors (via file handles from `io.open`).

Key functions: `io.open`, `io.close`, `io.read`, `io.write`, `io.lines`, `io.input`, `io.output`, `io.tmpfile`, `io.type`, `io.popen`, `io.flush`.

### `os` -- Operating System Facilities
Key functions: `os.clock`, `os.date`, `os.time`, `os.difftime`, `os.execute`, `os.exit`, `os.getenv`, `os.remove`, `os.rename`, `os.tmpname`, `os.setlocale`.

### `coroutine` -- Coroutine Manipulation
Stackful coroutines for cooperative multithreading.

Key functions: `coroutine.create`, `coroutine.resume`, `coroutine.yield`, `coroutine.wrap`, `coroutine.status`, `coroutine.running`.
