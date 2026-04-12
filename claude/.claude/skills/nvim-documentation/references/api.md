# Neovim API

Nvim exposes a powerful API usable via RPC, Lua (`vim.api`), and Vimscript.

**Indexing**: Most API uses 0-based indices, end-exclusive ranges. `-1` = last line/column.
Exceptions: `nvim_get_mark`, `nvim_buf_get_mark`, `nvim_buf_set_mark`, `nvim_win_get_cursor`, `nvim_win_set_cursor` use 1-based lines, 0-based columns.

For full details, grep `/opt/homebrew/Cellar/neovim/HEAD-16680e5/share/nvim/runtime/doc/api.txt`.

## Table of Contents

- [Global Functions](#global-functions)
- [Vimscript Bridge](#vimscript-bridge)
- [Autocommand Functions](#autocommand-functions)
- [Buffer Functions](#buffer-functions)
- [User Command Functions](#user-command-functions)
- [Extmark / Namespace Functions](#extmark--namespace-functions)
- [Option Functions](#option-functions)
- [Tabpage Functions](#tabpage-functions)
- [UI Functions](#ui-functions)
- [Window Functions](#window-functions)

## Global Functions

| Function | Description |
|---|---|
| `nvim_chan_send(chan, data)` | Send data to channel |
| `nvim_create_buf(listed, scratch)` | Create new buffer (returns bufnr) |
| `nvim_del_current_line()` | Delete current line |
| `nvim_del_keymap(mode, lhs)` | Unmap global keymap |
| `nvim_del_mark(name)` | Delete uppercase/file mark |
| `nvim_del_var(name)` | Remove global (g:) variable |
| `nvim_echo(chunks, history, opts)` | Echo message. chunks=`[[text,hl],...]`. opts: `verbose`, `kind` |
| `nvim_eval_statusline(str, opts)` | Evaluate statusline expression |
| `nvim_exec_lua(code, args)` | Execute Lua code, return result |
| `nvim_feedkeys(keys, mode, escape_ks)` | Send keys to Nvim input queue |
| `nvim_get_api_info()` | Returns `[channel_id, metadata]` |
| `nvim_get_chan_info(chan)` | Get channel info dict |
| `nvim_get_color_by_name(name)` | Get color integer by name |
| `nvim_get_color_map()` | Get all color names and values |
| `nvim_get_context(opts)` | Get editor context (for save/restore) |
| `nvim_get_current_buf()` | Get current buffer handle |
| `nvim_get_current_line()` | Get current line string |
| `nvim_get_current_tabpage()` | Get current tabpage handle |
| `nvim_get_current_win()` | Get current window handle |
| `nvim_get_hl(ns_id, opts)` | Get highlight definition(s). opts: `name`, `id`, `link` |
| `nvim_get_hl_id_by_name(name)` | Get highlight ID by name |
| `nvim_get_hl_ns(opts)` | Get active highlight namespace |
| `nvim_get_keymap(mode)` | Get global keymap list |
| `nvim_get_mark(name, opts)` | Get mark position `[row, col, buffer, buffername]` (1-indexed) |
| `nvim_get_mode()` | Get current mode `{mode, blocking}` (fast/non-blocking) |
| `nvim_get_proc(pid)` | Get process info |
| `nvim_get_proc_children(pid)` | Get child process IDs |
| `nvim_get_runtime_file(name, all)` | Find files in runtime dirs |
| `nvim_get_var(name)` | Get global (g:) variable |
| `nvim_get_vvar(name)` | Get v: variable |
| `nvim_input(keys)` | Queues raw input (fast, non-blocking) |
| `nvim_input_mouse(button, action, modifier, grid, row, col)` | Send mouse event |
| `nvim_list_bufs()` | List all buffer handles |
| `nvim_list_chans()` | List all channels |
| `nvim_list_runtime_paths()` | List runtime paths |
| `nvim_list_tabpages()` | List all tabpage handles |
| `nvim_list_uis()` | List attached UIs |
| `nvim_list_wins()` | List all window handles |
| `nvim_load_context(dict)` | Restore editor context |
| `nvim_open_term(buffer, opts)` | Open terminal in buffer. opts: `on_input`, `force_crlf` |
| `nvim_paste(data, crlf, phase)` | Paste text (handles large pastes efficiently) |
| `nvim_put(lines, type, after, follow)` | Put text like `p`/`P`. type: `c`har, `l`ine, `b`lock |
| `nvim_replace_termcodes(str, from_part, do_lt, special)` | Replace keycodes in string |
| `nvim_select_popupmenu_item(item, insert, finish, opts)` | Select popup menu item |
| `nvim_set_client_info(name, version, type, methods, attributes)` | Set RPC client info |
| `nvim_set_current_buf(buffer)` | Set current buffer |
| `nvim_set_current_dir(dir)` | Change directory |
| `nvim_set_current_line(line)` | Set current line |
| `nvim_set_current_tabpage(tabpage)` | Set current tabpage |
| `nvim_set_current_win(window)` | Set current window |
| `nvim_set_hl(ns_id, name, val)` | Set highlight group. val: `fg`, `bg`, `sp`, `bold`, `italic`, `underline`, `link`, etc. ns_id=0 for global |
| `nvim_set_hl_ns(ns_id)` | Set highlight namespace (for all windows) |
| `nvim_set_hl_ns_fast(ns_id)` | Set highlight namespace (fast, during redraw callback) |
| `nvim_set_keymap(mode, lhs, rhs, opts)` | Set global keymap. opts: `noremap`, `silent`, `expr`, `desc` |
| `nvim_set_var(name, value)` | Set global (g:) variable |
| `nvim_set_vvar(name, value)` | Set v: variable |
| `nvim_strwidth(text)` | Get string display width |

## Vimscript Bridge

| Function | Description |
|---|---|
| `nvim_call_dict_function(dict, fn, args)` | Call dict function |
| `nvim_call_function(fn, args)` | Call Vimscript function |
| `nvim_command(command)` | Execute Ex command |
| `nvim_eval(expr)` | Evaluate Vimscript expression |
| `nvim_cmd(cmd, opts)` | Execute Ex command from structured dict |
| `nvim_parse_cmd(str, opts)` | Parse Ex command into dict |
| `nvim_parse_expression(expr, flags, highlight)` | Parse Vimscript expression |

## Autocommand Functions

| Function | Description |
|---|---|
| `nvim_create_autocmd(event, opts)` | Create autocommand. opts: `group`, `pattern`, `buffer`, `callback`/`command`, `desc`, `once`, `nested` |
| `nvim_create_augroup(name, opts)` | Create augroup. opts: `clear` (default true) |
| `nvim_clear_autocmds(opts)` | Delete autocommands. opts: `event`, `pattern`, `group`, `buffer` |
| `nvim_del_autocmd(id)` | Delete autocommand by ID |
| `nvim_del_augroup_by_id(id)` | Delete augroup by ID |
| `nvim_del_augroup_by_name(name)` | Delete augroup by name |
| `nvim_exec_autocmds(event, opts)` | Execute autocommands. opts: `group`, `pattern`, `buffer`, `data` |
| `nvim_get_autocmds(opts)` | Get autocommands. opts: `group`, `event`, `pattern`, `buffer` |

## Buffer Functions

| Function | Description |
|---|---|
| `nvim_buf_attach(buffer, send_buffer, opts)` | Activate buffer updates. opts: `on_lines`, `on_bytes`, `on_changedtick`, `on_detach`, `on_reload`, `preview` |
| `nvim_buf_call(buffer, fun)` | Call function with buffer as temporary current |
| `nvim_buf_del_keymap(buffer, mode, lhs)` | Unmap buffer keymap |
| `nvim_buf_del_mark(buffer, name)` | Delete buffer mark |
| `nvim_buf_del_var(buffer, name)` | Remove buffer (b:) variable |
| `nvim_buf_delete(buffer, opts)` | Delete buffer. opts: `force`, `unload` |
| `nvim_buf_detach(buffer)` | Deactivate buffer updates |
| `nvim_buf_get_changedtick(buffer)` | Get b:changedtick |
| `nvim_buf_get_keymap(buffer, mode)` | Get buffer keymap list |
| `nvim_buf_get_lines(buffer, start, end, strict_indexing)` | Get lines (0-indexed, end-exclusive) |
| `nvim_buf_get_mark(buffer, name)` | Get buffer mark position `[row, col]` (1-indexed row) |
| `nvim_buf_get_name(buffer)` | Get buffer filename |
| `nvim_buf_get_offset(buffer, index)` | Get byte offset of line |
| `nvim_buf_get_text(buffer, start_row, start_col, end_row, end_col, opts)` | Get text region |
| `nvim_buf_get_var(buffer, name)` | Get buffer (b:) variable |
| `nvim_buf_is_loaded(buffer)` | Check if buffer is loaded |
| `nvim_buf_is_valid(buffer)` | Check if buffer handle is valid |
| `nvim_buf_line_count(buffer)` | Get line count |
| `nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)` | Set buffer keymap |
| `nvim_buf_set_lines(buffer, start, end, strict_indexing, replacement)` | Set lines |
| `nvim_buf_set_mark(buffer, name, line, col, opts)` | Set buffer mark (1-indexed) |
| `nvim_buf_set_name(buffer, name)` | Set buffer filename |
| `nvim_buf_set_text(buffer, start_row, start_col, end_row, end_col, replacement)` | Set text region |
| `nvim_buf_set_var(buffer, name, value)` | Set buffer (b:) variable |

## User Command Functions

| Function | Description |
|---|---|
| `nvim_create_user_command(name, command, opts)` | Create user command. opts: `nargs`, `range`, `count`, `bang`, `bar`, `complete`, `desc`, `force`, `preview` |
| `nvim_del_user_command(name)` | Delete user command |
| `nvim_buf_create_user_command(buffer, name, command, opts)` | Create buffer-local user command |
| `nvim_buf_del_user_command(buffer, name)` | Delete buffer-local user command |
| `nvim_get_commands(opts)` | Get global user commands |
| `nvim_buf_get_commands(buffer, opts)` | Get buffer user commands |

## Extmark / Namespace Functions

| Function | Description |
|---|---|
| `nvim_create_namespace(name)` | Create/get namespace ID |
| `nvim_get_namespaces()` | Get all namespace name->ID mappings |
| `nvim_buf_set_extmark(buffer, ns_id, line, col, opts)` | Set extmark. opts: `end_row`, `end_col`, `hl_group`, `virt_text`, `virt_text_pos`, `virt_lines`, `sign_text`, `sign_hl_group`, `number_hl_group`, `line_hl_group`, `priority`, `spell`, `conceal`, etc. |
| `nvim_buf_get_extmark_by_id(buffer, ns_id, id, opts)` | Get extmark position |
| `nvim_buf_get_extmarks(buffer, ns_id, start, end, opts)` | Get extmarks in range. opts: `limit`, `details`, `overlap`, `type` |
| `nvim_buf_del_extmark(buffer, ns_id, id)` | Delete extmark |
| `nvim_buf_clear_namespace(buffer, ns_id, line_start, line_end)` | Clear namespace in range |
| `nvim_set_decoration_provider(ns_id, opts)` | Set decoration provider. opts: `on_start`, `on_buf`, `on_win`, `on_line`, `on_end`, `on_range` |

## Option Functions

| Function | Description |
|---|---|
| `nvim_get_option_value(name, opts)` | Get option value. opts: `scope` (`"global"`/`"local"`), `win`, `buf`, `filetype` |
| `nvim_set_option_value(name, value, opts)` | Set option value |
| `nvim_get_all_options_info()` | Get all options info |

## Tabpage Functions

| Function | Description |
|---|---|
| `nvim_tabpage_get_number(tabpage)` | Get tabpage number |
| `nvim_tabpage_get_win(tabpage)` | Get current window in tabpage |
| `nvim_tabpage_set_win(tabpage, win)` | Set current window in tabpage |
| `nvim_tabpage_list_wins(tabpage)` | List windows in tabpage |
| `nvim_tabpage_get_var(tabpage, name)` | Get tabpage (t:) variable |
| `nvim_tabpage_set_var(tabpage, name, value)` | Set tabpage (t:) variable |
| `nvim_tabpage_del_var(tabpage, name)` | Delete tabpage variable |
| `nvim_tabpage_is_valid(tabpage)` | Check if tabpage is valid |

## UI Functions

| Function | Description |
|---|---|
| `nvim_ui_attach(width, height, options)` | Attach UI |
| `nvim_ui_detach()` | Detach UI |
| `nvim_ui_set_option(name, value)` | Set UI option |
| `nvim_ui_set_focus(gained)` | Notify focus change |
| `nvim_ui_try_resize(width, height)` | Resize UI |
| `nvim_ui_try_resize_grid(grid, width, height)` | Resize multigrid grid |
| `nvim_ui_pum_set_height(height)` | Set popup menu height |
| `nvim_ui_pum_set_bounds(width, height, row, col)` | Set popup menu bounds |
| `nvim_ui_send(content)` | Send data to UI stdout |

## Window Functions

| Function | Description |
|---|---|
| `nvim_open_win(buffer, enter, config)` | Open floating/split window. Config keys: `relative` (`"editor"`/`"win"`/`"cursor"`/`"mouse"`), `width`, `height`, `row`, `col`, `anchor`, `border`, `title`, `footer`, `style`, `zindex`, `split`, `win`, `vertical`, `fixed` |
| `nvim_win_get_config(window)` | Get window config |
| `nvim_win_set_config(window, config)` | Reconfigure window |
| `nvim_win_call(window, fun)` | Call function in window context |
| `nvim_win_close(window, force)` | Close window |
| `nvim_win_get_buf(window)` | Get buffer in window |
| `nvim_win_set_buf(window, buffer)` | Set buffer in window |
| `nvim_win_get_cursor(window)` | Get cursor position `[row, col]` (1-indexed row) |
| `nvim_win_set_cursor(window, pos)` | Set cursor position |
| `nvim_win_get_height(window)` | Get window height |
| `nvim_win_set_height(window, height)` | Set window height |
| `nvim_win_get_width(window)` | Get window width |
| `nvim_win_set_width(window, width)` | Set window width |
| `nvim_win_get_position(window)` | Get window position `[row, col]` |
| `nvim_win_get_number(window)` | Get window number |
| `nvim_win_get_tabpage(window)` | Get window's tabpage |
| `nvim_win_get_var(window, name)` | Get window (w:) variable |
| `nvim_win_set_var(window, name, value)` | Set window (w:) variable |
| `nvim_win_del_var(window, name)` | Delete window variable |
| `nvim_win_set_hl_ns(window, ns_id)` | Set window highlight namespace |
| `nvim_win_hide(window)` | Close window and hide buffer |
| `nvim_win_is_valid(window)` | Check if window is valid |
| `nvim_win_text_height(window, opts)` | Calculate text height. opts: `start_row`, `end_row`, `start_vcol`, `end_vcol`, `max_height` |
