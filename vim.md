# List of shortcuts available in nvim

* `<C-j/k/l/p>` - move between buffers/split
* `<C-e>/<C-d>` - scroll down
* `<C-y>/<C-u>` - scroll up
* `<C-q>`/`<leader>q` - write and close current/all buffers
* `<C-d>`/`<leader>d` - write and delete current/all buffers
* `<number><CR>` - go to `<number>` line
* `Y` - yank till the end of line
* `<leared>h`/`<leader>v` - horizontal/vertical split
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
  * `<leader>ff` - call codeaction prompt for single line
  * `<leader>f<motion>` - call codeaction prompt for `<motion>`
  * `<leader>rn` - rename current word
  * `<leader>rf` - refactor current word
  * `K` - on hover show documentation
  * `<C-g>d` - coc-definition
  * `<C-g>y` - coc-type-definition
  * `<C-g>i` - coc-implementation
  * `<C-g>r` - coc-references
  * `[g`/`]g` - previous/next git chunk
  * `gd` - chunk diff info
* [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
  * `<leader>ta` - toggle tags sidebar
  * `<leader>/ta` - fuzzy search tags
* [tpope/vim-commentary](https://github.com/tpope/vim-commentary)
  * `<leader>c` - to comment line or selected lines
* [terryma/vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
  * `<C-n>` - select next place
  * `<C-x>` - skip next match
  * You can now change the virual cursots + selection with visual mode commands
(f.e. `c`, `I`, `A` will work fine). You could also go to
normal mode by pressing `v` and use normal commands there.
* [tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired)
  * `[a`/`]a` - previos/next file
  * `[A`/`]A` - firts/last file
  * `[b`/`]b` - previos/next buffer
  * `[B`/`]B` - first/last buffer
  * `[f`/`]f` - go to previos/next file
  * `[n`/`]n` - go to previos/next SCM conflict marker of diff
  * `[t`/`]t` - display previous/next tag
  * `[T`/`]T` - display first/last tag
  * `[<Space>`/`]<Space>` - add [count] blank lines above/below the cursor
  * `[e`/`]e` - exchange current line with [count] lines above/below it
  * `[p`/`]p` - paste on previos/next line
* [svermeulen/vim-subversive](https://github.com/svermeulen/vim-subversive)
  * `s<motion>` - subversive substitute (replace 'motion' with yanked chunk)
  * `ss` - subversive substitute line
  * `S` - subversive substitute to the EOL

