# Health (checkhealth)

`vim.health` is a minimal framework to help users troubleshoot configuration and environment conditions that a plugin might care about.

## Commands

- `:checkhealth` - Run all healthchecks.
- `:checkhealth {plugins}` - Run healthcheck(s) for one or more plugins.

```vim
:checkhealth vim.health
:checkhealth foo bar
:checkhealth vim.lsp vim.treesitter
:checkhealth vim*
```

## Usage

Local mappings in the healthcheck buffer:

- `q` - Closes the window.

### Global Configuration

`g:health` - Dictionary with optional keys:
- `style` (`'float'|nil`) - Set to `"float"` to display `:checkhealth` in a floating window.

```lua
vim.g.health = { style = 'float' }
```

### Local Configuration

Checkhealth sets its buffer filetype to `"checkhealth"`. Customize via `FileType` event:

```vim
autocmd FileType checkhealth :set modifiable | silent! %s/\v( ?[^\x00-\x7F])//g
```

## Create a Healthcheck

To add a healthcheck for your plugin, create a `health.lua` module on `'runtimepath'` that returns a table with a `check()` function. `:checkhealth` will automatically find and invoke it.

For a plugin named `"foo"`, define at one of:
- `lua/foo/health/init.lua`
- `lua/foo/health.lua`

For a submodule `"bar"`:
- `lua/foo/bar/health/init.lua`
- `lua/foo/bar/health.lua`

### Example

```lua
local M = {}

M.check = function()
  vim.health.start("foo report")
  if check_setup() then
    vim.health.ok("Setup is correct")
  else
    vim.health.error("Setup is incorrect")
  end
end

return M
```

## API

### `vim.health.error({msg}, {...})`
Reports an error.
- `{msg}` (`string`)
- `{...}` (`string|string[]`) Optional advice

### `vim.health.info({msg})`
Reports an informational message.
- `{msg}` (`string`)

### `vim.health.ok({msg})`
Reports a "success" message.
- `{msg}` (`string`)

### `vim.health.start({name})`
Starts a new report. Most plugins should call this only once, but if you want different sections, call this once per section.
- `{name}` (`string`)

### `vim.health.warn({msg}, {...})`
Reports a warning.
- `{msg}` (`string`)
- `{...}` (`string|string[]`) Optional advice
