# Treesitter

Nvim integrates the `tree-sitter` library for incremental parsing of buffers:
https://tree-sitter.github.io/tree-sitter/

## Parser Files

Parsers are libraries that treesitter will search for in the `parser` runtime directory.

Nvim includes these parsers: C, Lua, Markdown, Vimscript, Vimdoc, Treesitter query files.

You can install more parsers manually, or with https://github.com/nvim-treesitter/nvim-treesitter.

Parsers are searched for as `parser/{lang}.*` in any `'runtimepath'` directory. If multiple parsers for the same language are found, the first one is used (priority: user config > plugins > bundled).

To load a parser from its filepath:

```lua
vim.treesitter.language.add('python', { path = "/path/to/python.so" })
```

To associate filetypes with a treesitter language, use `vim.treesitter.language.register()`:

```lua
vim.treesitter.language.register('xml', { 'svg', 'xslt' })
```

### WASM Parsers

If Nvim is built with `ENABLE_WASMTIME`, wasm parsers can also be loaded:

```lua
vim.treesitter.language.add('python', { path = "/path/to/python.wasm" })
```

## Treesitter Queries

Treesitter queries extract information from a parsed `TSTree`, e.g., for highlighting. A `query` consists of one or more patterns. A `pattern` is defined over node types in the syntax tree. A `match` corresponds to specific elements matching a pattern. Patterns may define captures and predicates. A `capture` associates names with a specific node. A `predicate` adds metadata and conditional data to a match.

Queries are written in a lisp-like language documented at:
https://tree-sitter.github.io/tree-sitter/using-parsers/queries/1-syntax.html

Nvim looks for queries as `*.scm` files in a `queries` directory under `runtimepath`, e.g., `queries/lua/highlights.scm`.

### Treesitter Query Predicates

Predicates are special scheme nodes that conditionally capture nodes.

```query
((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))
```

Built-in predicates:

- **`eq?`** -- Match a string against the text of a node:
  ```query
  ((identifier) @variable.builtin (#eq? @variable.builtin "self"))
  ((node1) @left (node2) @right (#eq? @left @right))
  ```

- **`any-eq?`** -- Like `eq?`, but for quantified patterns only one captured node must match.

- **`match?`** / **`vim-match?`** -- Match a regexp against the text of a node:
  ```query
  ((identifier) @constant (#match? @constant "^[A-Z_]+$"))
  ```
  Note: `^` and `$` anchors match start and end of the node's text.

- **`any-match?`** / **`any-vim-match?`** -- Like `match?`, but only one captured node must match.

- **`lua-match?`** -- Match lua-patterns against the text of a node, similar to `match?`.

- **`any-lua-match?`** -- Like `lua-match?`, but only one captured node must match.

- **`contains?`** -- Match a string against parts of the text of a node:
  ```query
  ((identifier) @foo (#contains? @foo "foo"))
  ((identifier) @foo-bar (#contains? @foo-bar "foo" "bar"))
  ```

- **`any-contains?`** -- Like `contains?`, but only one captured node must match.

- **`any-of?`** -- Match any of the given strings against the text of a node:
  ```query
  ((identifier) @foo (#any-of? @foo "foo" "bar"))
  ```
  Recommended way to check if a node matches one of many keywords (optimized).

- **`has-ancestor?`** -- Match any of the given node types against all ancestors of a node:
  ```query
  ((identifier) @variable.builtin
    (#any-of? @variable.builtin "begin" "end")
    (#has-ancestor? @variable.builtin range_expression))
  ```

- **`has-parent?`** -- Match any of the given node types against the direct ancestor of a node:
  ```query
  (((field_expression
       (field_identifier) @method)) @_parent
   (#has-parent? @_parent template_method function_declarator))
  ```

Each predicate has a `not-` prefixed negation (e.g., `not-eq?`).

For quantified captures with multiple nodes, predicates match only if ALL nodes match. Use `any-` prefixed variants to match if ANY node matches.

Further predicates can be added via `vim.treesitter.query.add_predicate()`. Use `vim.treesitter.query.list_predicates()` to list all available predicates.

### Treesitter Query Directives

Directives store metadata for a node or match and perform side effects.

```query
((identifier) @foo (#set! type "parameter"))
```

Built-in directives:

- **`set!`** -- Sets key/value metadata for a match or capture. Value accessible as `metadata[key]` (match) or `metadata[capture_id][key]` (capture).

  Parameters: `{capture_id}` (optional), `{key}`, `{value}`

  ```query
  ((identifier) @foo (#set! @foo kind "parameter"))
  ((node1) @left (node2) @right (#set! type "pair"))
  ((codeblock) @markup.raw.block (#set! priority 90))
  ```

- **`offset!`** -- Applies an offset to the range of the captured node. Sets `metadata[capture_id].offset` as `{ start_row, start_col, end_row, end_col }`. Applied in `vim.treesitter.get_range()`.

  Parameters: `{capture_id}`, `{start_row}`, `{start_col}`, `{end_row}`, `{end_col}`

  ```query
  ((identifier) @constant (#offset! @constant 0 1 0 -1))
  ```

- **`gsub!`** -- Transforms node content using a lua-pattern. Sets `metadata[capture_id].text`.

  Parameters: `{capture_id}`, `{pattern}`, `{replacement}`

  ```query
  (#gsub! @_node ".*%.(.*)" "%1")
  ```

- **`trim!`** -- Trims whitespace from the node. Sets `metadata[capture_id].range`. When only given a capture ID, trims blank lines from the end of the node.

  Parameters: `{capture_id}`, `{trim_start_linewise}`, `{trim_start_charwise}`, `{trim_end_linewise}` (default `1` if only capture_id given), `{trim_end_charwise}`

  ```query
  ; only trim blank lines from the end
  (#trim! @fold)

  ; trim blank lines from both sides
  (#trim! @fold 1 0 1 0)

  ; trim all whitespace around the node
  (#trim! @fold 1 1 1 1)
  ```

Further directives can be added via `vim.treesitter.query.add_directive()`. Use `vim.treesitter.query.list_directives()` to list all available directives.

### Treesitter Query Modelines

Comments in queries starting with `;;` that customize query behavior:

- **`inherits: {lang}...`** -- Specifies that this query should inherit queries from `{lang}`. Recursively descends unless wrapped in parentheses: `({lang})`. Meant for including queries from another language.

- **`extends`** -- Specifies that this query should extend (be merged with) other queries of the same language.

```query
;; inherits: typescript,jsx
;; extends
```

Note: These modeline comments must be at the top of the query.

## Treesitter Syntax Highlighting

Syntax highlighting is specified through queries named `highlights.scm`, which match a `TSNode` in the parsed `TSTree` to a capture assigned a highlight group.

```query
(parameters (identifier) @variable.parameter)
```

Literal expressions can also be matched:

```query
[
  "if"
  "else"
] @keyword.conditional
```

Enable treesitter highlighting for the current buffer via `vim.treesitter.start()`.

### Highlight Groups

Capture names prefixed with `@` are directly usable as highlight groups. Common captures are linked to Nvim's standard highlight groups by default (e.g., `@comment` links to `Comment`).

A fallback system is implemented: more specific groups fall back to more generic ones (e.g., `@comment.documentation` falls back to `@comment`).

Captures can be specialized by language by appending the language name:

```vim
hi @comment.c guifg=Blue
hi @comment.lua guifg=DarkBlue
hi link @comment.documentation.java String
```

### Standard Captures

| Capture | Description |
|---|---|
| `@variable` | various variable names |
| `@variable.builtin` | built-in variable names (e.g. `this`, `self`) |
| `@variable.parameter` | parameters of a function |
| `@variable.parameter.builtin` | special parameters (e.g. `_`, `it`) |
| `@variable.member` | object and struct fields |
| `@constant` | constant identifiers |
| `@constant.builtin` | built-in constant values |
| `@constant.macro` | constants defined by the preprocessor |
| `@module` | modules or namespaces |
| `@module.builtin` | built-in modules or namespaces |
| `@label` | GOTO and other labels, including heredoc labels |
| `@string` | string literals |
| `@string.documentation` | string documenting code (e.g. Python docstrings) |
| `@string.regexp` | regular expressions |
| `@string.escape` | escape sequences |
| `@string.special` | other special strings (e.g. dates) |
| `@string.special.symbol` | symbols or atoms |
| `@string.special.path` | filenames |
| `@string.special.url` | URIs (e.g. hyperlinks) |
| `@character` | character literals |
| `@character.special` | special characters (e.g. wildcards) |
| `@boolean` | boolean literals |
| `@number` | numeric literals |
| `@number.float` | floating-point number literals |
| `@type` | type or class definitions and annotations |
| `@type.builtin` | built-in types |
| `@type.definition` | identifiers in type definitions |
| `@attribute` | attribute annotations (e.g. Python decorators) |
| `@attribute.builtin` | builtin annotations (e.g. `@property` in Python) |
| `@property` | the key in key/value pairs |
| `@function` | function definitions |
| `@function.builtin` | built-in functions |
| `@function.call` | function calls |
| `@function.macro` | preprocessor macros |
| `@function.method` | method definitions |
| `@function.method.call` | method calls |
| `@constructor` | constructor calls and definitions |
| `@operator` | symbolic operators (e.g. `+`, `*`) |
| `@keyword` | keywords not fitting into specific categories |
| `@keyword.coroutine` | keywords related to coroutines |
| `@keyword.function` | keywords that define a function |
| `@keyword.operator` | operators that are English words |
| `@keyword.import` | keywords for including or exporting modules |
| `@keyword.type` | keywords describing namespaces and composite types |
| `@keyword.modifier` | keywords modifying other constructs |
| `@keyword.repeat` | keywords related to loops |
| `@keyword.return` | keywords like `return` and `yield` |
| `@keyword.debug` | keywords related to debugging |
| `@keyword.exception` | keywords related to exceptions |
| `@keyword.conditional` | keywords related to conditionals |
| `@keyword.conditional.ternary` | ternary operator |
| `@keyword.directive` | preprocessor directives and shebangs |
| `@keyword.directive.define` | preprocessor definition directives |
| `@punctuation.delimiter` | delimiters (e.g. `;`, `.`, `,`) |
| `@punctuation.bracket` | brackets (e.g. `()`, `{}`, `[]`) |
| `@punctuation.special` | special symbols (e.g. `{}` in string interpolation) |
| `@comment` | line and block comments |
| `@comment.documentation` | comments documenting code |
| `@comment.error` | error-type comments (e.g. `ERROR`, `FIXME`) |
| `@comment.warning` | warning-type comments (e.g. `WARNING`, `HACK`) |
| `@comment.todo` | todo-type comments (e.g. `TODO`, `WIP`) |
| `@comment.note` | note-type comments (e.g. `NOTE`, `INFO`) |
| `@markup.strong` | bold text |
| `@markup.italic` | italic text |
| `@markup.strikethrough` | struck-through text |
| `@markup.underline` | underlined text |
| `@markup.heading` | headings, titles (including markers) |
| `@markup.heading.1` through `@markup.heading.6` | heading levels |
| `@markup.quote` | block quotes |
| `@markup.math` | math environments |
| `@markup.link` | text references, footnotes, citations |
| `@markup.link.label` | link, reference descriptions |
| `@markup.link.url` | URL-style links |
| `@markup.raw` | literal or verbatim text (e.g. inline code) |
| `@markup.raw.block` | literal or verbatim text as a stand-alone block |
| `@markup.list` | list markers |
| `@markup.list.checked` | checked todo-style list markers |
| `@markup.list.unchecked` | unchecked todo-style list markers |
| `@diff.plus` | added text (for diff files) |
| `@diff.minus` | deleted text (for diff files) |
| `@diff.delta` | changed text (for diff files) |
| `@tag` | XML-style tag names |
| `@tag.builtin` | builtin tag names (e.g. HTML5 tags) |
| `@tag.attribute` | XML-style tag attributes |
| `@tag.delimiter` | XML-style tag delimiters |

### Spell Checking

The `@spell` capture indicates a node should be spell checked:

```query
(comment) @spell
```

`@nospell` disables spellchecking in regions with `@spell`.

### Conceal

Treesitter highlighting supports `conceal` via the `conceal` and `conceal_lines` metadata. By convention, nodes to be concealed are captured as `@conceal`.

```query
((fenced_code_block_delimiter) @conceal (#set! conceal ""))
```

Replace a node with a single character:

```query
"!=" @operator (#set! conceal "≠")
```

Conceal an entire line:

```query
((comment) @comment @spell
  (#set! conceal_lines ""))
```

Only the first character of the conceal string is used. Conceals respect `'conceallevel'` and `'concealcursor'`.

### Priority

Treesitter uses `nvim_buf_set_extmark()` to set highlights with a default priority of 100. Change priority per pattern:

```query
((super_important_node) @superimportant (#set! priority 105))
```

### Commentstring

Treesitter highlighting supports finer-grained `'commentstring'`s via the `bo.commentstring` metadata property (innermost wins):

```query
((jsx_element) @_tag (#set! @_tag bo.commentstring "{/* %s */}"))
```

## Treesitter Language Injections

Some source files contain code written in multiple languages. These are modeled as a parent syntax tree with injected syntax trees residing inside certain nodes.

Injection query captures:

- `@injection.content` -- the captured node should have its contents re-parsed using another language. Multiple captures in one pattern are collected and parsed as one tree.
- `@injection.language` -- the captured node's text may contain the name of a language for re-parsing `@injection.content`.
- `@injection.filename` -- the captured node's text may contain a filename; the filetype is looked up via `vim.filetype.match()`.

Injection properties:

- `injection.language` -- hard-code a specific language name.
- `injection.combined` -- all matching nodes should have content parsed as one nested document.
- `injection.include-children` -- re-parse the entire text of `@injection.content`, including child nodes' text (excluded by default).
- `injection.self` -- parse with the same language as the node's LanguageTree.
- `injection.parent` -- parse with the same language as the node's parent LanguageTree.

To disable injections for a language (e.g., `c`), place an empty `queries/c/injections.scm` file in your `'runtimepath'`.

## vim.treesitter

### `vim.treesitter.language_version`

The latest parser ABI version supported by the bundled treesitter library.

### `vim.treesitter.minimum_language_version`

The earliest parser ABI version supported by the bundled treesitter library.

## Treesitter Trees (TSTree)

A "treesitter tree" represents the parsed contents of a buffer. It is a userdata reference to an object held by the treesitter library.

### `TSTree:copy()`

Returns a copy of the `TSTree`.

- **Return:** `TSTree`

### `TSTree:root()`

Return the root node of this tree.

- **Return:** `TSNode`

## Treesitter Nodes (TSNode)

A "treesitter node" represents one specific element of the parsed contents of a buffer. It is a userdata reference to an object held by the treesitter library.

### `TSNode:byte_length()`

Return the number of bytes spanned by this node.

- **Return:** `integer`

### `TSNode:child({index})`

Get the node's child at the given `{index}`, where zero represents the first child.

- **Parameters:** `{index}` (`integer`)
- **Return:** `TSNode?`

### `TSNode:child_count()`

Get the node's number of children.

- **Return:** `integer`

### `TSNode:child_with_descendant({descendant})`

Get the node's child that contains `{descendant}` (includes `{descendant}`).

```
a -> b -> c

a:child_with_descendant(c) == b
a:child_with_descendant(b) == b
a:child_with_descendant(a) == nil
```

- **Parameters:** `{descendant}` (`TSNode`)
- **Return:** `TSNode?`

### `TSNode:descendant_for_range({start_row}, {start_col}, {end_row}, {end_col})`

Get the smallest node within this node that spans the given range of (row, column) positions.

- **Parameters:** `{start_row}` (`integer`), `{start_col}` (`integer`), `{end_row}` (`integer`), `{end_col}` (`integer`)
- **Return:** `TSNode?`

### `TSNode:end_()`

Get the node's end position. Return three values: the row, column and total byte count (all zero-based).

- **Return:** `integer`, `integer`, `integer`

### `TSNode:equal({node})`

Check if `{node}` refers to the same node within the same tree.

- **Parameters:** `{node}` (`TSNode`)
- **Return:** `boolean`

### `TSNode:extra()`

Check if the node is extra. Extra nodes represent things like comments, which are not required by the grammar but can appear anywhere.

- **Return:** `boolean`

### `TSNode:field({name})`

Returns a list of all the node's children that have the given field name.

- **Parameters:** `{name}` (`string`)
- **Return:** `TSNode[]`

### `TSNode:has_changes()`

Check if a syntax node has been edited.

- **Return:** `boolean`

### `TSNode:has_error()`

Check if the node is a syntax error or contains any syntax errors.

- **Return:** `boolean`

### `TSNode:id()`

Get a unique identifier for the node inside its own tree. Presently a (non-printable) string. Not guaranteed to be unique across different trees.

- **Return:** `string`

### `TSNode:iter_children()`

Iterates over all the direct children of `TSNode`, regardless of whether they are named or not. Returns the child node plus the eventual field name.

- **Return:** `fun(): TSNode, string`

### `TSNode:missing()`

Check if the node is missing. Missing nodes are inserted by the parser to recover from certain kinds of syntax errors.

- **Return:** `boolean`

### `TSNode:named()`

Check if the node is named. Named nodes correspond to named rules in the grammar, whereas anonymous nodes correspond to string literals.

- **Return:** `boolean`

### `TSNode:named_child({index})`

Get the node's named child at the given `{index}`, where zero represents the first named child.

- **Parameters:** `{index}` (`integer`)
- **Return:** `TSNode?`

### `TSNode:named_child_count()`

Get the node's number of named children.

- **Return:** `integer`

### `TSNode:named_children()`

Returns a list of the node's named children.

- **Return:** `TSNode[]`

### `TSNode:named_descendant_for_range({start_row}, {start_col}, {end_row}, {end_col})`

Get the smallest named node within this node that spans the given range of (row, column) positions.

- **Parameters:** `{start_row}` (`integer`), `{start_col}` (`integer`), `{end_row}` (`integer`), `{end_col}` (`integer`)
- **Return:** `TSNode?`

### `TSNode:next_named_sibling()`

Get the node's next named sibling.

- **Return:** `TSNode?`

### `TSNode:next_sibling()`

Get the node's next sibling.

- **Return:** `TSNode?`

### `TSNode:parent()`

Get the node's immediate parent. Prefer `TSNode:child_with_descendant()` for iterating over ancestors.

- **Return:** `TSNode?`

### `TSNode:prev_named_sibling()`

Get the node's previous named sibling.

- **Return:** `TSNode?`

### `TSNode:prev_sibling()`

Get the node's previous sibling.

- **Return:** `TSNode?`

### `TSNode:range({include_bytes})`

Get the range of the node. Return four or six values:
- start row, start column, [start byte], end row, end column, [end byte]

Byte values included when `{include_bytes}` is `true`.

- **Parameters:** `{include_bytes}` (`false?`)
- **Overloads:** `fun(self: TSNode, include_bytes: true): integer, integer, integer, integer, integer, integer`
- **Return:** `integer`, `integer`, `integer`, `integer`

### `TSNode:sexpr()`

Get an S-expression representing the node as a string.

- **Return:** `string`

### `TSNode:start()`

Get the node's start position. Return three values: the row, column and total byte count (all zero-based).

- **Return:** `integer`, `integer`, `integer`

### `TSNode:symbol()`

Get the node's type as a numerical id.

- **Return:** `integer`

### `TSNode:tree()`

Get the `TSTree` of the node.

- **Return:** `TSTree`

### `TSNode:type()`

Get the node's type as a string.

- **Return:** `string`

## Lua module: vim.treesitter

### `vim.treesitter.foldexpr({lnum})`

Returns the fold level for `{lnum}` in the current buffer. Can be set directly to `'foldexpr'`:

```lua
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
```

- Since: 0.9.0
- **Parameters:** `{lnum}` (`integer?`) Line number to calculate fold level for
- **Return:** `string`

### `vim.treesitter.get_captures_at_cursor({winnr})`

Returns a list of highlight capture names under the cursor.

- **Parameters:** `{winnr}` (`integer?`) window-ID or 0 for current window (default)
- **Return:** `string[]` List of capture names

### `vim.treesitter.get_captures_at_pos({bufnr}, {row}, {col})`

Returns a list of highlight captures at the given position. Each capture is represented by a table containing the capture name, language, metadata table, and capture id.

- **Parameters:** `{bufnr}` (`integer`), `{row}` (`integer`), `{col}` (`integer`)
- **Return:** `{capture: string, lang: string, metadata: vim.treesitter.query.TSMetadata, id: integer}[]`

### `vim.treesitter.get_node({opts})`

Returns the smallest named node at the given position.

NOTE: Calling this on an unparsed tree can yield an invalid node. Parse the tree first via:

```lua
vim.treesitter.get_parser(bufnr):parse(range)
```

- **Parameters:** `{opts}` (`table?`) Optional keyword arguments:
  - `{bufnr}` (`integer?`) Buffer number (nil or 0 for current buffer)
  - `{pos}` (`[integer, integer]?`) 0-indexed (row, col) tuple. Defaults to cursor position. Required if `{bufnr}` is not the current buffer
  - `{lang}` (`string?`) Parser language (default: from buffer filetype)
  - `{ignore_injections}` (`boolean?`) Ignore injected languages (default true)
  - `{include_anonymous}` (`boolean?`) Include anonymous nodes (default false)
- **Return:** `TSNode?` Node at the given position

### `vim.treesitter.get_node_range({node_or_range})`

Returns the node's range or an unpacked range table.

- **Parameters:** `{node_or_range}` (`TSNode|Range4`)
- **Return:** `integer` start_row, `integer` start_col, `integer` end_row, `integer` end_col

### `vim.treesitter.get_node_text({node}, {source}, {opts})`

Gets the text corresponding to a given node.

- **Parameters:**
  - `{node}` (`TSNode`)
  - `{source}` (`integer|string`) Buffer or string from which the node is extracted
  - `{opts}` (`table?`) Optional parameters:
    - `metadata` (`table`) Metadata of a specific capture. Set to `metadata[capture_id]` when using `vim.treesitter.query.add_directive()`.
- **Return:** `string`

### `vim.treesitter.get_parser({bufnr}, {lang}, {opts})`

Returns the parser for a specific buffer and attaches it to the buffer. If needed, this will create the parser.

If no parser can be created, an error is thrown. Set `opts.error = false` to suppress this and return nil (and an error message) instead.

- **Parameters:**
  - `{bufnr}` (`integer?`) Buffer the parser should be tied to (default: current buffer)
  - `{lang}` (`string?`) Language of this parser (default: from buffer filetype)
  - `{opts}` (`table?`) Options to pass to the created language tree
- **Return:** `vim.treesitter.LanguageTree?` object to use for parsing, `string?` error message

### `vim.treesitter.get_range({node}, {source}, {metadata})`

Get the range of a `TSNode`. Can also supply `{source}` and `{metadata}` to get the range with directives applied.

- **Parameters:**
  - `{node}` (`TSNode`)
  - `{source}` (`integer|string?`)
  - `{metadata}` (`vim.treesitter.query.TSMetadata?`)
- **Return:** `table` with fields `[1]`..`[6]`: start row, start col, start bytes, end row, end col, end bytes

### `vim.treesitter.get_string_parser({str}, {lang}, {opts})`

Returns a string parser.

- **Parameters:**
  - `{str}` (`string`) Text to parse
  - `{lang}` (`string`) Language of this string
  - `{opts}` (`table?`) Options to pass to the created language tree
- **Return:** `vim.treesitter.LanguageTree`

### `vim.treesitter.inspect_tree({opts})`

Open a window that displays a textual representation of the nodes in the language tree. Can also be shown with `:InspectTree`.

While in the window, press `a` to toggle anonymous nodes, `I` to toggle source language display, `o` to toggle the query editor, and `<Enter>` to jump to the node under the cursor.

- Since: 0.9.0
- **Parameters:** `{opts}` (`table?`) Optional keys:
  - `lang` (`string|nil`) Language of the source buffer
  - `bufnr` (`integer|nil`) Buffer to draw the tree into
  - `winid` (`integer|nil`) Window id to display the tree buffer in
  - `command` (`string|nil`) Vimscript command to create the window (default: `"60vnew"`)
  - `title` (`string|fun(bufnr:integer):string|nil`) Title of the window

### `vim.treesitter.is_ancestor({dest}, {source})`

Determines whether a node is the ancestor of another.

- **Parameters:** `{dest}` (`TSNode`) Possible ancestor, `{source}` (`TSNode`) Possible descendant
- **Return:** `boolean`

### `vim.treesitter.is_in_node_range({node}, {line}, {col})`

Determines whether (line, col) position is in node range.

- **Parameters:** `{node}` (`TSNode`), `{line}` (`integer`) 0-based, `{col}` (`integer`) 0-based
- **Return:** `boolean`

### `vim.treesitter.node_contains({node}, {range})`

Determines if a node contains a range.

- **Parameters:** `{node}` (`TSNode`), `{range}` (`table`)
- **Return:** `boolean`

### `vim.treesitter.start({bufnr}, {lang})`

Starts treesitter highlighting for a buffer. Can be used in an ftplugin or FileType autocommand.

Note: By default, disables regex syntax highlighting. Add `vim.bo.syntax = 'ON'` after the call to `start` if needed.

Note: By default, the highlighter parses code asynchronously, using a segment time of 3ms.

```lua
vim.api.nvim_create_autocmd( 'FileType', { pattern = 'tex',
    callback = function(args)
        vim.treesitter.start(args.buf, 'latex')
        vim.bo[args.buf].syntax = 'ON'  -- only if additional legacy syntax is needed
    end
})
```

- **Parameters:** `{bufnr}` (`integer?`) Buffer to be highlighted (default: current buffer), `{lang}` (`string?`) Language of the parser (default: from buffer filetype)

### `vim.treesitter.stop({bufnr})`

Stops treesitter highlighting for a buffer.

- **Parameters:** `{bufnr}` (`integer?`) Buffer to stop highlighting (default: current buffer)

## Lua module: vim.treesitter.language

### `vim.treesitter.language.add({lang}, {opts})`

Load parser with name `{lang}`. Parsers are searched in the `parser` runtime directory, or the provided `{path}`.

```lua
if vim.treesitter.language.add('markdown') then
  vim.treesitter.start(bufnr, 'markdown')
end
```

- **Parameters:**
  - `{lang}` (`string`) Name of the parser (alphanumerical and `_` only)
  - `{opts}` (`table?`) Options:
    - `{path}?` (`string`) Optional path the parser is located at
    - `{symbol_name}?` (`string`) Internal symbol name for the language to load
- **Return:** `boolean?` True if parser is loaded, `string?` Error if parser cannot be loaded

### `vim.treesitter.language.get_filetypes({lang})`

Returns the filetypes for which a parser named `{lang}` is used. Includes `{lang}` itself plus all filetypes registered via `vim.treesitter.language.register()`.

- **Parameters:** `{lang}` (`string`)
- **Return:** `string[]`

### `vim.treesitter.language.get_lang({filetype})`

Returns the language name to be used when loading a parser for `{filetype}`. If no language has been explicitly registered, defaults to `{filetype}`. For composite filetypes like `html.glimmer`, only the main filetype is returned.

- **Parameters:** `{filetype}` (`string`)
- **Return:** `string?`

### `vim.treesitter.language.inspect({lang})`

Inspects the provided language. Provides ABI version, parser state count, node and field names, and whether the language came from a WASM module. For ABI 15 parsers, also shows parser metadata and supertypes.

- **Parameters:** `{lang}` (`string`)
- **Return:** `TSLangInfo`

### `vim.treesitter.language.register({lang}, {filetype})`

Register a parser named `{lang}` to be used for `{filetype}`(s). Adds or overrides the mapping for `{filetype}`; existing mappings from other filetypes to `{lang}` are preserved.

- **Parameters:** `{lang}` (`string`), `{filetype}` (`string|string[]`)

## Lua module: vim.treesitter.languagetree (LanguageTree)

A `LanguageTree` contains a tree of parsers: the root treesitter parser for `{lang}` and any "injected" language parsers, which themselves may inject other languages, recursively.

To create a LanguageTree (parser object) for a given buffer and language:

```lua
local parser = vim.treesitter.get_parser(bufnr, lang)
```

Parse the buffer to access the current syntax tree:

```lua
local tree = parser:parse({ start_row, end_row })
```

This returns a table of immutable tree objects. If the buffer wasn't edited, the same tree is returned without extra work. If edited, incremental parsing is done.

### `LanguageTree:children()`

Returns a map of language to child tree.

- **Return:** `table<string, vim.treesitter.LanguageTree>`

### `LanguageTree:contains({range})`

Determines whether `{range}` is contained in the LanguageTree.

- **Parameters:** `{range}` (`table`) `{[1]}` start row, `{[2]}` start col, `{[3]}` end row, `{[4]}` end col
- **Return:** `boolean`

### `LanguageTree:destroy()`

Destroys this LanguageTree and all its children. Does NOT remove this tree from a parent; `remove_child` must be called on the parent.

### `LanguageTree:for_each_tree({fn})`

Invokes the callback for each LanguageTree recursively (including the invoking tree's children).

- **Parameters:** `{fn}` (`fun(tree: TSTree, ltree: vim.treesitter.LanguageTree)`)

### `LanguageTree:included_regions()`

Gets the set of included regions managed by this LanguageTree. Each list represents a range as `{ start_row, start_col, start_bytes, end_row, end_col, end_bytes }`.

- **Return:** `table<integer, Range6[]>`

### `LanguageTree:invalidate({reload})`

Invalidates this parser and its children. Should only be called when the tracked state is not valid against the parse tree.

- **Parameters:** `{reload}` (`boolean?`)

### `LanguageTree:is_valid({exclude_children}, {range})`

Returns whether this LanguageTree is valid (trees reflect the latest state of the source). If invalid, call `LanguageTree:parse()`.

- **Parameters:**
  - `{exclude_children}` (`boolean?`) whether to ignore children validity (default `false`)
  - `{range}` (`Range|Range[]?`) range(s) to check for validity
- **Return:** `boolean`

### `LanguageTree:lang()`

Gets the language of this tree node.

- **Return:** `string`

### `LanguageTree:language_for_range({range})`

Gets the appropriate language that contains `{range}`.

- **Parameters:** `{range}` (`table`) `{[1]}` start row, `{[2]}` start col, `{[3]}` end row, `{[4]}` end col
- **Return:** `vim.treesitter.LanguageTree`

### `LanguageTree:named_node_for_range({range}, {opts})`

Gets the smallest named node that contains `{range}`.

- **Parameters:**
  - `{range}` (`table`) `{[1]}` start row, `{[2]}` start col, `{[3]}` end row, `{[4]}` end col
  - `{opts}` (`table?`) `{ignore_injections}?` (`boolean`, default: `true`)
- **Return:** `TSNode?`

### `LanguageTree:node_for_range({range}, {opts})`

Gets the smallest node that contains `{range}`.

- **Parameters:**
  - `{range}` (`table`) `{[1]}` start row, `{[2]}` start col, `{[3]}` end row, `{[4]}` end col
  - `{opts}` (`table?`) `{ignore_injections}?` (`boolean`, default: `true`)
- **Return:** `TSNode?`

### `LanguageTree:parent()`

Returns the parent tree. `nil` for the root tree.

- **Return:** `vim.treesitter.LanguageTree?`

### `LanguageTree:parse({range}, {on_parse})`

Recursively parse all regions in the language tree using parsers for the corresponding languages and run injection queries on the parsed trees.

Any region with empty range (`{}`, typically only the root tree) is always parsed; otherwise only if it intersects `{range}` (or if `{range}` is `true`).

- **Parameters:**
  - `{range}` (`boolean|Range|Range[]?`) Parse this range in the parser's source. Set to `true` to run a complete parse (can be slow). Set to `false|nil` to only parse regions with empty ranges.
  - `{on_parse}` (`fun(err?: string, trees?: table<integer, TSTree>)?`) Function invoked when parsing completes. When provided, parsing runs asynchronously. First argument is error type string (on failure), second is the list of trees (on success) or `nil` on timeout (determined by `'redrawtime'`). If parsing finishes synchronously (within 3ms), `parse()` returns the list of trees; otherwise returns `nil`.
- **Return:** `table<integer, TSTree>?`

### `LanguageTree:register_cbs({cbs}, {recursive})`

Registers callbacks for the LanguageTree.

- **Parameters:**
  - `{cbs}` (`table<TSCallbackNameOn, function>`) Handlers:
    - `on_bytes`: see `nvim_buf_attach()`
    - `on_changedtree`: called on syntactical changes; receives ranges and changed tree
    - `on_child_added`: emitted when a child is added
    - `on_child_removed`: emitted when a child is removed
    - `on_detach`: emitted when buffer is detached; receives buffer number
  - `{recursive}` (`boolean?`) Apply callbacks recursively for all children; new children also inherit callbacks

### `LanguageTree:source()`

Returns the source content of the language tree (bufnr or string).

- **Return:** `integer|string`

### `LanguageTree:tree_for_range({range}, {opts})`

Gets the tree that contains `{range}`.

- **Parameters:**
  - `{range}` (`table`) `{[1]}` start row, `{[2]}` start col, `{[3]}` end row, `{[4]}` end col
  - `{opts}` (`table?`) `{ignore_injections}?` (`boolean`, default: `true`)
- **Return:** `TSTree?`

### `LanguageTree:trees()`

Returns all trees of the regions parsed by this parser. Does not include child languages. The result is list-like if this LanguageTree is the root (empty or singleton list) or the root LanguageTree is fully parsed.

- **Return:** `table<integer, TSTree>`

## Lua module: vim.treesitter.query

This interface allows you to create queries and use them to parse text. See `vim.treesitter.query.parse()` for a working example.

### `vim.treesitter.Query`

Parsed query object. Fields:

- `{lang}` (`string`) parser language name
- `{captures}` (`string[]`) list of (unique) capture names defined in query
- `{info}` (`vim.treesitter.QueryInfo`) query context (captures, predicates, directives)
- `{has_conceal_line}` (`boolean`) whether the query sets conceal_lines metadata
- `{has_combined_injections}` (`boolean`) whether the query contains combined injections
- `{query}` (`TSQuery`) userdata query object
- `{iter_captures}` -- See `Query:iter_captures()`
- `{iter_matches}` -- See `Query:iter_matches()`

### `vim.treesitter.query.add_directive({name}, {handler}, {opts})`

Adds a new directive to be used in queries. Handlers can set match level data via `metadata.key = value` and node level data via `metadata[capture_id].key = value`.

- **Parameters:**
  - `{name}` (`string`) Name of the directive, without leading `#`
  - `{handler}` (`fun(match: table<integer,TSNode[]>, pattern: integer, source: integer|string, predicate: any[], metadata: vim.treesitter.query.TSMetadata)`)
  - `{opts}` (`table`)
    - `{force}?` (`boolean`) Override existing predicate of the same name
    - `{all}?` (`boolean`) Use correct match table where capture IDs map to a list of nodes (default true, will be removed in future)

### `vim.treesitter.query.add_predicate({name}, {handler}, {opts})`

Adds a new predicate to be used in queries.

- **Parameters:**
  - `{name}` (`string`) Name of the predicate, without leading `#`
  - `{handler}` (`fun(match: table<integer,TSNode[]>, pattern: integer, source: integer|string, predicate: any[], metadata: vim.treesitter.query.TSMetadata): boolean?`)
  - `{opts}` (`table?`)
    - `{force}?` (`boolean`) Override existing predicate
    - `{all}?` (`boolean`) Use correct match table (default true, will be removed)

### `vim.treesitter.query.edit({lang})`

Opens a live editor to query the buffer you started from. Can also be shown with `:EditQuery`. Move cursor to a capture name (`@foo`) to highlight matching text in the source buffer. The query editor is a scratch buffer; use `:write` to save.

- **Parameters:** `{lang}` (`string?`) Language to open the query editor for (default: inferred from buffer filetype)

### `vim.treesitter.query.get({lang}, {query_name})`

Returns the runtime query `{query_name}` for `{lang}`.

- **Parameters:** `{lang}` (`string`), `{query_name}` (`string`) Name of the query (e.g. `"highlights"`)
- **Return:** `vim.treesitter.Query?` Parsed query. `nil` if no query files are found.

### `vim.treesitter.query.get_files({lang}, {query_name}, {is_included})`

Gets the list of files used to make up a query.

- **Parameters:** `{lang}` (`string`), `{query_name}` (`string`), `{is_included}` (`boolean?`)
- **Return:** `string[]` List of files to load for given query and language

### `vim.treesitter.query.lint({buf}, {opts})`

Lint treesitter queries using installed parser, or clear lint errors. Verifies valid node identifiers, predicates/directives, and top-level s-expressions. Diagnostics reported via the diagnostic API.

- **Parameters:**
  - `{buf}` (`integer`) Buffer handle
  - `{opts}` (`table?`)
    - `{langs}?` (`string|string[]`) Language(s) to use for checking
    - `{clear}` (`boolean`) Just clear current lint errors

### `vim.treesitter.query.list_directives()`

Lists the currently available directives to use in queries.

- **Return:** `string[]`

### `vim.treesitter.query.list_predicates()`

Lists the currently available predicates to use in queries.

- **Return:** `string[]`

### `vim.treesitter.query.omnifunc({findstart}, {base})`

Omnifunc for completing node names and predicates in treesitter queries.

```lua
vim.bo.omnifunc = 'v:lua.vim.treesitter.query.omnifunc'
```

- **Parameters:** `{findstart}` (`0|1`), `{base}` (`string`)

### `vim.treesitter.query.parse({lang}, {query})`

Parses a `{query}` string and returns a `Query` object, which can be used to search the tree for patterns via `Query:iter_captures()` or `Query:iter_matches()`.

Fields on the result:
- `captures`: list of unique capture names (alias: `info.captures`)
- `info.patterns`: information about predicates
- `query`: the underlying `TSQuery` (can disable patterns or captures)

```lua
local query = vim.treesitter.query.parse('vimdoc', [[
  ; query
  ((h1) @str
    (#trim! @str 1 1 1 1))
]])
local tree = vim.treesitter.get_parser():parse()[1]
for id, node, metadata in query:iter_captures(tree:root(), 0) do
   vim.print({node:type(), vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())})
end
```

- **Parameters:** `{lang}` (`string`), `{query}` (`string`) Query text in s-expr syntax
- **Return:** `vim.treesitter.Query`

### `Query:iter_captures({node}, {source}, {start_row}, {end_row}, {opts})`

Iterates over all captures from all matches in `{node}`. `{source}` is required if the query contains predicates. `{start_row}` and `{end_row}` limit matches to a row range.

The iterator returns four values: capture id, captured node, metadata, match.

```lua
for id, node, metadata, match in query:iter_captures(tree:root(), bufnr, first, last) do
  local name = query.captures[id] -- name of the capture in the query
  local type = node:type() -- type of the captured node
  local row1, col1, row2, col2 = node:range() -- range of the capture
end
```

- **Parameters:**
  - `{node}` (`TSNode`) under which the search will occur
  - `{source}` (`integer|string`) Source buffer or string to extract text from
  - `{start_row}` (`integer?`) Starting line (default: `node:start()`)
  - `{end_row}` (`integer?`) Stopping line, end-inclusive unless `stop_col` provided (default: `node:end_()`)
  - `{opts}` (`table?`)
    - `max_start_depth` (`integer`) maximum start depth for each match
    - `match_limit` (`integer`) maximum in-progress matches (default: 256)
    - `start_col` (`integer`) starting column
    - `end_col` (`integer`) stopping column (end-exclusive)
- **Return:** `fun(end_line: integer?, end_col: integer?): integer, TSNode, vim.treesitter.query.TSMetadata, TSQueryMatch, TSTree`

### `Query:iter_matches({node}, {source}, {start}, {stop}, {opts})`

Iterates the matches of self on a given range. The iterated values are: pattern index (1-based), table mapping capture indices to lists of nodes, and metadata.

```lua
for pattern, match, metadata in cquery:iter_matches(tree:root(), bufnr, 0, -1) do
  for id, nodes in pairs(match) do
    local name = query.captures[id]
    for _, node in ipairs(nodes) do
      local node_data = metadata[id] -- Node level metadata
    end
  end
end
```

- **Parameters:**
  - `{node}` (`TSNode`) under which the search will occur
  - `{source}` (`integer|string`) Source buffer or string to search
  - `{start}` (`integer?`) Starting line (default: `node:start()`)
  - `{stop}` (`integer?`) Stopping line, end-exclusive (default: `node:end_()`)
  - `{opts}` (`table?`)
    - `max_start_depth` (`integer`) maximum start depth for each match
    - `match_limit` (`integer`) maximum in-progress matches (default: 256)
    - `all` (`boolean`) When `false` (default `true`), maps capture IDs to a single (last) node instead of the full list. Backward compatibility option, will be removed.
- **Return:** `fun(): integer, table<integer, TSNode[]>, vim.treesitter.query.TSMetadata, TSTree`

### `vim.treesitter.query.set({lang}, {query_name}, {text})`

Sets the runtime query named `{query_name}` for `{lang}`. Allows users to override or extend runtime files and plugin configurations.

```lua
vim.treesitter.query.set(
  'c',
  'highlights',
  [[;inherits c
  (identifier) @spell]])
```

- **Parameters:** `{lang}` (`string`), `{query_name}` (`string`), `{text}` (`string`) Query text (unparsed)

### TSQuery

Extends: userdata. Reference to an object held by the treesitter library, used as a component of `vim.treesitter.Query`.

Fields:

- `{disable_capture}` (`fun(self: TSQuery, capture_name: string)`) See `TSQuery:disable_capture()`
- `{disable_pattern}` (`fun(self: TSQuery, pattern_index: integer)`) See `TSQuery:disable_pattern()`

### `TSQuery:disable_capture({capture_name})`

Disable a specific capture in this query; once disabled it cannot be re-enabled. `{capture_name}` should not include a leading `@`.

```lua
local query = vim.treesitter.query.get('vimdoc', 'highlights')
query.query:disable_capture("variable.parameter")
vim.treesitter.get_parser():parse()
```

- **Parameters:** `{capture_name}` (`string`)

### `TSQuery:disable_pattern({pattern_index})`

Disable a specific pattern in this query; once disabled it cannot be re-enabled. The `{pattern_index}` can be obtained with `:Inspect!` or by reading the source of the query.

```lua
local link_pattern = 9 -- from :Inspect!
local query = vim.treesitter.query.get('vimdoc', 'highlights')
query.query:disable_pattern(link_pattern)
local tree = vim.treesitter.get_parser():parse()[1]
```

- **Parameters:** `{pattern_index}` (`integer`)
