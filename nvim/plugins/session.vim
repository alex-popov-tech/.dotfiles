Plug 'mhinz/vim-startify'
" Automatically save the session when leaving Vim
" Close all active buffers except last N
let s:buffers_to_keep = 5
let g:sessionsdir = '~/.vim/sessions/'
let g:startify_session_dir = g:sessionsdir
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]
" use vsc root when enter file
let g:startify_change_to_vcs_root = 1
" do not show 'edit' and 'quit' options
let g:startify_enable_special = 0

function EnsureSessionsDirExists()
  exe "!mkdir -p ". g:sessionsdir
endfunction

" is current dir a git repo
function IsGitRepository()
  if !empty(glob('.git'))
    return 1
  else
    return 0
  endif
endfunction

" ~/.dotfiles -> .dotfiles
" ~/Documents/selenidejs-webdriver-jasmine-example -> selenidejs-webdriver-jasmine-example
function GetProjectNameFromPath()
  let b:projectpath = finddir('.git/..', expand('%:p:h').';')
  let b:rawprojectpath = split(b:projectpath, '/')[-1]
  let b:projectname = substitute(b:rawprojectpath, "\\.", "", "")
  return b:projectname
endfunction

" dotfiles -> ~/.vim/sessions/dotfiles.vim
function GetSessionNameForProject(projectname)
  return g:sessionsdir . a:projectname . '.vim'
endfunction

" write session file
function EnsureSession()
  if &ft != 'gitcommit' || empty(&ft)
    call DeleteTrashBuffers()
    call s:deleteExtraBuffers()
    call EnsureSessionsDirExists()
    let b:projectname = GetProjectNameFromPath()
    let b:filename = GetSessionNameForProject(b:projectname)
    exe "mksession! " . b:filename
  endif
endfunction

" is file empty
function! IsFileEmpty(filepath)
  let lines = readfile(a:filepath)    " read the file *contents* into a list
  let matched_index = match(lines, '\S')  " find the first entry with a non-space
  return matched_index == -1              " if no match was found -1 was returned
endfunction

" open session if exists, startify otherwise
function OpenSessionOrStartify()
  if !argc()
    if IsGitRepository()
      let b:projectname = GetProjectNameFromPath()
      let b:projectsessionname = GetSessionNameForProject(b:projectname)
      if !empty(glob(b:projectsessionname)) && !IsFileEmpty(glob(b:projectsessionname))
        execute "source" b:projectsessionname
      endif
    else
      Startify
    endif
  endif
endfunction

" help functions from fzf.vim
function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction
function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  " Using minus between a float and a number in a sort function causes an error
  return b1 < b2 ? 1 : -1
endfunction
function! s:buflisted_sorted()
  return sort(s:buflisted(), 's:sort_buffers')
endfunction

autocmd SourcePost * call DeleteTrashBuffers()

" close stupid buffers on start
function! DeleteTrashBuffers()
  let allBuffers = s:buflisted_sorted()
  let filteredBuffers = []
  for buffer in allBuffers
    if bufname(buffer) =~ "list"
      silent exe 'bdel ' . bufname(buffer)
    else
      call add(filteredBuffers, buffer)
    endif
  endfor
  return filteredBuffers
endfunction

function! s:deleteExtraBuffers()
  let bufferIds = s:buflisted_sorted()
  if len(bufferIds) < s:buffers_to_keep
    return
  endif
  let buffers_to_close = bufferIds[s:buffers_to_keep:]
  for buffer in buffers_to_close
    silent exe 'bdel ' . buffer
  endfor
endfunction

" save session on exit, open session/startify on enter
autocmd VimLeave * call EnsureSession()
autocmd VimEnter * nested call OpenSessionOrStartify()
