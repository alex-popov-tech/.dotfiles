# Vimscript & Built-in Functions

Curated reference from Neovim's `vimeval.txt` and `vimfn.txt`.
For the full function reference, grep the source: `runtime/doc/vimfn.txt`.

## Table of Contents

- [Data Types](#data-types)
- [Expression Syntax](#expression-syntax)
- [Variable Scoping](#variable-scoping)
- [Lambda Expressions](#lambda-expressions)
- [Using vim.cmd() from Lua](#using-vimcmd-from-lua)
- [Built-in Functions](#built-in-functions)
  - [Buffer / Window](#buffer--window)
  - [String](#string)
  - [List / Dict / Functional](#list--dict--functional)
  - [File / Path](#file--path)
  - [System / Feature Detection](#system--feature-detection)
  - [UI / Input](#ui--input)
  - [Registers / Marks / Quickfix](#registers--marks--quickfix)
  - [Search / Pattern](#search--pattern)
  - [Timer / JSON / Misc](#timer--json--misc)

---

## Data Types

Seven types of variables:

| Type       | Description                                           | Example                              |
|------------|-------------------------------------------------------|--------------------------------------|
| Number     | 32 or 64 bit signed integer                           | `-123`, `0x10`, `0b1011`, `0o177`    |
| Float      | Floating point number                                 | `123.456`, `1.15e-6`, `-1.1e3`       |
| String     | NUL-terminated bytes                                  | `"ab\txx\"--"`, `'x-z''a,c'`         |
| Funcref    | Reference to a function (may be a partial)            | `function("strlen")`                 |
| List       | Ordered sequence of items                             | `[1, 2, ['a', 'b']]`                 |
| Dictionary | Associative array (key-value pairs)                   | `{"blue": "#0000ff"}`, `#{blue: "x"}`|
| Blob       | Binary large object (byte sequence)                   | `0zFF00ED015DAF`                     |

Number and String convert automatically depending on context. String-to-Number conversion uses leading digits (`"123abc"` becomes `123`; `"abc"` becomes `0`).

## Expression Syntax

Summary from least to most significant precedence:

```
expr2 ? expr1 : expr1          ternary if-then-else
expr2 ?? expr1                 falsy (null coalescing) operator

expr3 || expr3 ...             logical OR  (short-circuits)
expr4 && expr4 ...             logical AND (short-circuits)

expr5 == != > >= < <= =~ !~    comparison (append # for match-case, ? for ignore-case)
expr5 is / isnot               same/different instance (List, Dict, Blob)

expr6 +  expr6                 addition, List/Blob concatenation
expr6 -  expr6                 subtraction
expr6 .. expr6                 string concatenation (preferred over single .)

expr7 *  expr7                 multiplication
expr7 /  expr7                 division
expr7 %  expr7                 modulo

! expr7                        logical NOT
- expr7                        unary minus
+ expr7                        unary plus

expr8[expr1]                   index (byte of String, item of List)
expr8[a : b]                   slice (substring or sublist, inclusive)
expr8.name                     Dict entry access
expr8(args)                    Funcref call
expr8->name(args)              method call (chaining)
expr8->{lambda}(args)          method call with lambda
```

**Comparison operators** -- the default depends on `'ignorecase'`:
- `==#`, `!=#`, `>#`, etc. -- always match case
- `==?`, `!=?`, `>?`, etc. -- always ignore case

**String concatenation** -- prefer `..` over `.` to avoid ambiguity with Dict access and floats.

**Method chaining:**
```vim
mylist->filter(expr)->map(expr)->sort()->join()
```

## Variable Scoping

| Prefix | Scope                          | Notes                                    |
|--------|--------------------------------|------------------------------------------|
| `g:`   | Global                         | Required inside functions; optional elsewhere |
| `b:`   | Buffer-local                   | Deleted when buffer is wiped out         |
| `w:`   | Window-local                   | Deleted when window is closed            |
| `t:`   | Tab-page-local                 | Deleted when tab page is closed          |
| `l:`   | Function-local                 | Default inside functions (prefix optional) |
| `s:`   | Script-local                   | Not accessible from outside the script   |
| `a:`   | Function argument              | Read-only; `a:0` = extra arg count, `a:000` = list of extra args |
| `v:`   | Vim-predefined                 | Global, set by Vim (e.g. `v:count`, `v:errmsg`) |

The scope prefix by itself is a Dict: `keys(s:)` returns all script-local variable names.

**Options as expressions:**
- `&option` -- local value if available, else global
- `&g:option` -- global value
- `&l:option` -- local value

**Environment / Registers:**
- `$VAR` -- environment variable
- `@r` -- contents of register `r` (e.g. `@"` for unnamed, `@+` for clipboard)

## Lambda Expressions

```vim
{args -> expr1}
```

A lambda creates an unnamed function returning the result of `expr1`. No `a:` prefix on arguments.

```vim
let F = {arg1, arg2 -> arg1 - arg2}
echo F(5, 2)                        " 3

" No-argument lambda:
let F = {-> 'hello'}

" With sort/map/filter:
echo map([1, 2, 3], {idx, val -> val + 1})    " [2, 3, 4]
echo sort([3,7,2,1,4], {a, b -> a - b})       " [1, 2, 3, 4, 7]
```

**Closures** -- lambdas can capture outer-scope variables:

```vim
function Foo(arg)
  let i = 3
  return {x -> x + i - a:arg}
endfunction
let Bar = Foo(4)
echo Bar(6)         " 5
```

**Method chaining with lambdas:**

```vim
GetPercentage()->{x -> x * 100}()->printf('%d%%')
```

**Timers:**

```vim
let timer = timer_start(500,
    \ {-> execute("echo 'Handler called'", "")},
    \ {'repeat': 3})
```

## Using vim.cmd() from Lua

In Neovim Lua, execute Vimscript via `vim.cmd()`:

```lua
vim.cmd('echo "hello"')
vim.cmd('set number')
vim.cmd([[
  augroup MyGroup
    autocmd!
    autocmd BufEnter * echo "entered"
  augroup END
]])

-- Structured form (avoids string escaping):
vim.cmd { cmd = 'echo', args = { '"hello"' } }
vim.cmd.edit('file.txt')          -- same as :edit file.txt
vim.cmd.highlight({ args = { 'Normal', 'guibg=#1e1e2e' } })
```

Call Vimscript functions from Lua with `vim.fn`:

```lua
local name = vim.fn.bufname(0)
local lines = vim.fn.getline(1, '$')
vim.fn.setline(1, 'replacement')
```

---

## Built-in Functions

Compact alphabetical listing per category. Signature and one-line description.

### Buffer / Window

| Function | Description |
|----------|-------------|
| `append({lnum}, {text})` | Append {text} (string or list) below line {lnum} in current buffer |
| `appendbufline({buf}, {lnum}, {text})` | Like `append()` but in buffer {buf} |
| `bufadd({name})` | Add a buffer to the buffer list with name {name}; returns buffer number |
| `bufexists({buf})` | TRUE if buffer {buf} exists |
| `buflisted({buf})` | TRUE if buffer {buf} exists and is listed |
| `bufloaded({buf})` | TRUE if buffer {buf} exists and is loaded |
| `bufname([{buf}])` | Return the name of buffer {buf} |
| `bufnr([{buf} [, {create}]])` | Return the number of buffer {buf} |
| `bufwinid({buf})` | Return window-ID of first window showing buffer {buf} |
| `bufwinnr({buf})` | Like `bufwinid()` but returns window number |
| `col({expr} [, {winid}])` | Return byte index of column position {expr} |
| `cursor({lnum}, {col} [, {off}])` | Position cursor at {lnum}, {col} |
| `deletebufline({buf}, {first} [, {last}])` | Delete lines {first} to {last} from buffer {buf} |
| `getbufinfo([{buf}])` | Get buffer info as a list of Dicts |
| `getbufline({buf}, {lnum} [, {end}])` | Return list of lines from buffer {buf} |
| `getbufoneline({buf}, {lnum})` | Get one line from buffer as a string |
| `getbufvar({buf}, {varname} [, {def}])` | Get option/variable value from buffer {buf} |
| `getline({lnum} [, {end}])` | Return line {lnum} (or list of lines to {end}) from current buffer |
| `getpos({expr})` | Get position (returns `[bufnum, lnum, col, off]`) |
| `getwininfo([{winid}])` | Get window info as a list of Dicts |
| `getwinvar({winnr}, {varname} [, {def}])` | Get window variable value |
| `line({expr} [, {winid}])` | Return line number for position {expr} |
| `setbufline({buf}, {lnum}, {text})` | Set line {lnum} in buffer {buf} to {text} |
| `setbufvar({buf}, {varname}, {val})` | Set option/variable in buffer {buf} |
| `setline({lnum}, {text})` | Set line {lnum} to {text} in current buffer |
| `setpos({expr}, {list})` | Set position (cursor, mark, etc.) |
| `setwinvar({nr}, {varname}, {val})` | Set window variable |
| `tabpagebuflist([{arg}])` | List of buffer numbers in a tab page |
| `tabpagenr([{arg}])` | Current tab page number |
| `winbufnr({nr})` | Buffer number associated with window {nr} |
| `wincol()` | Screen column of the cursor in the window |
| `win_execute({id}, {command} [, {silent}])` | Execute command in context of window {id} |
| `win_findbuf({bufnr})` | List of window-IDs containing buffer {bufnr} |
| `win_getid([{win} [, {tab}]])` | Get window-ID for the specified window |
| `win_gotoid({expr})` | Go to window with ID {expr} |
| `winheight({nr})` | Height of window {nr} |
| `winline()` | Screen line of cursor within window |
| `winnr([{arg}])` | Current window number |
| `winrestview({dict})` | Restore window view from Dict returned by `winsaveview()` |
| `winsaveview()` | Save window view (cursor pos, topline, etc.) as a Dict |
| `winwidth({nr})` | Width of window {nr} |

### String

| Function | Description |
|----------|-------------|
| `char2nr({string})` | Return numeric value of first character |
| `escape({string}, {chars})` | Escape chars in {string} with backslash |
| `fnameescape({string})` | Escape string for use as a filename argument |
| `join({list} [, {sep}])` | Join list items into one string, separated by {sep} (default: space) |
| `matchstr({expr}, {pat} [, {start} [, {count}]])` | Return matched string from {expr} |
| `nr2char({expr})` | Return character with numeric value {expr} |
| `printf({fmt}, {expr1} ...)` | Formatted string (like C printf) |
| `shellescape({string} [, {special}])` | Escape string for use as shell argument |
| `split({string} [, {pattern} [, {keepempty}]])` | Split string into a List |
| `str2nr({string} [, {base}])` | Convert string to Number (base 2, 8, 10, or 16) |
| `strcharlen({string})` | Number of characters (composing chars ignored) |
| `strcharpart({src}, {start} [, {len}])` | Like `strpart()` but character-indexed |
| `strchars({string} [, {skipcc}])` | Number of characters (composing chars counted unless skipcc) |
| `strdisplaywidth({string} [, {col}])` | Display cell width of string |
| `strftime({format} [, {time}])` | Format date/time string |
| `stridx({haystack}, {needle} [, {start}])` | Byte index of first occurrence of {needle} |
| `string({expr})` | Convert expression to its String representation |
| `strlen({string})` | Length of string in bytes |
| `strpart({src}, {start} [, {len} [, {chars}]])` | Substring by byte position |
| `strridx({haystack}, {needle} [, {start}])` | Byte index of last occurrence of {needle} |
| `strtrans({string})` | Translate unprintable characters to printable |
| `strwidth({string})` | Display cell width of string |
| `substitute({string}, {pat}, {sub}, {flags})` | Replace first/all matches of {pat} with {sub} |
| `tolower({expr})` | Convert to lowercase |
| `toupper({expr})` | Convert to uppercase |
| `tr({src}, {fromstr}, {tostr})` | Transliterate characters (like Unix tr) |
| `trim({text} [, {mask} [, {dir}]])` | Trim characters from beginning/end of string |

### List / Dict / Functional

| Function | Description |
|----------|-------------|
| `add({object}, {expr})` | Append item to List or Blob; returns modified object |
| `copy({expr})` | Shallow copy of List or Dict |
| `count({comp}, {expr} [, {ic}])` | Count occurrences of {expr} in String, List, or Dict |
| `deepcopy({expr} [, {noref}])` | Deep copy of nested List/Dict |
| `empty({expr})` | TRUE if {expr} is empty (0, "", [], {}, etc.) |
| `extend({expr1}, {expr2} [, {expr3}])` | Extend List or Dict in-place |
| `extendnew({expr1}, {expr2} [, {expr3}])` | Like `extend()` but returns a new List/Dict |
| `filter({expr1}, {expr2})` | Remove items where {expr2} is false; modifies in-place |
| `flatten({list} [, {maxdepth}])` | Flatten nested List in-place |
| `flattennew({list} [, {maxdepth}])` | Like `flatten()` but returns a new List |
| `foreach({expr1}, {expr2})` | Execute {expr2} for each item; does not modify {expr1} |
| `get({list}, {idx} [, {default}])` | Get item safely; returns {default} if missing |
| `get({dict}, {key} [, {default}])` | Get item safely from Dict |
| `has_key({dict}, {key})` | TRUE if Dict has entry with {key} |
| `index({object}, {expr} [, {start} [, {ic}]])` | Find {expr} in List, return its index (-1 if not found) |
| `indexof({object}, {expr} [, {opts}])` | Index where lambda {expr} returns true |
| `insert({object}, {item} [, {idx}])` | Insert item at position {idx} (default: start) |
| `items({expr})` | Return List of `[key, value]` pairs from Dict (or `[idx, val]` from List) |
| `keys({dict})` | Return List of all keys |
| `len({expr})` | Length (bytes for String, items for List, entries for Dict) |
| `map({expr1}, {expr2})` | Transform each item in-place; {expr2} receives `(key/idx, val)` |
| `mapnew({expr1}, {expr2})` | Like `map()` but returns a new List/Dict |
| `max({expr})` | Maximum value in List or Dict |
| `min({expr})` | Minimum value in List or Dict |
| `reduce({object}, {func} [, {initial}])` | Reduce List/Blob/String with accumulator function |
| `remove({list}, {idx} [, {end}])` | Remove item(s) from List/Dict/Blob; returns removed item(s) |
| `repeat({expr}, {count})` | Repeat expr N times (works on String and List) |
| `reverse({object})` | Reverse List, Blob, or String in-place |
| `range({expr} [, {max} [, {stride}]])` | Generate List of Numbers `[0..expr-1]` or `[expr..max]` |
| `slice({expr}, {start} [, {end}])` | Like `expr[start:end]` but end is exclusive |
| `sort({list} [, {how} [, {dict}]])` | Sort List in-place |
| `uniq({list} [, {func}])` | Remove adjacent duplicate items from sorted List |
| `values({dict})` | Return List of all values |

### File / Path

| Function | Description |
|----------|-------------|
| `chdir({dir} [, {scope}])` | Change current directory; returns previous dir |
| `delete({fname} [, {flags}])` | Delete file or directory |
| `expand({string} [, {nosuf} [, {list}]])` | Expand wildcards, `%`, `#`, `<cword>`, etc. |
| `filereadable({file})` | TRUE if file exists and is readable |
| `fnamemodify({fname}, {mods})` | Modify filename (`:p` full, `:h` head, `:t` tail, `:r` root, `:e` ext) |
| `getcwd([{winnr} [, {tabnr}]])` | Get current working directory |
| `glob({expr} [, {nosuf} [, {list}]])` | Expand file wildcards; returns string or List |
| `globpath({path}, {expr} [, {nosuf} [, {list}]])` | Glob across all directories in {path} |
| `isdirectory({directory})` | TRUE if {directory} exists |
| `mkdir({name} [, {flags} [, {prot}]])` | Create directory (`"p"` flag for mkdir -p) |
| `pathshorten({path} [, {len}])` | Shorten directory names in path |
| `readfile({fname} [, {type} [, {max}]])` | Read file into a List (one item per line) |
| `resolve({filename})` | Resolve symlinks to their target |
| `simplify({filename})` | Simplify path (remove `.` and `..` components) |
| `tempname()` | Generate a unique temporary filename |
| `writefile({object}, {fname} [, {flags}])` | Write List or Blob to file |

### System / Feature Detection

| Function | Description |
|----------|-------------|
| `executable({expr})` | TRUE if program {expr} exists and is executable |
| `execute({command} [, {silent}])` | Execute Ex command and capture output as string |
| `exists({expr})` | TRUE if variable, function, command, option, etc. exists |
| `has({feature})` | TRUE if feature is supported (e.g. `"nvim-0.9"`, `"python3"`, `"unix"`) |
| `mode([{expr}])` | Return string indicating current mode (`"n"`, `"i"`, `"v"`, etc.) |
| `system({cmd} [, {input}])` | Execute shell command, return output as String |
| `systemlist({cmd} [, {input}])` | Like `system()` but returns List of lines |
| `type({expr})` | Return type number (0=Number, 1=String, 2=Funcref, 3=List, 4=Dict, 5=Float, 10=Blob) |
| `visualmode([{expr}])` | Return last Visual mode used (`"v"`, `"V"`, `CTRL-V`) |

### UI / Input

| Function | Description |
|----------|-------------|
| `confirm({msg} [, {choices} [, {default} [, {type}]]])` | Show dialog, return choice number |
| `feedkeys({string} [, {mode}])` | Queue keystrokes as if typed or from a mapping |
| `getchar([{expr} [, {opts}]])` | Get a single character from the user |
| `input({prompt} [, {text} [, {completion}]])` | Prompt user for input on the command line |
| `inputlist({textlist})` | Display list of strings and prompt for a number selection |

### Registers / Marks / Quickfix

| Function | Description |
|----------|-------------|
| `call({func}, {arglist} [, {dict}])` | Call function with args from a List |
| `function({name} [, {arglist}] [, {dict}])` | Return a Funcref to function {name} |
| `funcref({name} [, {arglist}] [, {dict}])` | Return a Funcref (by reference, not by name) |
| `getreg([{regname} [, 1 [, {list}]]])` | Get contents of register |
| `setreg({regname}, {value} [, {options}])` | Set register contents |
| `getqflist([{what}])` | Get quickfix list |
| `setqflist({list} [, {action} [, {what}]])` | Create/replace/add to quickfix list |
| `getloclist({nr} [, {what}])` | Get location list for window {nr} |
| `setloclist({nr}, {list} [, {action} [, {what}]])` | Create/replace/add to location list |

### Search / Pattern

| Function | Description |
|----------|-------------|
| `match({expr}, {pat} [, {start} [, {count}]])` | Index of first match of {pat} in {expr} (-1 if none) |
| `matchend({expr}, {pat} [, {start} [, {count}]])` | Index of first char after match |
| `matchfuzzy({list}, {str} [, {dict}])` | Fuzzy-match {str} against a list of strings |
| `matchlist({expr}, {pat} [, {start} [, {count}]])` | Return List of matched groups (like sub-match capture) |
| `search({pat} [, {flags} [, {stopline} [, {timeout}]]])` | Search for pattern; returns line number |
| `searchpos({pat} [, {flags} [, {stopline} [, {timeout}]]])` | Like `search()` but returns `[lnum, col]` |
| `submatch({nr} [, {list}])` | Return submatch in a `:substitute` expression |

### Timer / JSON / Misc

| Function | Description |
|----------|-------------|
| `abs({expr})` | Absolute value |
| `deepcopy({expr} [, {noref}])` | Deep copy of nested structure |
| `eval({string})` | Evaluate Vimscript expression string |
| `histget({history} [, {index}])` | Get entry from command/search history |
| `json_decode({expr})` | Parse JSON string to Vim value |
| `json_encode({expr})` | Convert Vim value to JSON string |
| `localtime()` | Current time as seconds since Unix epoch |
| `timer_start({time}, {callback} [, {options}])` | Create timer; returns timer ID. Use `{'repeat': N}` or `{'repeat': -1}` |
| `timer_stop({timer})` | Stop a timer by ID |
| `undotree([{buf}])` | Return the undo tree structure for a buffer |
