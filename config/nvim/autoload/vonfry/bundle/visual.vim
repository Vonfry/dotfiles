"" visual.vim
"

function vonfry#bundle#visual#init()
    call vonfry#bundle#visual#solarized()
    call vonfry#bundle#visual#airline()
endfunction

function vonfry#bundle#visual#solarized()
    vonfry#bundle#add('lifepillar/vim-solarized8')

    if has('gui_running')
        let g:solarized_termcolors= 256
    end
endfunction

function! vonfry#bundle#visual#airline()
    call vonfry#bundle#add('vim-airline/vim-airline',)
    call vonfry#bundle#add('vim-airline/vim-airline-themes',)
    call vonfry#bundle#add('enricobacis/vim-airline-clock')
endfunction

function! vonfry#bundle#visual#intent()
    call vonfry#bundle#add('yggdroot/indentline')
endfunction
