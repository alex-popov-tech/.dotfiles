# Autocommands

Automatic commands for Neovim. Commands executed automatically on events such as reading/writing files, entering/leaving buffers and windows, and exiting Vim.

## 1. Introduction

You can specify commands to be executed automatically when reading or writing a file, when entering or leaving a buffer or window, and when exiting Vim. For example, you can create an autocommand to set the `'cindent'` option for files matching `*.c`.

WARNING: Using autocommands is very powerful, and may lead to unexpected side effects. Be careful not to destroy your text.

## 2. Defining autocommands

```
:au[tocmd] [group] {event} {aupat} [++once] [++nested] {cmd}
```

Add `{cmd}` to the list of commands that Vim will execute automatically on `{event}` for a file matching `{aupat}`. Nvim always adds `{cmd}` after existing autocommands so they execute in the order in which they were defined.

- `++once` -- The command is executed once, then removed ("one shot").
- `++nested` -- See autocmd-nested below.

The special pattern `<buffer>` or `<buffer=N>` defines a buffer-local autocommand. See buffer-local autocommands below.

Note: The `:autocmd` command can only be followed by another command when the `|` appears where the pattern is expected. This works:

```vim
:augroup mine | au! BufRead | augroup END
```

But this sees "augroup" as part of the defined command:

```vim
:augroup mine | au! BufRead * | augroup END
```

Instead you can put the group name into the command:

```vim
:au! mine BufRead *
:au mine BufRead * set tw=70
```

Or use `:execute`:

```vim
:augroup mine | exe "au! BufRead *" | augroup END
```

Special characters (e.g., `%`, `<cword>`) in the `:autocmd` arguments are not expanded when the autocommand is defined. They are expanded when the event is recognized and the `{cmd}` is executed. The exception is `<sfile>`, which is expanded when the autocmd is defined.

`:autocmd` adds to the list of autocommands regardless of whether they are already present. When your vimrc is sourced twice, the autocommands will appear twice. To avoid this, define your autocommands in a group:

```vim
augroup vimrc
  autocmd!
  au BufNewFile,BufRead *.html so <sfile>:h/html.vim
augroup END
```

## 3. Removing autocommands

```
:au[tocmd]! [group] {event} {aupat} [++once] [++nested] {cmd}
```

Remove all autocommands associated with `{event}` and `{aupat}`, and add the command `{cmd}`.

```
:au[tocmd]! [group] {event} {aupat}
```

Remove all autocommands associated with `{event}` and `{aupat}`.

```
:au[tocmd]! [group] * {aupat}
```

Remove all autocommands associated with `{aupat}` for all events.

```
:au[tocmd]! [group] {event}
```

Remove ALL autocommands for `{event}`. Warning: You should not do this without a group for `BufRead` and other common events, it can break plugins, syntax highlighting, etc.

```
:au[tocmd]! [group]
```

Remove ALL autocommands. Warning: You should normally not do this without a group.

## 4. Listing autocommands

```
:au[tocmd] [group] {event} {aupat}    " show autocmds for {event} and {aupat}
:au[tocmd] [group] * {aupat}          " show autocmds for {aupat} for all events
:au[tocmd] [group] {event}            " show all autocmds for {event}
:au[tocmd] [group]                    " show all autocmds
```

If you provide the `[group]` argument, Vim lists only the autocommands for `[group]`; otherwise, Vim lists the autocommands for ALL groups.

When `'verbose'` is non-zero, listing an autocommand will also display where it was last defined.

## 5. Events

You can specify a comma-separated list of event names. No white space can be used in this list. The command applies to all the events in the list. Event names are case-insensitive.

For READING FILES there are four kinds of events possible:

| Kind | Pre | Post |
|------|-----|------|
| Non-existent file | `BufNewFile` | |
| Existing file | `BufReadPre` | `BufReadPost` |
| Filter output | `FilterReadPre` | `FilterReadPost` |
| Any other read | `FileReadPre` | `FileReadPost` |

Vim uses only one of these four kinds when reading a file. The "Pre" and "Post" events are both triggered, before and after reading the file.

Use the `'eventignore'` option to ignore a number of events or all events.

### Complete Event List

**BufAdd** -- After adding a new buffer or existing unlisted buffer to the buffer list (except during startup), or renaming a listed buffer. Before `BufEnter`. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`.

**BufDelete** -- Before deleting a buffer from the buffer list. The `BufUnload` may be called first (if the buffer was loaded). Also used just before a buffer in the buffer list is renamed. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`. Do not change to another buffer.

**BufEnter** -- After entering (visiting, switching-to) a new or existing buffer. Useful for setting filetype options. Compare `BufNew` which does not trigger for existing buffers. After `BufAdd`. After `BufReadPost`.

**BufFilePost** -- After changing the name of the current buffer with the `:file` or `:saveas` command.

**BufFilePre** -- Before changing the name of the current buffer with the `:file` or `:saveas` command.

**BufHidden** -- Before a buffer becomes hidden: when there are no longer windows that show the buffer, but the buffer is not unloaded or deleted. Not used for `:qa` or `:q` when exiting Vim. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`.

**BufLeave** -- Before leaving to another buffer. Also when leaving or closing the current window and the new current window is not for the same buffer. Not used for `:qa` or `:q` when exiting Vim.

**BufModifiedSet** -- After the `'modified'` value of a buffer has been changed. Special-case of `OptionSet`.

**BufNew** -- After creating a new buffer (except during startup) or renaming an existing buffer. Unlike `BufEnter`, visiting (switching to) an existing buffer will not trigger this again. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`.

**BufNewFile** -- When starting to edit a file that doesn't exist. Can be used to read in a skeleton file.

**BufRead / BufReadPost** -- When starting to edit a new buffer, after reading the file into the buffer, before processing modelines. See `BufWinEnter` to do something after processing modelines. Also triggered when writing an unnamed buffer in a way that the buffer gets a name, after successfully recovering a file, and for the "filetypedetect" group when executing `:filetype detect`. Not triggered for the `:read file` command or when the file doesn't exist.

**BufReadCmd** -- Before starting to edit a new buffer. Should read the file into the buffer. (Cmd-event)

**BufReadPre** -- When starting to edit a new buffer, before reading the file into the buffer. Not used if the file doesn't exist.

**BufUnload** -- Before unloading a buffer, when the text in the buffer is going to be freed. After `BufWritePost`. Before `BufDelete`. Triggers for all loaded buffers when Vim is going to exit. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`. Do not switch buffers or windows! Not triggered when exiting and `v:dying` is 2 or more.

**BufWinEnter** -- After a buffer is displayed in a window. This may be when the buffer is loaded (after processing modelines) or when a hidden buffer is displayed (and is no longer hidden). Not triggered for `:split` without arguments since the buffer does not change. Triggered for `:split` with the name of the current buffer since it reloads that buffer.

**BufWinLeave** -- Before a buffer is removed from a window. Not when it's still visible in another window. Also triggered when exiting. Before `BufUnload`, `BufHidden`. NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`. Not triggered when exiting and `v:dying` is 2 or more.

**BufWipeout** -- Before completely deleting a buffer. The `BufUnload` and `BufDelete` events may be called first (if the buffer was loaded and was in the buffer list). Also used just before a buffer is renamed (also when it's not in the buffer list). NOTE: Current buffer `%` is not the target buffer `<afile>`, `<abuf>`. Do not change to another buffer.

**BufWrite / BufWritePre** -- Before writing the whole buffer to a file.

**BufWriteCmd** -- Before writing the whole buffer to a file. Should do the writing of the file and reset `'modified'` if successful, unless `+` is in `'cpo'` and writing to another file. The buffer contents should not be changed. When the command resets `'modified'` the undo information is adjusted to mark older undo states as 'modified', like `:write` does. Use the `'['` and `']'` marks for the range of lines. (Cmd-event)

**BufWritePost** -- After writing the whole buffer to a file (should undo the commands for `BufWritePre`).

**ChanInfo** -- State of channel changed, for instance the client of a RPC channel described itself. Triggered even without `++nested`. Sets `v:event` keys: `info` (as from `nvim_get_chan_info()`).

**ChanOpen** -- Just after a channel was opened. Triggered even without `++nested`. Sets `v:event` keys: `info` (as from `nvim_get_chan_info()`).

**CmdUndefined** -- When a user command is used but it isn't defined. Useful for defining a command only when it's used. The pattern is matched against the command name. Both `<amatch>` and `<afile>` expand to the command name. Triggered even without `++nested`.

**CmdlineChanged** -- After EVERY change inside command line. Also triggered during mappings! Use `<Cmd>` instead of `:` in mappings to avoid that. `<afile>` expands to the cmdline-char.

**CmdlineEnter** -- After entering the command-line (including non-interactive use of `:` in a mapping: use `<Cmd>` instead to avoid this). The pattern is matched against cmdline-char. `<afile>` expands to the cmdline-char. Sets `v:event` keys: `cmdlevel`, `cmdtype`.

**CmdlineLeave** -- Before leaving the command-line (including non-interactive use of `:` in a mapping: use `<Cmd>` instead to avoid this). `<afile>` expands to the cmdline-char. Sets `v:char` to the key that exited the command-line (e.g., `<CR>`, `<CTRL-C>`, `<Esc>`). Sets `v:event` keys: `abort` (mutable), `cmdlevel`, `cmdtype`. Note: `abort` can only be changed from false to true.

**CmdlineLeavePre** -- Just before leaving the command line, and before `CmdlineLeave`. Useful for capturing completion info with `cmdcomplete_info()`, as this information is cleared before `CmdlineLeave` is triggered. Also triggered when abandoning the command line by typing CTRL-C or `<Esc>`. `<afile>` is set to cmdline-char. Sets `v:char` as with `CmdlineLeave`.

**CmdwinEnter** -- After entering the command-line window. `<afile>` expands to a single character indicating the type of command-line.

**CmdwinLeave** -- Before leaving the command-line window. `<afile>` expands to a single character indicating the type of command-line.

**ColorScheme** -- After loading a color scheme. Not triggered if the color scheme is not found. The pattern is matched against the colorscheme name. `<afile>` can be used for the name of the actual file where this option was set, and `<amatch>` for the new colorscheme name.

**ColorSchemePre** -- Before loading a color scheme. Useful to setup removing things added by a color scheme, before another one is loaded.

**CompleteChanged** -- After each time the Insert mode completion menu changed. Not fired on popup menu hide, use `CompleteDonePre` or `CompleteDone` for that. Sets `v:event` keys: `completed_item`, `height`, `width`, `row`, `col`, `size`, `scrollbar`. Non-recursive. Cannot change the text (textlock).

**CompleteDonePre** -- After Insert mode completion is done. Either when something was completed or discarded. `complete_info()` is valid during this event. `v:completed_item` gives the completed item.

**CompleteDone** -- After Insert mode completion is done. Either when something was completed or discarded. `complete_info()` is cleared before this; use `CompleteDonePre` if you need it. `v:completed_item` gives the completed item, or empty dict if completion was discarded. Sets `v:event` keys: `complete_word`, `complete_type`, `reason` (one of: `"accept"`, `"cancel"`, `"discard"`).

**CursorHold** -- When there is no user input for `'updatetime'` duration, in Normal-mode. Not triggered while waiting for a command argument or movement after an operator, nor while recording a macro.

**CursorHoldI** -- Like `CursorHold`, but in Insert mode. Not triggered when waiting for another key, e.g. after CTRL-V, and not in CTRL-X mode.

**CursorMoved** -- After the cursor was moved in Normal or Visual mode or to another window. Also when the text of the cursor line has been changed, e.g. with `x`, `rx` or `p`. Not always triggered when there is typeahead, while executing commands in a script file, or when an operator is pending. Cannot be skipped with `:noautocmd`. Triggered very often -- avoid slow operations.

**CursorMovedC** -- After the cursor was moved in the command line. Be careful not to mess up the command line. `<afile>` expands to the cmdline-char.

**CursorMovedI** -- After the cursor was moved in Insert mode. Not triggered when the popup menu is visible. Otherwise the same as `CursorMoved`.

**DiffUpdated** -- After diffs have been updated. Depending on what kind of diff is being used (internal or external) this can be triggered on every change or when doing `:diffupdate`.

**DirChanged** -- After the current-directory was changed. The pattern can be: `"window"` (`:lcd`), `"tabpage"` (`:tcd`), `"global"` (`:cd`), `"auto"` (`'autochdir'`). Sets `v:event` keys: `cwd`, `scope`, `changed_window`. `<afile>` is set to the new directory name. Non-recursive.

**DirChangedPre** -- When the current-directory is going to be changed, as with `DirChanged`. Same pattern and `v:event` keys. Non-recursive.

**ExitPre** -- When using `:quit`, `:wq` in a way it makes Vim exit, or using `:qall`, just after `QuitPre`. Can be used to close any non-essential window.

**FileAppendCmd** -- Before appending to a file. Should do the appending. Use the `'[` and `']` marks for the range of lines. (Cmd-event)

**FileAppendPost** -- After appending to a file.

**FileAppendPre** -- Before appending to a file. Use the `'[` and `']` marks for the range of lines.

**FileChangedRO** -- Before making the first change to a read-only file. Can be used to checkout the file from a source control system. Not triggered when the change was caused by an autocommand. Cannot switch buffers. You can reload the buffer but not edit another one.

**FileChangedShell** -- When Vim notices that the modification time of a file has changed since editing started. Also when the file attributes or size change. Triggered after executing a shell command, `:checktime`, and `FocusGained`. Not used when `'autoread'` is set and the buffer was not changed. `v:fcs_reason` indicates what happened. Set `v:fcs_choice` to control what happens next. NOTE: Current buffer `%` is not the target buffer `<afile>` and `<abuf>`. Cannot switch, jump to or delete buffers. Non-recursive.

**FileChangedShellPost** -- After handling a file that was changed outside of Vim. Can be used to update the statusline.

**FileReadCmd** -- Before reading a file with a `:read` command. Should do the reading of the file. (Cmd-event)

**FileReadPost** -- After reading a file with a `:read` command. Vim sets the `'[` and `']` marks to the first and last line of the read.

**FileReadPre** -- Before reading a file with a `:read` command.

**FileType** -- When the `'filetype'` option has been set. The pattern is matched against the filetype. `<afile>` is the name of the file where this option was set. `<amatch>` is the new value of `'filetype'`. Cannot switch windows or buffers.

**FileWriteCmd** -- Before writing to a file, when not writing the whole buffer. Should do the writing to the file. Should not change the buffer. Use the `'['` and `']'` marks for the range of lines. (Cmd-event)

**FileWritePost** -- After writing to a file, when not writing the whole buffer.

**FileWritePre** -- Before writing to a file, when not writing the whole buffer. Use the `'['` and `']'` marks for the range of lines.

**FilterReadPost** -- After reading a file from a filter command. Vim checks the pattern against the name of the current buffer. Not triggered when `'shelltemp'` is off.

**FilterReadPre** -- Before reading a file from a filter command. Vim checks the pattern against the name of the current buffer, not the temporary file. Not triggered when `'shelltemp'` is off.

**FilterWritePost** -- After writing a file for a filter command or making a diff with an external diff. Not triggered when `'shelltemp'` is off.

**FilterWritePre** -- Before writing a file for a filter command or making a diff with an external diff. Vim checks the pattern against the name of the current buffer. Not triggered when `'shelltemp'` is off.

**FocusGained** -- Nvim got focus.

**FocusLost** -- Nvim lost focus. Also (potentially) when a GUI dialog pops up.

**FuncUndefined** -- When a user function is used but it isn't defined. Useful for defining a function only when it's used. The pattern is matched against the function name. Both `<amatch>` and `<afile>` are set to the name of the function. Triggered even without `++nested`. A better alternative is autoloaded functions.

**UIEnter** -- After a UI connects via `nvim_ui_attach()`, or after builtin TUI is started, after `VimEnter`. Sets `v:event` keys: `chan` (channel-id of the UI).

**UILeave** -- After a UI disconnects from Nvim, or after builtin TUI is stopped, after `VimLeave`. Sets `v:event` keys: `chan` (channel-id of the UI).

**InsertChange** -- When typing `<Insert>` while in Insert or Replace mode. The `v:insertmode` variable indicates the new mode.

**InsertCharPre** -- When a character is typed in Insert mode, before inserting the char. The `v:char` variable indicates the char typed and can be changed during the event to insert a different character. Cannot change the text (textlock).

**InsertEnter** -- Just before starting Insert mode. Also for Replace mode and Virtual Replace mode. The `v:insertmode` variable indicates the mode. The cursor is restored afterwards. If you do not want that set `v:char` to a non-empty string.

**InsertLeavePre** -- Just before leaving Insert mode. Also when using CTRL-O. Be careful not to change mode or use `:normal`.

**InsertLeave** -- Just after leaving Insert mode. Also when using CTRL-O. But not for CTRL-C.

**LspAttach** -- See LspAttach docs.

**LspDetach** -- See LspDetach docs.

**LspNotify** -- See LspNotify docs.

**LspProgress** -- See LspProgress docs.

**LspRequest** -- See LspRequest docs.

**LspTokenUpdate** -- See LspTokenUpdate docs.

**MarkSet** -- After a mark is set by `m`, `:mark`, and `nvim_buf_set_mark()`. Supports `[a-zA-Z]` marks. The autocmd-pattern is matched against the mark name (e.g. `[ab]` matches `a` or `b`, `*` matches all). The event-data has these keys: `name` (mark name), `line` (mark line), `col` (mark column).

**MenuPopup** -- Just before showing the popup menu (under the right mouse button). The pattern is matched against one or two characters representing the mode: `n` (Normal), `v` (Visual), `o` (Operator-pending), `i` (Insert), `c` (Command line), `tl` (Terminal).

**ModeChanged** -- After changing the mode. The pattern is matched against `'old_mode:new_mode'`, for example match against `*:c*` to simulate `CmdlineEnter`. Sets `v:event` keys: `old_mode`, `new_mode`. Triggered on every minor mode change.

```vim
:au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
:au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
:au WinEnter,WinLeave * let &l:rnu = mode() =~# '^[vV\x16]'
```

**Progress** -- After a progress message is created or updated via `nvim_echo`. The pattern is matched against title of the message. The event-data contains: `id`, `text`, `title`, `status`, `percent`.

```lua
vim.api.nvim_create_autocmd('Progress', {
  pattern = { "term" },
  callback = function(ev)
    print(string.format('event fired: %s', vim.inspect(ev)))
  end
})
local id = vim.api.nvim_echo({ { 'searching...' } }, true,
  { kind = 'progress', status = 'running', percent = 10, title = "term" })
vim.api.nvim_echo({ { 'searching' } }, true,
  { id = id, kind = 'progress', status = 'running', percent = 50, title = "term" })
vim.api.nvim_echo({ { 'done' } }, true,
  { id = id, kind = 'progress', status = 'success', percent = 100, title = "term" })
```

**OptionSet** -- After setting an option (except during startup). The autocmd-pattern is matched against the long option name. `<amatch>` indicates what option has been set. `v:option_type` indicates whether it's global or local scoped. `v:option_command` indicates what type of set/let command was used. `v:option_new` is the newly set value. `v:option_oldlocal` has the old local value. `v:option_oldglobal` has the old global value. `v:option_old` is the old option value. This does not set `<abuf>`, you could use `bufnr()`. Not triggered by the `'modified'` option (use `BufModifiedSet`). Non-recursive. Not triggered on startup.

**QuickFixCmdPre** -- Before a quickfix command is run (`:make`, `:lmake`, `:grep`, `:lgrep`, `:grepadd`, `:lgrepadd`, `:vimgrep`, `:lvimgrep`, `:vimgrepadd`, `:lvimgrepadd`, `:cfile`, `:cgetfile`, `:caddfile`, `:lfile`, `:lgetfile`, `:laddfile`, `:helpgrep`, `:lhelpgrep`, `:cexpr`, `:cgetexpr`, `:caddexpr`, `:cbuffer`, `:cgetbuffer`, `:caddbuffer`). The pattern is matched against the command being run. If this command causes an error, the quickfix command is not executed.

**QuickFixCmdPost** -- Like `QuickFixCmdPre`, but after a quickfix command is run, before jumping to the first location.

**QuitPre** -- When using `:quit`, `:wq` or `:qall`, before deciding whether it closes the current window or quits Vim. For `:wq` the buffer is written before `QuitPre` is triggered.

**RemoteReply** -- When a reply from a Vim that functions as server was received (`server2client()`). The pattern is matched against the `{serverid}`. `<amatch>` is equal to the `{serverid}` from which the reply was sent, and `<afile>` is the actual reply string.

**SearchWrapped** -- After making a search with `n` or `N` if the search wraps around the document.

**RecordingEnter** -- When a macro starts recording. The pattern is the current file name, and `reg_recording()` is the current register.

**RecordingLeave** -- When a macro stops recording. The pattern is the current file name, and `reg_recording()` is the recorded register. `reg_recorded()` is only updated after this event. Sets `v:event` keys: `regcontents`, `regname`.

**SafeState** -- When nothing is pending, going to wait for the user to type a character. Not triggered when: an operator is pending, a register was entered with `"r`, halfway executing a command, executing a mapping, there is typeahead, Insert mode completion is active, Command line completion is active. You can use `mode()` and `state()` to find out what state Vim is in.

**SessionLoadPost** -- After loading the session file created using the `:mksession` command.

**SessionWritePost** -- After writing a session file by calling the `:mksession` command.

**ShellCmdPost** -- After executing a shell command with `:!cmd`, `:make` and `:grep`. Can be used to check for any changed files.

**Signal** -- After Nvim receives a signal. The pattern is matched against the signal name. Only `SIGUSR1` and `SIGWINCH` are supported. Triggered even without `++nested`.

```vim
autocmd Signal SIGUSR1 call some#func()
```

**ShellFilterPost** -- After executing a shell command with `:{range}!cmd`, `:w !cmd` or `:r !cmd`. Can be used to check for any changed files.

**SourcePre** -- Before sourcing a Vimscript/Lua file. `<afile>` is the name of the file being sourced.

**SourcePost** -- After sourcing a Vimscript/Lua file. `<afile>` is the name of the file being sourced. Not triggered when sourcing was interrupted. Also triggered after a `SourceCmd` autocommand was triggered.

**SourceCmd** -- When sourcing a Vimscript/Lua file. `<afile>` is the name of the file being sourced. The autocommand must source that file. (Cmd-event)

**SpellFileMissing** -- When trying to load a spell checking file and it can't be found. The pattern is matched against the language. `<amatch>` is the language, `'encoding'` also matters.

**StdinReadPost** -- During startup, after reading from stdin into the buffer, before executing modelines.

**StdinReadPre** -- During startup, before reading from stdin into the buffer.

**SwapExists** -- Detected an existing swap file when starting to edit a file. Only when it is possible to select a way to handle the situation. The `v:swapname` variable holds the name of the swap file found, `<afile>` the file being edited. `v:swapcommand` may contain a command to be executed in the opened file. Set `v:swapchoice` to: `'o'` (open read-only), `'e'` (edit anyway), `'r'` (recover), `'d'` (delete swap file), `'q'` (quit), `'a'` (abort). Empty string = ask the user. Cannot change to another buffer or change the buffer name or change directory.

**Syntax** -- When the `'syntax'` option has been set. The pattern is matched against the syntax name. `<afile>` expands to the name of the file where this option was set. `<amatch>` expands to the new value of `'syntax'`.

**TabClosed** -- After closing a tab page. `<afile>` expands to the tab page number.

**TabClosedPre** -- Before closing a tab page. The window layout is locked, thus opening and closing of windows is prohibited.

**TabEnter** -- Just after entering a tab page. After `WinEnter`. Before `BufEnter`.

**TabLeave** -- Just before leaving a tab page. After `WinLeave`.

**TabNew** -- When creating a new tab page. After `WinEnter`. Before `TabEnter`.

**TabNewEntered** -- After entering a new tab page. After `BufEnter`.

**TermOpen** -- When a terminal job is starting. Can be used to configure the terminal buffer.

```lua
vim.print(vim.api.nvim_get_chan_info(vim.bo.channel))
```

**TermEnter** -- After entering Terminal-mode. After `TermOpen`.

**TermLeave** -- After leaving Terminal-mode. After `TermClose`.

**TermClose** -- When a terminal job ends. Sets `v:event` keys: `status` (job exit status, or -1 if the terminal buffer is deleted).

**TermRequest** -- When a terminal child process emits an OSC, DCS, or APC sequence. Sets `v:termrequest`. The event-data is a table with fields: `sequence` (the received sequence), `terminator` (BEL or ST), `cursor` ((1,0)-indexed, buffer-relative position). Triggered even without `++nested`.

**TermResponse** -- When Nvim receives a DA1, OSC, DCS, or APC response from the host terminal. Sets `v:termresponse`. The event-data is a table with field: `sequence`. Triggered even without `++nested`. May be triggered during another event.

```lua
-- Query the terminal palette for the RGB value of color 1 (red) using OSC 4
vim.api.nvim_create_autocmd('TermResponse', {
  once = true,
  callback = function(args)
    local resp = args.data.sequence
    local r, g, b = resp:match("\027%]4;1;rgb:(%w+)/(%w+)/(%w+)")
  end,
})
vim.api.nvim_ui_send("\027]4;1;?\027\\")
```

**TextChanged** -- After a change was made to the text in the current buffer in Normal mode. That is after `b:changedtick` has changed. Not triggered when there is typeahead or when an operator is pending. Cannot be skipped with `:noautocmd`. Triggered very often -- avoid slow operations.

**TextChangedI** -- After a change was made to the text in the current buffer in Insert mode. Not triggered when the popup menu is visible. Otherwise the same as `TextChanged`.

**TextChangedP** -- After a change was made to the text in the current buffer in Insert mode, only when the popup menu is visible. Otherwise the same as `TextChanged`.

**TextChangedT** -- After a change was made to the text in the current buffer in Terminal-mode. Otherwise the same as `TextChanged`.

**TextYankPost** -- Just after a yank or deleting command, but not if the black hole register `"_` is used nor for `setreg()`. Pattern must be `*`. Sets `v:event` keys: `inclusive`, `operator`, `regcontents`, `regname`, `regtype`, `visual`. The `inclusive` flag combined with the `'['` and `']'` marks can be used to calculate the precise region. Non-recursive. Cannot change the text (textlock).

**User** -- Not executed automatically. Use `:doautocmd` to trigger this, typically for "custom events" in a plugin.

```vim
:autocmd User MyPlugin echom 'got MyPlugin event'
:doautocmd User MyPlugin
```

**UserGettingBored** -- When the user presses the same key 42 times. Just kidding! :-)

**VimEnter** -- After doing all the startup stuff, including loading vimrc files, executing the `-c cmd` arguments, creating all windows and loading the buffers in them. Just before this event is triggered the `v:vim_did_enter` variable is set.

```vim
if v:vim_did_enter
  call s:init()
else
  au VimEnter * call s:init()
endif
```

**VimLeave** -- Before exiting Vim, just after writing the .shada file. Executed only once, like `VimLeavePre`. Use `v:dying` to detect an abnormal exit. Use `v:exiting` to get the exit code. Not triggered if `v:dying` is 2 or more.

**VimLeavePre** -- Before exiting Vim, just before writing the shada file. Executed only once, if the pattern matches the current buffer on exit. Use `v:dying` to detect an abnormal exit. Use `v:exiting` to get the exit code. Not triggered if `v:dying` is 2 or more.

**VimResized** -- After the Vim window was resized, thus `'lines'` and/or `'columns'` changed. Not when starting up.

**VimResume** -- After Nvim resumes from suspend state.

**VimSuspend** -- Before Nvim enters suspend state.

**WinClosed** -- When closing a window, just before it is removed from the window layout. The pattern is matched against the window-ID. Both `<amatch>` and `<afile>` are set to the window-ID. After `WinLeave`. Non-recursive.

**WinEnter** -- After entering another window. Not done for the first window, when Vim has just started. If the window is for another buffer, Vim executes the `BufEnter` autocommands after the `WinEnter` autocommands. Note: For split and tabpage commands the `WinEnter` event is triggered after the split or tab command but before the file is loaded.

**WinLeave** -- Before leaving a window. If the window to be entered next is for a different buffer, Vim executes the `BufLeave` autocommands before the `WinLeave` autocommands (but not for `:new`). Not used for `:qa` or `:q` when exiting. Before `WinClosed`.

**WinNewPre** -- Before creating a new window. Triggered before commands that modify window layout by creating a split. Not done when creating tab pages and for the first window. It is not allowed to modify window layout while executing commands for this event. Useful to store current window layout for comparison.

**WinNew** -- When a new window was created. Not done for the first window, when Vim has just started. Before `WinEnter`.

**WinScrolled** -- After any window in the current tab page scrolled the text (horizontally or vertically) or changed width or height. Cannot be skipped with `:noautocmd`. The pattern is matched against the window-ID of the first window that scrolled or resized. Both `<amatch>` and `<afile>` are set to the window-ID. `v:event` is set with information about size and scroll changes. Only starts triggering after startup finished and the first screen redraw was done. Non-recursive, but if the command causes a window to scroll or change size, another `WinScrolled` event will be triggered later.

**WinResized** -- After a window in the current tab page changed width or height. `v:event` is set with information about size changes. Same behavior as `WinScrolled` for the pattern, triggering and recursiveness.

## 6. Patterns

The `{aupat}` argument of `:autocmd` can be a comma-separated list. This works as if the command was given with each pattern separately.

The file pattern `{aupat}` is tested for a match against the file name in one of two ways:
1. When there is no `/` in the pattern, Vim checks for a match against only the tail part of the file name (without its leading directory path).
2. When there is a `/` in the pattern, Vim checks for a match against both the short file name (as you typed it) and the full file name (after expanding it to a full path and resolving symbolic links).

The special pattern `<buffer>` or `<buffer=N>` is used for buffer-local autocommands.

### File pattern characters

| Pattern | Meaning |
|---------|---------|
| `*` | matches any sequence of characters (including path separators) |
| `?` | matches any single character |
| `\?` | matches a literal `?` |
| `.` | matches a `.` |
| `~` | matches a `~` |
| `,` | separates patterns |
| `\,` | matches a `,` |
| `{ }` | like `\( \)` in a pattern |
| `,` (inside `{}`) | like `\|` in a pattern |
| `\}` | literal `}` |
| `\{` | literal `{` |
| `\\\{n,m\}` | like `\{n,m}` in a pattern |
| `\` | special meaning like in a pattern |
| `[ch]` | matches `c` or `h` |
| `[^ch]` | match any character but `c` and `h` |

Note that `/` is used for path separator on all platforms (including Windows).

Environment variables can be used in a pattern and `~` can be used for the home directory. The environment variable is expanded when the autocommand is defined, not when executed.

Matching with the pattern is done when an event is triggered. Changing the buffer name in one of the autocommands, or even deleting the buffer, does not change which autocommands will be executed.

## 7. Buffer-local autocommands

Buffer-local autocommands are attached to a specific buffer. Instead of a pattern they use one of these forms:

| Form | Meaning |
|------|---------|
| `<buffer>` | current buffer |
| `<buffer=99>` | buffer number 99 |
| `<buffer=abuf>` | using `<abuf>` (only when executing autocommands) |

Examples:

```vim
:au CursorHold <buffer>  echo 'hold'
:au CursorHold <buffer=33>  echo 'hold'
:au BufNewFile * au CursorHold <buffer=abuf>  echo 'hold'
```

All the commands for autocommands also work with buffer-local autocommands:

```vim
:au! * <buffer>              " remove buffer-local autocmds for current buffer
:au! * <buffer=33>           " remove buffer-local autocmds for buffer #33
:bufdo :au! CursorHold <buffer>  " remove autocmd for given event for all buffers
:au * <buffer>               " list buffer-local autocmds for current buffer
```

To test for presence of buffer-local autocommands:

```vim
:if exists("#CursorHold#<buffer=12>") | ... | endif
:if exists("#CursorHold#<buffer>") | ... | endif    " for current buffer
```

When a buffer is wiped out its buffer-local autocommands are also gone. When deleting a buffer with `:bdel`, it is only unlisted and the autocommands are still present.

## 8. Groups

Autocommands can be put together in a group. This is useful for removing or executing a group of autocommands.

The group name can contain any characters except white space. The group name is case sensitive (unlike event names). The group name `"end"` is reserved.

### `:augroup`

```
:aug[roup] {name}
```

Define the autocmd group name for the following `:autocmd` commands. The name `"end"` or `"END"` selects the default group.

```
:aug[roup]! {name}
```

Delete the autocmd group `{name}`. Don't use this if there is still an autocommand using this group.

### Recommended pattern

```vim
:augroup uncompress
:  au!
:  au BufEnter *.gz  %!gunzip
:augroup END
```

This prevents having the autocommands defined twice (e.g., after sourcing the vimrc file again).

The `FileExplorer` group is special: if this group exists Vim assumes that editing a directory is possible and will trigger a plugin that lists the files in that directory.

## 9. Executing autocommands

### `:doautocmd`

```
:do[autocmd] [<nomodeline>] [group] {event} [fname]
```

Apply the autocommands matching `[fname]` (default: current file name) for `{event}` to the current buffer. When the `[group]` argument is not given, Vim executes the autocommands for all groups. When `[group]` is included, Vim executes only the matching autocommands for that group.

After applying the autocommands the modelines are processed, so that their settings overrule the settings from autocommands when editing a file. This is skipped if `<nomodeline>` is specified. You probably want to use `<nomodeline>` for events not used when loading a buffer, such as `User`.

### `:doautoall`

```
:doautoa[ll] [<nomodeline>] [group] {event} [fname]
```

Like `:doautocmd`, but apply the autocommands to each loaded buffer. The current buffer is done last.

Note that `[fname]` is used to select the autocommands, not the buffers to which they are applied.

Careful: Don't use this for autocommands that delete a buffer, change to another buffer or change the contents of a buffer; the result is unpredictable.

## 10. Using autocommands

For WRITING FILES there are four possible sets of events:

| Cmd | Pre | Post | Description |
|-----|-----|------|-------------|
| `BufWriteCmd` | `BufWritePre` | `BufWritePost` | writing the whole buffer |
| | `FilterWritePre` | `FilterWritePost` | writing to filter temp file |
| `FileAppendCmd` | `FileAppendPre` | `FileAppendPost` | appending to a file |
| `FileWriteCmd` | `FileWritePre` | `FileWritePost` | any other file write |

When there is a matching `*Cmd` autocommand, it is assumed it will do the writing. No further writing is done and the other events are not triggered.

The `'[` and `']` marks have special positions:
- Before `*ReadPre`: `'[` is set to the line just above where new lines will be inserted.
- Before `*ReadPost`: `'[` is set to the first line that was just read, `']` to the last line.
- Before `*WriteCmd`, `*WritePre` and `*AppendPre`: `'[` is set to the first line that will be written, `']` to the last line.

In commands which expect a file name, you can use `<afile>` for the file name that is being read, `%` for the current file name, and `<abuf>` for the buffer number of the currently effective buffer.

### Nesting

By default, autocommands do not nest. For example, if you use `:e` or `:w` in an autocommand, Vim does not execute the `BufRead` and `BufWrite` autocommands for those commands. If you do want this, use the `++nested` flag:

```vim
:autocmd FileChangedShell *.c ++nested e!
```

The nesting is limited to 10 levels to get out of recursive loops.

If you want to skip autocommands for one command, use the `:noautocmd` command modifier or the `'eventignore'` option.

### Search patterns

Autocommands do not change the current search patterns. Vim saves the current search patterns before executing autocommands then restores them after. Within autocommands, you can still use search patterns normally. If you want an autocommand to set the search pattern, use `:let @/ =`.

### Cmd-event

When using one of the `*Cmd` events, the matching autocommands are expected to do the file reading, writing or sourcing. If you use these events in a wrong way, it may make it impossible to read or write the matching files. Best is to use a pattern that will never match a normal file name, for example `ftp://*`.

The `v:cmdarg` variable holds the `++enc=` and `++ff=` argument that are effective. The `v:cmdbang` variable is one when `!` was used, zero otherwise.

## 11. Disabling autocommands

To disable autocommands for some time use the `'eventignore'` option. Note that this may cause unexpected behavior; make sure you restore `'eventignore'` afterwards, using a `:try` block with `:finally`.

To disable autocmds indefinitely in a specific window use the `'eventignorewin'` option. This can only be used to ignore window and buffer related events.

### `:noautocmd`

```
:noautocmd {cmd}
```

`:noa` for short. Sets `'eventignore'` to `"all"` for the duration of the following command.

```vim
:noautocmd w fname.gz
```

This will write the file without triggering the autocommands defined by the gzip plugin.

Note that some autocommands are not triggered right away, but only later. This specifically applies to `CursorMoved` and `TextChanged`.
