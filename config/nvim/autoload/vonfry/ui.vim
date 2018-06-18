"" ui.vim
"

function! vonfry#ui#init()
    set background=dark
    set t_Co=256

    if $TERM_PROGRAM =~ "iTerm"
        let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
        let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    endif

    colorscheme solarized8_high
endfunction
