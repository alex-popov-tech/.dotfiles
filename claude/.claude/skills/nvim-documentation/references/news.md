# Neovim News (HEAD)

Notable changes since Nvim 0.11.

## Breaking Changes (Dev)

### Events
- Renamed `"nvim.find_exrc"` default-autocmds group to `"nvim.exrc"`.

### LSP
- `vim.lsp.buf.selection_range()` now accepts an integer for direction, not a string.

### Options
- `'completefuzzycollect'` and `'isexpand'` removed.

### UI
- `progress` attribute removed from `ui-messages` `msg_show` event.

### Vimscript
- `complete_match()` removed.

## Breaking Changes

### API
- Decoration provider has `on_range()` callback.
- `nvim_get_commands()` returns `complete` as a Lua function if defined as such.

### Diagnostics
- Diagnostic signs can no longer be configured with `:sign-define` or `sign_define()`.
- `vim.diagnostic.disable()` and `vim.diagnostic.is_disabled()` removed.
- Legacy signature of `vim.diagnostic.enable()` no longer supported.

### Editor
- `i_CTRL-R` inserts named/clipboard registers literally (like pasting, not user input).
- Buffer name URI scheme parsing more closely follows RFC3986.

### Events
- `ui-messages` no longer emits `msg_show.return_prompt` and `msg_history_clear`.
- `msg_clear` repurposed: now emitted after screen is cleared.
- `msg_history_show` has additional `"prev_cmd"` argument.

### LSP
- JSON `null` in LSP messages represented as `vim.NIL` instead of `nil`.
- `vim.lsp.log.set_format_func()` function now receives all arguments as a single entry.
- Renamed `vim.lsp.semantic_tokens` `start()/stop()` to `enable()`.
- `vim.lsp.util.convert_signature_help_to_markdown_lines()` activeParameter handling updated.

### Lua
- Renamed `vim.diff` to `vim.text.diff`.

### Options
- `'shelltemp'` defaults to `false`.

### Treesitter
- `treesitter-directive-offset!` can now be applied to quantified captures. Sets `metadata[capture_id].offset` instead of `.range`.

## New Features

### API
- `api-contract` allows existing functions to change return-type from `void => non-void`.
- `nvim_win_text_height()` can limit lines checked with `max_height`, returns `end_row`/`end_vcol`.
- `vim.secure.read()` returns `true` for trusted directories.
- `vim.lsp.is_enabled()` checks if a given LSP config has been enabled.
- `nvim_ui_send()` writes arbitrary data to UI stdout (escape sequences for TUI).
- `nvim_echo()` can set `ui-messages` kind and create Progress messages.
- `nvim_get_commands()` returns `preview` and `callback` as Lua functions.
- `nvim_open_win()` floating windows can show a `'statusline'`.
- Experimental `nvim__exec_lua_fast()` for remote API clients.

### Defaults
- `'diffopt'` default includes `"indent-heuristic"` and `"inline:char"`.
- `'statusline'` default exposed as a statusline expression, includes `vim.diagnostic.status()`.
- `'exrc'` also loaded from parent directories.
- `grt` maps to `vim.lsp.buf.type_definition()`.
- `'shada'` default excludes `/tmp/` and `/private/` paths.

### Diagnostics
- `vim.diagnostic.setloclist()` and `vim.diagnostic.setqflist()` support `format` function.
- `vim.diagnostic.get()` accepts `enabled` filter.
- `vim.diagnostic.status()` returns formatted string with buffer diagnostics.

### Editor
- `:iput` works like `:put` but adjusts indent.
- `:retab` accepts `-indentonly` parameter.
- `:uniq` deduplicates text.
- `'wildchar'` enables completion in search contexts (`/`, `?`, `:g`, `:v`, `:vimgrep`).
- `:Undotree` for visually navigating the undo tree.
- `:wall` permits `++p` for creating parent directories.
- `:DiffTool` command compares directories and files.

### Events
- `CmdlineLeavePre` triggered before preparing to leave command line.
- `MarkSet` triggered after a mark is set by user.
- `TabClosedPre` triggered before closing a tabpage.

### Highlights
- `hl-DiffTextAdd` highlights added text within changed line.
- `hl-OkMsg`, `hl-StderrMsg`, `hl-StdoutMsg`
- `hl-SnippetTabstopActive` highlights active tabstop.
- `hl-PmenuBorder`, `hl-PmenuShadow`, `hl-PmenuShadowThrough` (see `'pumborder'`).

### LSP
- `:lsp` command for interactive LSP client management.
- `vim.lsp.ClientConfig` gained `workspace_required`.
- Support for `textDocument/documentColor`, `textDocument/colorPresentation`.
- `vim.lsp.enable()` starts/stops clients as necessary, detaches non-applicable clients.
- Support for `workspace/diagnostic`: `vim.lsp.buf.workspace_diagnostics()`.
- Incremental selection via `textDocument/selectionRange` (`an` outwards, `in` inwards).
- Support for multiline semantic tokens, disabled code actions, annotated text edits.
- `textDocument/linkedEditingRange`, `textDocument/inlineCompletion`, `textDocument/onTypeFormatting`.
- `vim.lsp.ClientConfig` `exit_timeout` field.
- `vim.lsp.buf.rename()` highlights symbol using `hl-LspReferenceTarget`.

### Lua
- `vim.net.request()` for HTTP GET requests.
- `vim.wait()` returns callback results.
- Lua type annotations for `vim.uv`.
- `vim.hl.range()` allows multiple timed highlights.
- `vim.tbl_extend()` and `vim.tbl_deep_extend()` accept a function behavior argument.
- `vim.fs.root()` can define "equal priority" via nested lists.
- `vim.version.intersect()` computes intersection of two version ranges.
- `Iter:take()` and `Iter:skip()` accept predicates.
- Built-in plugin manager `vim.pack`.
- `vim.list.unique()`, `vim.list.bisect()`.
- Experimental `vim.pos` and `vim.range` for Position/Range abstraction.
- `vim.json.encode()` has `indent` and `sort_keys` options.

### Options
- `'autocomplete'` enables auto-completion.
- `'autowriteall'` writes all buffers upon SIGHUP/SIGQUIT/SIGTSTP.
- `'chistory'` and `'lhistory'` set quickfix stack size.
- `'complete'` new flags: `"F{func}"`, `"F"`, `"o"`, limit matches with `"{flag}^<limit>"`.
- `'completeopt'` flag `"nearest"` sorts by distance to cursor.
- `'diffopt'` `inline:` configures inline diff highlighting.
- `'fillchars'` has `"foldinner"` flag.
- `'pummaxwidth'` sets max width for completion popup.
- `'winborder'` `"bold"` style, custom border style.
- `'busy'` sets buffer busy status; `'pumborder'` adds popup menu border.

### Performance
- `vim.glob.to_lpeg()` ~50% speedup with new LPeg implementation.
- `i_CTRL-R` 10x speedup for literal register insertion.
- LSP `textDocument/semanticTokens/range` requests tokens for viewport only.

### Terminal
- `nvim_open_term()` can be called with non-empty buffer (contents piped to PTY).

### Treesitter
- `Query:iter_captures()` supports start/end columns.
- `:EditQuery` gained tab-completion, works with injected languages.
- `LanguageTree:parse()` accepts a list of ranges.

### UI
- `:restart` restarts Nvim and reattaches current UI.
- `:connect` dynamically connects current UI to server address.
- `ui-multigrid` provides composition information and absolute coordinates.
- `vim._extui` experimental commandline and message UI.

### Vimscript
- `chdir()` allows optionally specifying scope.
- `cmdcomplete_info()`, `getcompletiontype()`, `prompt_getinput()`, `wildtrigger()`.
- `v:vim_did_init` set after sourcing init.vim but before load-plugins.

## Changed Features

- `'pumblend'` no longer applies special attributes from background to foreground layer.
- `gv` works in operator pending mode.
- `'smartcase'` applies to completion filtering.
- `'spellfile'` defaults to `stdpath("data").."/site/spell/"`.
- `'scrollback'` max increased from 100000 to 1000000.
- `matchfuzzy()`/`matchfuzzypos()` use improved algorithm (fzy).

## Deprecations

See `deprecated-0.12`.
