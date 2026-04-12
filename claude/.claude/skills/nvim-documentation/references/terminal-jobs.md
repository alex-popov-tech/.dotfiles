# Terminal, Jobs & Channels

## Terminal Emulator

Nvim embeds a VT220/xterm terminal emulator based on libvterm, presented as a special `'buftype'`, asynchronously updated as data is received.

### Terminal Buffers

Terminal buffers behave like normal buffers, except:
- With `'modifiable'`, lines can be edited but not deleted
- `'scrollback'` controls how many lines are kept
- Output is followed ("tailed") if cursor is on the last line
- `'modified'` is the default; set `'nomodified'` to avoid warning on close
- `'bufhidden'` defaults to `"hide"`

### Starting a Terminal

```vim
:terminal                        " Run :terminal command
:edit term://bash                " Edit a term:// buffer
:vsplit term://top               " Vsplit with terminal
```

```lua
-- Via API
vim.fn.jobstart('bash', {term = true})
-- Or nvim_open_term() for custom terminal
```

Buffer is named `term://{cwd}//{pid}:{cmd}`.

### Terminal Input

Enter Terminal-mode with `i`, `I`, `a`, `A`, or `:startinsert`. All keys except `<C-\>` are sent to the program.

- `<C-\><C-N>` - return to Normal mode
- `<C-\><C-O>` - execute one Normal mode command, then return to Terminal-mode

Terminal-mode has its own `:tnoremap` namespace:

```vim
:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
```

### Configuration

Options: `'modified'`, `'scrollback'`
Events: `TermOpen`, `TermEnter`, `TermLeave`, `TermClose`
Highlight groups: `hl-TermCursor`

Terminal sets local defaults: `'list'` off, `'wrap'` off, `'number'` off, `'relativenumber'` off, `'signcolumn'` `"no"`, `'foldcolumn'` `"0"`.

```vim
au TermOpen * setlocal list
```

#### Terminal Colors

`{g,b}:terminal_color_x` (0-15) controls the terminal color palette, read during `TermOpen`:

```vim
let g:terminal_color_4 = '#ff0000'
let g:terminal_color_5 = 'green'
```

### Terminal Events

#### OSC 7: Working Directory Change

```lua
vim.api.nvim_create_autocmd({ 'TermRequest' }, {
  desc = 'Handles OSC 7 dir change requests',
  callback = function(ev)
    local val, n = string.gsub(ev.data.sequence, '\027]7;file://[^/]*', '')
    if n > 0 then
      local dir = val
      if vim.fn.isdirectory(dir) == 0 then return end
      vim.b[ev.buf].osc7_dir = dir
      if vim.api.nvim_get_current_buf() == ev.buf then
        vim.cmd.lcd(dir)
      end
    end
  end
})
```

#### OSC 52: System Clipboard

Applications can write to clipboard via OSC 52. Nvim uses the configured clipboard provider.

#### OSC 133: Shell Integration (Prompt Navigation)

`]]` and `[[` motions jump to next/previous prompts if shell emits OSC 133.

### Status Variables

- `b:term_title` - Terminal title (user-writable)
- `'channel'` - Terminal PTY job-id (use with `chansend()`)
- `TermClose` event gives exit code in `v:event.status`

```vim
autocmd TermOpen * setlocal statusline=%{b:term_title}
autocmd TermClose * echom 'Terminal exited with status '..v:event.status
```

## Job Control

Job control enables multitasking -- scripts can spawn and control multiple processes without blocking Nvim.

### Job ID

Each job is identified by an integer id, unique for the session. Job ids are valid channel ids (shared namespace). Functions like `jobstart()` return job ids.

### Usage

```lua
-- Lua style
local job_id = vim.fn.jobstart({'bash', '-c', 'echo hello'}, {
  on_stdout = function(id, data, event)
    vim.print(data)
  end,
  on_exit = function(id, exit_code, event)
    vim.print('exited with: ' .. exit_code)
  end,
})

-- Send data to stdin
vim.fn.chansend(job_id, "ls\n")

-- Stop a job
vim.fn.jobstop(job_id)

-- Close individual streams
vim.fn.chanclose(job_id, 'stdin')
```

### Callbacks

**`on_stdout(job_id, data, event)`** / **`on_stderr(job_id, data, event)`**:
- `data` is a list of strings (readfile-style). First/last items may be partial lines.
- EOF is `['']`.

**`on_exit(job_id, exit_code, event)`**:
- `exit_code`: process exit code, or 128+SIGNUM if killed by signal (e.g. 143 for SIGTERM)

**Handling partial lines:**
```lua
local chunks = {''}
local function on_stdout(job_id, data, event)
  chunks[#chunks] = chunks[#chunks] .. data[1]
  for i = 2, #data do
    table.insert(chunks, data[i])
  end
end
```

**Buffered mode:** Set `stdout_buffered = true` to invoke callback only after stream closes.

## Channels

Channels are Nvim's way of communicating with external processes.

### Opening Channels

1. `stdioopen()` - stdin/stdout when `nvim --headless`
2. `jobstart()` - stdin/stdout/stderr of spawned process
3. `jobstart(..., {pty = true})` - PTY master end
4. `sockconnect()` - TCP/IP socket or named pipe
5. External process connecting to Nvim's socket (RPC only)

### Channel ID

Each channel has a unique integer id for the session. Functions like `stdioopen()` return channel ids; `chansend()` consumes them.

### Channel Callbacks

```
on_stdout(chan_id, data, name)
on_stderr(chan_id, data, name)
on_stdin(chan_id, data, name)
on_data(chan_id, data, name)
```

- `data`: readfile-style list of strings. EOF = `['']`. First/last items may be partial lines.
- `name`: stream name string (e.g. `"stdout"`)

### RPC Channels

Open with `rpc = true` option for msgpack-RPC remote method calls in both directions.

### Standard IO Channel

```lua
-- uppercase.lua (run with: nvim --headless --cmd "source uppercase.lua")
vim.fn.stdioopen({
  on_stdin = function(id, data, event)
    if vim.deep_equal(data, {""}) then vim.cmd('quit') end
    vim.fn.chansend(id, vim.tbl_map(string.upper, data))
  end
})
```

Nvim's stderr is always available as `v:stderr` (write-only bytes channel).

### Prompt Buffers

Create by setting `'buftype'` to `"prompt"`. User can edit/submit text at end of buffer.

```lua
vim.bo.buftype = "prompt"
vim.fn.prompt_setcallback(buf, on_submit)
vim.fn.prompt_setprompt(buf, "shell command: ")
vim.cmd("startinsert")
```

- Press Enter to submit, Shift-Enter for newline without submitting
- `prompt_setcallback()`, `prompt_setprompt()`, `prompt_getprompt()`, `prompt_getinput()`
