function! crystalline#theme#crystalline_gruvbox#set_theme() abort
    call crystalline#generate_theme({
                \ 'NormalMode':  [[235, 246], ['#4e4e4e', '#ffaf00']],
                \ 'InsertMode':  [[235, 109], ['#4e4e4e', '#83a598']],
                \ 'VisualMode':  [[235, 208], ['#4e4e4e', '#ffaf00']],
                \ 'ReplaceMode': [[235, 108], ['#4e4e4e', '#8ec07c']],
                \ '':            [[246, 239], ['#ffd7af', '#4e4e4e']],
                \ 'Inactive':    [[243, 237], ['#7c6f64', '#3c3836']],
                \ 'Fill':        [[246, 237], ['#a89984', '#3c3836']],
                \ 'Tab':         [[246, 239], ['#ffd7af', '#4e4e4e']],
                \ 'TabType':     [[235, 208], ['#282828', '#ffaf00']],
                \ 'TabSel':      [[235, 246], ['#282828', '#ffaf00']],
                \ 'TabFill':     [[235, 235], ['#282828', '#282828']],
                \ })
endfunction
