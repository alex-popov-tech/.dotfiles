# List of shortcuts available in nvim

* `<C-j/k/l/p>` - move between buffers/split
* `<C-left/down/up/right>` - resize splits
* `<S-down/up>` - move between buffers
* `<C-e>/<C-d>` - scroll down
* `<C-y>/<C-u>` - scroll up
* `<C-q>`/`<leader>q` - write and close current/all buffers
* `<C-d>`/`<leader>d` - write and delete current/all buffers
* `<number><CR>` - go to `<number>` line
* `Y` - yank till the end of line
* `<leader>h`/`<leader>v` - horizontal/vertical split
* folding
  * `zo` - opens folds
  * `zc` - closes fold
  * `zm` - increases auto fold depth
  * `zr` - reduces auto fold depth

## Plugins

### Text Objects, Surround

* [wellle/targets.vim](https://github.com/wellle/targets.vim/blob/master/cheatsheet.md)
* [michaeljsmith/vim-indent-object](https://github.com/michaeljsmith/vim-indent-object#usage)
* [tpope/vim-surround](https://github.com/tpope/vim-surround)
* `il/al` - line text object

### Search

* [junegunn/fzf](https://github.com/junegunn/fzf)
  * `<C-/>f` - find file
  * `<C-/>g` - find file under git
  * `<C-/>c` - find text in files
* [haya14busa/incsearch.vim](https://github.com/haya14busa/incsearch.vim)
  * `/`/`?` - search next/previos/leave to highlight
  * `*`/`#` - search for current word next/previos
  * `z/`/`z?` - fuzzy search next/previos/leave to highlight
  * `Tab`/`<Shift-Tab>` - while searching to move between occurences
* [rhysd/clever-r.vim](https://github.com/rhysd/clever-r.vim)
  * `f`/`F` - search character forward/back
  * `f.`/`F.` - search any non-alphanumeric/space character (like '.=+/-%')

### Code navigate/refactor

* [AndrewRadev/splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim)
  * `<leader>s`/`<leader>j` - split/join at current place
* [AndrewRadev/switch.vim](https://github.com/AndrewRadev/switch.vim)
  * `-` - toggle switch
* [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
  * `<C-f>` - toggle explorer
  * `<TAB>` - visual blocks of text
  * `<C-z>` - trigger autocompletion (`tab/<S-tab>` to navigate)
  * `<leader>y` - latest yanks
  * `<leader>e` - show diagnostics errors
  * `<leader>F` - coc-formate-and-organize-imports
  * `<leader>aa` - call codeaction prompt for single line
  * `<leader>a<motion>` - call codeaction prompt for `<motion>`
  * `<leader>ff` - fix-current
  * `<leader>rn` - rename current word
  * `<leader>rf` - refactor current word
  * `K` - on hover show documentation
  * `gd` - coc-definition
  * `gy` - coc-type-definition
  * `gi` - coc-implementation
  * `gr` - coc-references
  * `[d`/`]d` - previous/next diagnostic
  * `[g`/`]g` - previous/next git chunk
  * `gd` - chunk diff info
* [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
  * `<leader>ta` - toggle tags sidebar
  * `<leader>/ta` - fuzzy search tags
* [tpope/vim-commentary](https://github.com/tpope/vim-commentary)
  * `<leader>c` - to comment line or selected lines
* [tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired)
  * `[a`/`]a` - previous/next file
  * `[A`/`]A` - first/last file
  * `[b`/`]b` - previous/next buffer
  * `[B`/`]B` - first/last buffer
  * `[f`/`]f` - go to previous/next file
  * `[n`/`]n` - go to previous/next SCM conflict marker of diff
  * `[t`/`]t` - display previous/next tag
  * `[T`/`]T` - display first/last tag
  * `[<Space>`/`]<Space>` - add [count] blank lines above/below the cursor
  * `[e`/`]e` - exchange current line with [count] lines above/below it
  * `[p`/`]p` - paste on previous/next line
* [tpope/vim-abolish](https://github.com/tpope/vim-abolish)
  * Subvert
    * Blog to Post `:Subvert/blog{,s}/post{,s}/g`
    * Child to Adult `:Subvert/child{,ren}/adult{,s}/g`
  * `crs` - to snake case
  * `crc` - to camel case
  * `crm` - to mixed case
  * `cru` - to upper case
  * `crs` - to space case
  * `cr.` - to dot case
  * `cr-` - to dash case
* [svermeulen/vim-subversive](https://github.com/svermeulen/vim-subversive)
  * `s<motion>` - subversive substitute (replace 'motion' with yanked chunk)
  * `ss` - subversive substitute line
  * `S` - subversive substitute to the EOL

# Vim tips

* Put a count before a `<motion>i(` to operate multiple 'levels' of inner operation, f.e:
  `if (function(param1, param2, >param3)) {`
  Do `d2i(` to delete `if(...)` content.
* Use `=` to indent a block of code
* Use `gv` to recreate last selection
* Use `gf` to open file with the name coming from the word under the cursor
* Pressing o in visual mode switches the cursor at the other end of the selection
* Use `zt`, `zz` or `zb` to respectively move the the view towards to the top, the center or the bottom.
* Use `C-a`/`C-x` to increment/decrement number under cursor
* Use `^` to go to first non-space character of the line
* If you want to save a read-only file (forger to open vim with sudo), use the following command: `:w !sudo tee %`

