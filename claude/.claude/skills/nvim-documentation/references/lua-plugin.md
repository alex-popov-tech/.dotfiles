# Lua Plugin Development

Guide to developing Lua plugins for Nvim.

See `lua-guide` for guidance on using Lua to configure and operate Nvim.
See `luaref` and `lua-concepts` for details on the Lua programming language.

## Creating Your First Plugin

Any Vimscript or Lua code file in the right directory is automatically a "plugin" -- no manifest or registration needed.

1. Visit config directory: `:exe 'edit' stdpath('config')`
2. Create `plugin/foo.lua`
3. Add code, e.g.: `vim.print('Hello World')`
4. Start `nvim` -- prints "Hello World" in messages area.

Besides `plugin/foo.lua` (always run at startup), define Lua modules in `lua/` directory. Those aren't loaded until `require(...)` is called.

## Type Safety

Leverage LuaCATS/"emmylua" annotations with lua-language-server (LuaLS) to catch bugs in CI.

**Tools:**
- [lua-typecheck-action](https://github.com/marketplace/actions/lua-typecheck-action)
- [lua-language-server](https://luals.github.io)

## Keymaps

Avoid creating excessive keymaps automatically -- they can conflict with user mappings. Buffer-local mappings for specific filetypes/floating windows and `<Plug>` mappings are fine.

### Approaches

**`<Plug>` mappings** (recommended for simple actions):
- One line of code in user configs
- Won't throw error if plugin not installed
- Can enforce `expr = true`, handle modes, detect user mappings via `hasmapto()`

**Lua functions** (recommended for complex/configurable actions):
- Extensible via options table
- Cleaner UX for many options

### Example

In plugin:
```lua
vim.keymap.set('n', '<Plug>(SayHello)', function()
    print('Hello from normal mode')
end)

vim.keymap.set('v', '<Plug>(SayHello)', function()
    print('Hello from visual mode')
end)
```

In user config:
```lua
vim.keymap.set({'n', 'v'}, '<leader>h', '<Plug>(SayHello)')
```

## Initialization

Separate configuration from initialization:

- **Config function** (e.g. `setup(opts)`) -- only overrides defaults, no init logic.
- **Vimscript-compatible table** (e.g. `vim.g` or `vim.b` namespace) -- plugin reads/validates at init time.

Automatic init logic goes in `plugin/` or `ftplugin/` scripts.

Combined `setup(opts)` useful when:
- Complex initialization with significant misconfiguration risk
- Users must opt-in to functionality

## Lazy Loading

Nvim has built-in lazy-loading via `lua/` (for Lua) and `autoload/` (for Vimscript).

**Guidance:**
- Keep `plugin/<name>.lua` small; avoid eager `require()` calls
- Commands and mappings should do the `require()`

### Defer require() Calls

Instead of:
```lua
local foo = require('foo')
vim.api.nvim_create_user_command('MyCommand', function()
    foo.do_something()
end, {})
```

Do:
```lua
vim.api.nvim_create_user_command('MyCommand', function()
    local foo = require('foo')
    foo.do_something()
end, {})
```

### Filetype-specific Functionality

Use `ftplugin/{filetype}.lua` for filetype-specific initialization. Set custom `'filetype'` "as late as possible" so users can override buffer-local settings.

```lua
if not vim.g.loaded_my_rust_plugin then
    -- Initialize
end
vim.g.loaded_my_rust_plugin = true

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<Plug>(MyPluginBufferAction)', function()
    print('Hello')
end, { buffer = bufnr })
```

## Configuration

To allow users to override buffer-local config for filetypes owned by your plugin, publish a `FileType` event "as late as possible".

Validate configs:
- Correct types (`vim.validate()`)
- Unknown fields (may be better as a health check)

## UI

For plugins with custom buffer UI, consider providing actions via an in-process LSP server. Code actions are accessible via `gra` mapping:

```lua
vim.lsp.buf.code_action({
    apply = true,
    filter = function(a)
        return a.title == 'Do something'
    end,
})
```

## Troubleshooting

Use `:restart` to see code changes during development.

### Health

Create `lua/{plugin}/health.lua` with a `check()` function. `:checkhealth` finds it automatically.

Validate: user configuration, proper initialization, Lua dependencies, external dependencies.

## Versioning and Releases

- Use `vim.deprecate()` or `---@deprecate` annotation for breaking changes
- Use SemVer tags and releases
- Automate versioning/releases in CI
- Publish to luarocks (especially for dependencies/build components)

**Tools:**
- [luarocks-tag-release](https://github.com/marketplace/actions/luarocks-tag-release)
- [release-please-action](https://github.com/marketplace/actions/release-please-action)
- [semantic-release](https://github.com/semantic-release/semantic-release)

## Documentation

Provide vimdoc so users can read docs in Nvim via `:h {plugin}`. Regenerate help-tags with `:helptags`.

**Tools:**
- [panvimdoc](https://github.com/kdheepak/panvimdoc)
