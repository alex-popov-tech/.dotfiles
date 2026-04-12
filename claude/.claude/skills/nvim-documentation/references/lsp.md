# LSP (Language Server Protocol)

Neovim LSP client/framework reference. Nvim acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.

## Table of Contents

- [Quickstart](#quickstart)
- [Defaults](#defaults)
- [Commands](#commands)
- [Config](#config)
  - [vim.lsp.Config](#vimlspconfig)
  - [Config Merging](#config-merging)
  - [On Attach](#on-attach)
- [Events](#events)
- [Lua module: vim.lsp (Core)](#lua-module-vimlsp-core)
- [Lua module: vim.lsp.buf](#lua-module-vimlspbuf)
- [Lua module: vim.lsp.client](#lua-module-vimlspclient)
  - [vim.lsp.Client Fields](#vimlspclient-fields)
  - [vim.lsp.ClientConfig Fields](#vimlspclientconfig-fields)
  - [Client Methods](#client-methods)
- [Lua module: vim.lsp.codelens](#lua-module-vimlspcodelens)
- [Lua module: vim.lsp.completion](#lua-module-vimlspcompletion)
- [Lua module: vim.lsp.diagnostic](#lua-module-vimlspdiagnostic)
- [Lua module: vim.lsp.document_color](#lua-module-vimlspdocument_color)
- [Lua module: vim.lsp.inlay_hint](#lua-module-vimlspinlay_hint)
- [Lua module: vim.lsp.inline_completion](#lua-module-vimlspinline_completion)
- [Lua module: vim.lsp.linked_editing_range](#lua-module-vimlsplinked_editing_range)
- [Lua module: vim.lsp.on_type_formatting](#lua-module-vimlspon_type_formatting)
- [Lua module: vim.lsp.log](#lua-module-vimlsplog)
- [Lua module: vim.lsp.rpc](#lua-module-vimlsprpc)
- [Lua module: vim.lsp.semantic_tokens](#lua-module-vimlspsemantic_tokens)
- [Lua module: vim.lsp.util](#lua-module-vimlsputil)
- [Lua module: vim.lsp.protocol](#lua-module-vimlspprotocol)
- [Handlers](#handlers)
- [Highlights](#highlights)

## Quickstart

1. Install a language server.
2. Define a config via `vim.lsp.config()` or `lsp/<config-name>.lua` on `runtimepath`.
3. Enable with `vim.lsp.enable('config_name')`.
4. Open a file matching `filetypes`.
5. Check with `:checkhealth vim.lsp`.

```lua
vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' }
    }
  }
}
vim.lsp.enable('lua_ls')
```

## Defaults

### Global Keymaps (created unconditionally at startup)

| Key | Mode | Action |
|-----|------|--------|
| `gra` | Normal, Visual | `vim.lsp.buf.code_action()` |
| `gri` | Normal | `vim.lsp.buf.implementation()` |
| `grn` | Normal | `vim.lsp.buf.rename()` |
| `grr` | Normal | `vim.lsp.buf.references()` |
| `grt` | Normal | `vim.lsp.buf.type_definition()` |
| `gO` | Normal | `vim.lsp.buf.document_symbol()` |
| `<C-s>` | Insert | `vim.lsp.buf.signature_help()` |
| `an`/`in` | Visual, Operator-pending | `vim.lsp.buf.selection_range()` |

### Buffer-Local Defaults (set when LSP attaches)

- `omnifunc` = `vim.lsp.omnifunc()` (trigger with `<C-x><C-o>`)
- `tagfunc` = `vim.lsp.tagfunc()` (enables `<C-]>`, `:tjump`, etc.)
- `formatexpr` = `vim.lsp.formatexpr()` (format via `gq`)
- `K` mapped to `vim.lsp.buf.hover()` (unless `keywordprg` customized)
- Document colors enabled for highlighting color references

### Disabling Defaults

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil
    vim.keymap.del('n', 'K', { buffer = args.buf })
    vim.lsp.document_color.enable(false, args.buf)
  end,
})
```

## Commands

| Command | Description |
|---------|-------------|
| `:lsp enable [name]` | Activate LSP for current/future buffers |
| `:lsp disable [name]` | Disable LSP (stops if running) |
| `:lsp restart [name]` | Restart LSP clients/servers |
| `:lsp stop [name]` | Stop LSP clients/servers |

## Config

### vim.lsp.Config

Extends `vim.lsp.ClientConfig`.

| Field | Type | Description |
|-------|------|-------------|
| `cmd` | `string[]` or `fun(dispatchers, config): PublicClient` | Command to start the server |
| `filetypes` | `string[]?` | Filetypes to attach to, nil for ALL |
| `reuse_client` | `fun(client, config): boolean` | Predicate to re-use a client (default: matches name and root_dir) |
| `root_dir` | `string` or `fun(bufnr, on_dir)` | Workspace root. Function form must call `on_dir` callback |
| `root_markers` | `(string\|string[])[]` | Filenames to detect workspace root. Nested lists = equal priority |

`root_markers` example:
```lua
-- Find stylua.toml first; if not found, find .git
root_markers = { 'stylua.toml', '.git' }
-- Find EITHER stylua.toml or .luarc.json (equal priority); fallback to .git
root_markers = { { 'stylua.toml', '.luarc.json' }, '.git' }
```

### Config Merging

Configs merge (via `vim.tbl_deep_extend("force", ...)`) in increasing priority:
1. `'*'` name config
2. Merged `lsp/<config>.lua` files on `runtimepath`
3. Merged `after/lsp/<config>.lua` files on `runtimepath`
4. Configs defined anywhere else

### On Attach

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
```

Inspect server capabilities:
```vim
:lua =vim.lsp.get_clients()[1].server_capabilities
```

## Events

### LspAttach

After LSP client initializes and attaches to a buffer. `args.data.client_id` holds the client ID.

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
  end
})
```

### LspDetach

Before LSP client detaches. `args.data.client_id` holds the client ID.

### LspNotify

After each successful notification sent to an LSP server. Data: `client_id`, `method`, `params`.

### LspProgress

On progress notification from server. Pattern is `kind` (`begin`, `report`, `end`).

```vim
autocmd LspProgress * redrawstatus
```

### LspRequest

For each request status change (`pending`, `complete`, `cancel`). Data: `client_id`, `request_id`, `request`.

### LspTokenUpdate

When a visible semantic token is sent/updated. Data: `client_id`, `token`.

```lua
vim.api.nvim_create_autocmd('LspTokenUpdate', {
  callback = function(args)
    local token = args.data.token
    if token.type == 'variable' and not token.modifiers.readonly then
      vim.lsp.semantic_tokens.highlight_token(
        token, args.buf, args.data.client_id, 'MyMutableVariableHighlight'
      )
    end
  end,
})
```

## Lua module: vim.lsp (Core)

### `vim.lsp.config(name, cfg)`

Sets default config for an LSP client (or all clients with `'*'`). Can also be accessed by table-indexing: `vim.lsp.config['lua_ls']`. Since 0.11.0.

```lua
vim.lsp.config('*', { root_markers = { '.git' } })
vim.lsp.config('clangd', { root_markers = { '.clangd', 'compile_commands.json' } })
-- Redefine (override resolved chain):
vim.lsp.config.clangd = { cmd = { 'clangd' }, filetypes = { 'c', 'cpp' } }
-- Read resolved config:
local cfg = vim.lsp.config.lua_ls
```

- `name` (`string`)
- `cfg` (`vim.lsp.Config`)

### `vim.lsp.enable(name, enable)`

Auto-activates LSP based on config `filetypes`, `root_markers`, `root_dir`. Since 0.11.0.

- `name` (`string|string[]`) -- Config name(s)
- `enable` (`boolean?`) -- `true`/nil to enable, `false` to disable (stops related clients/servers)

```lua
vim.lsp.enable('clangd')
vim.lsp.enable({'lua_ls', 'pyright'})
```

Dynamic activation via `root_dir` function:

```lua
vim.lsp.config('lua_ls', {
  root_dir = function(bufnr, on_dir)
    if not vim.fn.bufname(bufnr):match('%.txt$') then
      on_dir(vim.fn.getcwd())
    end
  end
})
```

### `vim.lsp.is_enabled(name)`

- `name` (`string`) -- Returns `boolean`

### `vim.lsp.start(config, opts)`

Create/reuse an LSP client and attach to current buffer. Since 0.8.0.

- `config` (`vim.lsp.ClientConfig`)
- `opts` (`table?`)
  - `reuse_client` (`fun(client, config): boolean`)
  - `bufnr` (`integer?`)
  - `attach` (`boolean?`, default: true)
  - `silent` (`boolean?`, default: false)
- Returns: `integer?` client_id

```lua
vim.lsp.start({
  name = 'my-server-name',
  cmd = {'name-of-language-server-executable'},
  root_dir = vim.fs.root(0, {'pyproject.toml', 'setup.py'}),
})
```

### `vim.lsp.get_client_by_id(client_id)`

- `client_id` (`integer`) -- Returns `vim.lsp.Client?`

### `vim.lsp.get_clients(filter)`

Get active clients. Since 0.10.0.

- `filter` (`table?`): `{id?, bufnr?, name?, method?}`
- Returns: `vim.lsp.Client[]`

### `vim.lsp.status()`

Consumes latest progress messages from all clients, returns formatted `string`.

### `vim.lsp.buf_attach_client(bufnr, client_id)`

Implements `textDocument/did...` notifications for tracking a buffer. Returns `boolean`.

### `vim.lsp.buf_detach_client(bufnr, client_id)`

Detaches client from buffer.

### `vim.lsp.buf_is_attached(bufnr, client_id)`

Returns `boolean`.

### `vim.lsp.buf_notify(bufnr, method, params)`

Send notification to server. Returns `boolean`.

### `vim.lsp.buf_request_all(bufnr, method, params, handler)`

Async request to all attached clients. Returns cancel function.

- `params` (`table|(fun(client, bufnr): table?)?`)
- `handler` receives `client_id:result` map

### `vim.lsp.buf_request_sync(bufnr, method, params, timeout_ms)`

Blocking version of `buf_request_all`. Default timeout 1000ms.

- Returns: `table<integer, {error, result}>?`, `string?` err

### `vim.lsp.omnifunc(findstart, base)`

Implements `omnifunc` compatible LSP completion.

### `vim.lsp.tagfunc(pattern, flags)`

Interface between client and `tagfunc`. Uses `textDocument/definition` for normal mode, `workspace/symbol` otherwise.

### `vim.lsp.formatexpr(opts)`

Interface for `formatexpr`. `opts.timeout_ms` defaults to 500.

### `vim.lsp.foldexpr(lnum)`

Interface for `foldexpr`.

```lua
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
```

### `vim.lsp.foldtext()`

Provides `foldtext` showing `collapsedText`.

### `vim.lsp.foldclose(kind, winid)`

Close all folds of `kind` (`"comment"`, `"imports"`, `"region"`). Since 0.11.0.

```lua
vim.api.nvim_create_autocmd('LspNotify', {
  callback = function(args)
    if args.data.method == 'textDocument/didOpen' then
      vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf))
    end
  end,
})
```

### `vim.lsp.commands`

Table of client-defined command handlers. Each key is a command name; value is `function(command, ctx)`.

## Lua module: vim.lsp.buf

### Types

**`vim.lsp.ListOpts`**

| Field | Type |
|-------|------|
| `on_list` | `fun(t: vim.lsp.LocationOpts.OnList)?` |
| `loclist` | `boolean?` |

**`vim.lsp.LocationOpts`** (extends `ListOpts`)

| Field | Type |
|-------|------|
| `reuse_win` | `boolean?` |

**`vim.lsp.LocationOpts.OnList`**

| Field | Type |
|-------|------|
| `items` | `vim.quickfix.entry[]` |
| `title` | `string?` |
| `context` | `{ bufnr: integer, method: string }?` |

**`vim.lsp.buf.hover.Opts`** (extends `vim.lsp.util.open_floating_preview.Opts`)

| Field | Type |
|-------|------|
| `silent` | `boolean?` |

**`vim.lsp.buf.signature_help.Opts`** (extends `vim.lsp.util.open_floating_preview.Opts`)

| Field | Type |
|-------|------|
| `silent` | `boolean?` |

### `vim.lsp.buf.code_action(opts)`

Selects a code action at cursor. `opts`:
- `context?` (`lsp.CodeActionContext`): `{diagnostics?, only?, triggerKind?}`
- `filter?` (`fun(x, client_id): boolean`)
- `apply?` (`boolean`) -- auto-apply if single action remains
- `range?` (`{start: integer[], end: integer[]}`)

### `vim.lsp.buf.declaration(opts)`

Jump to declaration. `opts`: `vim.lsp.LocationOpts?`

### `vim.lsp.buf.definition(opts)`

Jump to definition. `opts`: `vim.lsp.LocationOpts?`

### `vim.lsp.buf.type_definition(opts)`

Jump to type definition. `opts`: `vim.lsp.LocationOpts?`

### `vim.lsp.buf.implementation(opts)`

List implementations in quickfix. `opts`: `vim.lsp.LocationOpts?`

### `vim.lsp.buf.references(context, opts)`

List references in quickfix.

- `context` (`lsp.ReferenceContext?`)
- `opts` (`vim.lsp.ListOpts?`)

### `vim.lsp.buf.hover(config)`

Show hover info in floating window. `config`: `vim.lsp.buf.hover.Opts?`. "KK" opens and focuses.

### `vim.lsp.buf.signature_help(config)`

Show signature info in floating window. Cycle overloads with `<C-s>`. `config`: `vim.lsp.buf.signature_help.Opts?`

### `vim.lsp.buf.rename(new_name, opts)`

Rename symbol. Prompts if `new_name` is nil.

- `opts`: `{filter?, name?, bufnr?}`

### `vim.lsp.buf.format(opts)`

Format buffer.

- `formatting_options` (`lsp.FormattingOptions?`)
- `timeout_ms` (`integer?`, default: 1000)
- `bufnr` (`integer?`)
- `filter` (`fun(client): boolean?`)
- `async` (`boolean?`, default: false)
- `id` (`integer?`) -- client ID filter
- `name` (`string?`) -- client name filter
- `range` (`{start, end}` or list of `{start, end}`)

### `vim.lsp.buf.document_highlight()`

Resolve document highlights at current position.

### `vim.lsp.buf.clear_references()`

Remove document highlights from current buffer.

### `vim.lsp.buf.document_symbol(opts)`

List buffer symbols in location list. `opts`: `vim.lsp.ListOpts?`

### `vim.lsp.buf.workspace_symbol(query, opts)`

List workspace symbols in quickfix. `query`: `string?`, `opts`: `vim.lsp.ListOpts?`

### `vim.lsp.buf.incoming_calls()`

List call sites of symbol under cursor in quickfix.

### `vim.lsp.buf.outgoing_calls()`

List items called by symbol under cursor in quickfix.

### `vim.lsp.buf.selection_range(direction, timeout_ms)`

Incremental selection based on LSP ranges. Negative `direction` shrinks. `timeout_ms` defaults to 1000.

### `vim.lsp.buf.typehierarchy(kind)`

List subtypes or supertypes. `kind`: `"subtypes"|"supertypes"`

### `vim.lsp.buf.workspace_diagnostics(opts)`

Request workspace-wide diagnostics. `opts`: `{client_id?}`

### `vim.lsp.buf.add_workspace_folder(workspace_folder)`

- `workspace_folder` (`string?`) -- prompts if nil

### `vim.lsp.buf.remove_workspace_folder(workspace_folder)`

- `workspace_folder` (`string?`) -- prompts if nil

### `vim.lsp.buf.list_workspace_folders()`

## Lua module: vim.lsp.client

### vim.lsp.Client Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | `integer` | Client id |
| `name` | `string` | Client name |
| `config` | `vim.lsp.ClientConfig` | Copy of config passed to `vim.lsp.start()` |
| `attached_buffers` | `table<integer, true>` | Attached buffer set |
| `capabilities` | `lsp.ClientCapabilities` | Client capabilities (at startup) |
| `server_capabilities` | `lsp.ServerCapabilities?` | Server capabilities from `initialize` |
| `server_info` | `lsp.ServerInfo?` | Server info from `initialize` |
| `dynamic_capabilities` | `lsp.DynamicCapabilities` | Capabilities provided at runtime |
| `settings` | `lsp.LSPObject` | Server-specific settings |
| `handlers` | `table<string, lsp.Handler>` | LSP method handlers |
| `commands` | `table<string, fun>` | Client commands |
| `root_dir` | `string?` | Workspace root |
| `workspace_folders` | `lsp.WorkspaceFolder[]?` | Workspace folders |
| `offset_encoding` | `'utf-8'\|'utf-16'\|'utf-32'` | Position encoding |
| `rpc` | `vim.lsp.rpc.PublicClient` | RPC client object |
| `progress` | `vim.lsp.Client.Progress` | Progress ring buffer |
| `requests` | `table<integer, {type, bufnr, method}?>` | Pending requests |
| `flags` | `table` | `{allow_incremental_sync?, debounce_text_changes?}` |
| `exit_timeout` | `integer\|boolean` | Ms to wait before force kill (default: false) |
| `initialized` | `true?` | Whether initialize completed |

### vim.lsp.ClientConfig Fields

| Field | Type | Description |
|-------|------|-------------|
| `cmd` | `string[]\|fun(dispatchers, config): PublicClient` | Server command or RPC factory |
| `cmd_cwd` | `string?` | Working directory for cmd (default: cwd) |
| `cmd_env` | `table?` | Environment variables for LSP process |
| `name` | `string?` | Name in logs (default: client-id) |
| `root_dir` | `string?` | Workspace root |
| `settings` | `lsp.LSPObject?` | Server-specific settings |
| `capabilities` | `lsp.ClientCapabilities?` | Override default capabilities |
| `handlers` | `table<string, function>?` | LSP method handlers |
| `commands` | `table<string, fun>?` | Client commands |
| `init_options` | `lsp.LSPObject?` | `initializationOptions` for initialize request |
| `offset_encoding` | `'utf-8'\|'utf-16'\|'utf-32'?` | Position encoding |
| `trace` | `'off'\|'messages'\|'verbose'?` | Trace level (default: "off") |
| `workspace_folders` | `lsp.WorkspaceFolder[]?` | Workspace folders |
| `workspace_required` | `boolean?` | Server requires workspace (default: false) |
| `flags` | `table?` | `{allow_incremental_sync?, debounce_text_changes?}` |
| `detached` | `boolean?` | Daemonize server (default: true) |
| `exit_timeout` | `integer\|boolean?` | Ms before force kill (default: false) |
| `get_language_id` | `fun(bufnr, filetype): string?` | Override language ID |
| `before_init` | `fun(params, config)?` | Callback before LSP initialize |
| `on_init` | `fun(client, init_result)?` | After LSP initialize |
| `on_attach` | `fun(client, bufnr)?` | On buffer attach |
| `on_error` | `fun(code, err)?` | On client error |
| `on_exit` | `fun(code, signal, client_id)?` | On client exit |

### Client Methods

#### `Client:request(method, params, handler, bufnr)`

Send request to server. Returns `boolean` (success), `integer?` (request_id).

#### `Client:request_sync(method, params, timeout_ms, bufnr)`

Blocking request. Returns `{err, result}?`, `string?` (err on timeout/cancel).

#### `Client:notify(method, params)`

Send notification. Returns `boolean`.

#### `Client:cancel_request(id)`

Cancel a pending request. Returns `boolean`.

#### `Client:stop(force)`

Stop client. `force`: ms before force kill, `true` = immediate, `false` = wait indefinitely.

#### `Client:is_stopped()`

Returns `boolean`.

#### `Client:exec_cmd(command, context, handler)`

Execute LSP command via client command function or `workspace/executeCommand`.

#### `Client:on_attach(bufnr)`

Runs the `on_attach` function from config.

#### `Client:supports_method(method, bufnr)`

Returns `boolean`. Always true for unknown off-spec methods.

## Lua module: vim.lsp.codelens

### `vim.lsp.codelens.refresh(opts)`

Refresh lenses. `opts`: `{bufnr?}`. Use via autocmd:

```vim
autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
```

### `vim.lsp.codelens.run()`

Run code lens in current line.

### `vim.lsp.codelens.display(lenses, bufnr, client_id)`

Display lenses using virtual text.

### `vim.lsp.codelens.get(bufnr)`

Return all lenses for buffer. Returns `lsp.CodeLens[]`.

### `vim.lsp.codelens.clear(client_id, bufnr)`

Clear lenses. Both params optional (nil = all).

### `vim.lsp.codelens.save(lenses, bufnr, client_id)`

Store lenses for buffer/client.

### `vim.lsp.codelens.on_codelens(err, result, ctx)`

Handler for `textDocument/codeLens`.

## Lua module: vim.lsp.completion

```lua
vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.lsp.completion.enable(true, client.id, bufnr, {
  autotrigger = true,
  convert = function(item)
    return { abbr = item.label:gsub('%b()', '') }
  end,
})
```

### `vim.lsp.completion.enable(enable, client_id, bufnr, opts)`

- `enable` (`boolean`)
- `client_id` (`integer`)
- `bufnr` (`integer`)
- `opts`:
  - `autotrigger` (`boolean?`, default: false)
  - `convert` (`fun(item: lsp.CompletionItem): table`)
  - `cmp` (`fun(a, b): boolean`) -- sort comparator

### `vim.lsp.completion.get(opts)`

Trigger completion once. `opts`: `{ctx?: lsp.CompletionContext}`.

Manual trigger keymap:

```lua
vim.keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)
```

## Lua module: vim.lsp.diagnostic

### `vim.lsp.diagnostic.from(diagnostics)`

Convert `vim.Diagnostic[]` to `lsp.Diagnostic[]`.

### `vim.lsp.diagnostic.get_namespace(client_id, is_pull)`

Get diagnostic namespace for LSP client. `is_pull` defaults to push.

### `vim.lsp.diagnostic.on_diagnostic(error, result, ctx)`

Handler for `textDocument/diagnostic`.

### `vim.lsp.diagnostic.on_publish_diagnostics(_, params, ctx)`

Handler for `textDocument/publishDiagnostics`.

## Lua module: vim.lsp.document_color

### `vim.lsp.document_color.enable(enable, bufnr, opts)`

- `enable` (`boolean?`, default: true)
- `bufnr` (`integer?`, default: 0)
- `opts.style` (`'background'|'foreground'|'virtual'|string|fun(bufnr, range, hex_code)`)

### `vim.lsp.document_color.is_enabled(bufnr)`

Returns `boolean`.

### `vim.lsp.document_color.color_presentation()`

Select from presentations for color under cursor.

## Lua module: vim.lsp.inlay_hint

### `vim.lsp.inlay_hint.enable(enable, filter)`

Since 0.10.0. Toggle: `vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())`

- `enable` (`boolean?`)
- `filter` (`{bufnr?}?`)

### `vim.lsp.inlay_hint.is_enabled(filter)`

- `filter` (`{bufnr?}?`) -- Returns `boolean`

### `vim.lsp.inlay_hint.get(filter)`

- `filter` (`{bufnr?, range?}?`)
- Returns: list of `{bufnr, client_id, inlay_hint}`

## Lua module: vim.lsp.inline_completion

### `vim.lsp.inline_completion.enable(enable, filter)`

- `enable` (`boolean?`)
- `filter` (`{bufnr?, client_id?}?`)

### `vim.lsp.inline_completion.get(opts)`

Accept displayed completion candidate. Returns `boolean`.

- `opts`: `{bufnr?, on_accept?}`

```lua
vim.keymap.set('i', '<Tab>', function()
  if not vim.lsp.inline_completion.get() then
    return '<Tab>'
  end
end, { expr = true })
```

### `vim.lsp.inline_completion.select(opts)`

Switch between candidates. `opts`: `{bufnr?, count?, wrap?}`

### `vim.lsp.inline_completion.is_enabled(filter)`

- `filter` (`{bufnr?, client_id?}?`) -- Returns `boolean`

**`vim.lsp.inline_completion.Item`**

| Field | Type |
|-------|------|
| `client_id` | `integer` |
| `insert_text` | `string\|lsp.StringValue` |
| `range` | `vim.Range?` |
| `command` | `lsp.Command?` |

### Copilot Quickstart

```lua
vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio' },
  root_markers = { '.git' },
})
vim.lsp.enable('copilot')
vim.lsp.inline_completion.enable()
```

## Lua module: vim.lsp.linked_editing_range

### `vim.lsp.linked_editing_range.enable(enable, filter)`

Enable linked editing (e.g., sync HTML tag pairs).

- `enable` (`boolean?`)
- `filter` (`{client_id?}?`)

```lua
vim.lsp.start({
  name = 'html',
  cmd = '...',
  on_attach = function(client)
    vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
  end,
})
```

## Lua module: vim.lsp.on_type_formatting

### `vim.lsp.on_type_formatting.enable(enable, filter)`

- `enable` (`boolean?`)
- `filter` (`{client_id?}?`)

```lua
vim.lsp.on_type_formatting.enable()
-- or per-client:
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.name == 'rust-analyzer' then
      vim.lsp.on_type_formatting.enable(true, { client_id = args.data.client_id })
    end
  end,
})
```

## Lua module: vim.lsp.log

Enable verbose logging for debugging:

```lua
vim.lsp.log.set_level('trace')
require('vim.lsp.log').set_format_func(vim.inspect)
```

Open the log:

```vim
:lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
```

### `vim.lsp.log.get_filename()`

Returns `string`.

### `vim.lsp.log.get_level()`

Returns `integer`.

### `vim.lsp.log.set_level(level)`

- `level` (`string|integer`) -- One of `vim.log.levels`

### `vim.lsp.log.set_format_func(handle)`

- `handle` (`fun(level, ...): string?`)

## Lua module: vim.lsp.rpc

**`vim.lsp.rpc.PublicClient`**

| Field | Type |
|-------|------|
| `request` | `fun(method, params, callback, notify_reply_callback): boolean, integer?` |
| `notify` | `fun(method, params): boolean` |
| `is_closing` | `fun(): boolean` |
| `terminate` | `fun()` |

### `vim.lsp.rpc.start(cmd, dispatchers, extra_spawn_params)`

Start LSP server process via stdio. Returns `vim.lsp.rpc.PublicClient`.

- `cmd` (`string[]`)
- `dispatchers` (`{notification, server_request, on_exit, on_error}?`)
- `extra_spawn_params` (`{cwd?, detached?, env?}?`)

### `vim.lsp.rpc.connect(host_or_path, port)`

Create RPC client factory for pipe/socket/TCP. Returns function for `cmd` field.

- `host_or_path` (`string`)
- `port` (`integer?`) -- omit for pipe/socket

### `vim.lsp.rpc.request(method, params, callback, notify_reply_callback)`

Send request. Returns `boolean`, `integer?` (message_id).

### `vim.lsp.rpc.notify(method, params)`

Send notification. Returns `boolean`.

### `vim.lsp.rpc.format_rpc_error(err)`

Format error object to string.

### `vim.lsp.rpc.rpc_response_error(code, message, data)`

Create RPC error response. `code` from `vim.lsp.protocol.ErrorCodes`.

## Lua module: vim.lsp.semantic_tokens

### `vim.lsp.semantic_tokens.enable(enable, filter)`

- `enable` (`boolean?`)
- `filter` (`{bufnr?, client_id?}?`)

### `vim.lsp.semantic_tokens.is_enabled(filter)`

- `filter` (`{bufnr?, client_id?}?`) -- Returns `boolean`

### `vim.lsp.semantic_tokens.force_refresh(bufnr)`

Force refresh. `bufnr`: nil for all, 0 for current.

### `vim.lsp.semantic_tokens.get_at_pos(bufnr, row, col)`

Returns list of tokens at position. Each token: `{line, start_col, end_line, end_col, type, modifiers, client_id}`.

### `vim.lsp.semantic_tokens.highlight_token(token, bufnr, client_id, hl_group, opts)`

Apply extmark highlight for a semantic token. For use in `LspTokenUpdate` callbacks.

- `opts`: `{priority?}` (default: `vim.hl.priorities.semantic_tokens + 3`)

## Lua module: vim.lsp.util

### `vim.lsp.util.open_floating_preview.Opts`

| Field | Type | Default |
|-------|------|---------|
| `height` | `integer?` | |
| `width` | `integer?` | |
| `wrap` | `boolean?` | `true` |
| `wrap_at` | `integer?` | |
| `max_width` | `integer?` | |
| `max_height` | `integer?` | |
| `focus_id` | `string?` | |
| `close_events` | `table?` | |
| `focusable` | `boolean?` | `true` |
| `focus` | `boolean?` | `true` |
| `offset_x` | `integer?` | |
| `offset_y` | `integer?` | |
| `border` | `string\|(string\|[string,string])[]?` | |
| `zindex` | `integer?` | 50 |
| `title` | `string\|[string,string][]?` | |
| `title_pos` | `'left'\|'center'\|'right'?` | |
| `relative` | `'mouse'\|'cursor'\|'editor'?` | `'cursor'` |
| `anchor_bias` | `'auto'\|'above'\|'below'?` | `'auto'` |

### `vim.lsp.util.open_floating_preview(contents, syntax, opts)`

Show contents in floating window. Returns `bufnr`, `winid`.

### `vim.lsp.util.preview_location(location, opts)`

Preview location in floating window. Returns `bufnr?`, `winid?`.

### `vim.lsp.util.show_document(location, position_encoding, opts)`

Show document, optionally jump. `opts`: `{reuse_win?, focus?}`. Returns `boolean`.

### `vim.lsp.util.apply_text_edits(text_edits, bufnr, position_encoding, change_annotations)`

Apply list of text edits to buffer.

### `vim.lsp.util.apply_text_document_edit(text_document_edit, index, position_encoding, change_annotations)`

Apply `TextDocumentEdit`.

### `vim.lsp.util.apply_workspace_edit(workspace_edit, position_encoding)`

Apply `WorkspaceEdit`.

### `vim.lsp.util.buf_clear_references(bufnr)`

Remove document highlights from buffer.

### `vim.lsp.util.buf_highlight_references(bufnr, references, position_encoding)`

Show document highlights.

### `vim.lsp.util.character_offset(buf, row, col, offset_encoding)`

Returns UTF offset for position.

### `vim.lsp.util.convert_input_to_markdown_lines(input, contents)`

Convert `MarkedString|MarkupContent` to markdown lines.

### `vim.lsp.util.convert_signature_help_to_markdown_lines(signature_help, ft, triggers)`

Returns `string[]?` lines, `Range4?` active parameter highlight.

### `vim.lsp.util.locations_to_items(locations, position_encoding)`

Convert locations to quickfix items. Returns `vim.quickfix.entry[]`.

### `vim.lsp.util.symbols_to_items(symbols, bufnr, position_encoding)`

Convert symbols to quickfix items. Returns `vim.quickfix.entry[]`.

### `vim.lsp.util.rename(old_fname, new_fname, opts)`

Rename file. `opts`: `{overwrite?, ignoreIfExists?}`.

### `vim.lsp.util.make_position_params(window, position_encoding)`

Create `TextDocumentPositionParams`. Returns `lsp.TextDocumentPositionParams`.

### `vim.lsp.util.make_range_params(window, position_encoding)`

Create range params for code action / formatting. Returns `{ textDocument, range }`.

### `vim.lsp.util.make_given_range_params(start_pos, end_pos, bufnr, position_encoding)`

Create range params from explicit positions. Returns `{ textDocument, range }`.

### `vim.lsp.util.make_text_document_params(bufnr)`

Create `TextDocumentIdentifier`. Returns `lsp.TextDocumentIdentifier`.

### `vim.lsp.util.make_formatting_params(options)`

Create `DocumentFormattingParams`. Returns `lsp.DocumentFormattingParams`.

### `vim.lsp.util.make_workspace_params(added, removed)`

Returns `lsp.DidChangeWorkspaceFoldersParams`.

### `vim.lsp.util.make_floating_popup_options(width, height, opts)`

Returns `vim.api.keyset.win_config`.

### `vim.lsp.util.get_effective_tabstop(bufnr)`

Returns `integer` indentation size.

## Lua module: vim.lsp.protocol

### `vim.lsp.protocol.make_client_capabilities()`

Returns new `lsp.ClientCapabilities` object.

### `vim.lsp.protocol.resolve_capabilities(server_capabilities)`

Normalize server capabilities table. Returns `lsp.ServerCapabilities?`.

Protocol constants support reverse lookup:

```lua
vim.lsp.protocol.TextDocumentSyncKind.Full == 1
vim.lsp.protocol.TextDocumentSyncKind[1] == "Full"
```

## Handlers

Handler signature: `function(err, result, ctx)` where:
- `err` (`table|nil`) -- error info
- `result` (`Result|Params|nil`)
- `ctx` (`table`): `{method, client_id, bufnr, params, version}`

Returns: `result, err` where err is `{ code, message, data? }`

Handler resolution (increasing priority):
1. `Client:request()` -- direct call
2. `vim.lsp.handlers` table -- global defaults (server-to-client only)
3. `handlers` param in `vim.lsp.start()` -- per-server (server-to-client only)
4. `handler` param in `vim.lsp.buf_request_all()` -- per-request

```lua
vim.lsp.handlers['textDocument/publishDiagnostics'] = my_custom_handler
```

## Highlights

### Reference Highlights

| Group | Usage |
|-------|-------|
| `LspReferenceText` | "text" references |
| `LspReferenceRead` | "read" references |
| `LspReferenceWrite` | "write" references |
| `LspReferenceTarget` | reference targets (e.g. hover range) |
| `LspInlayHint` | inlay hints |
| `LspCodeLens` | codelens virtual text |
| `LspCodeLensSeparator` | separator between code lenses |
| `LspSignatureActiveParameter` | active parameter in signature help |

### Semantic Token Highlights

Derived from token type and modifiers:
- `@lsp.type.<type>.<ft>` -- for the type
- `@lsp.mod.<mod>.<ft>` -- for each modifier
- `@lsp.typemod.<type>.<mod>.<ft>` -- for each type+modifier combo

Disable semantic highlights:

```lua
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
```
