"" packages.vim
" preinstall package manager and define the packages which are needed by default.
"

let g:vonfry#packages#dir = g:vonfry#local#cache . '/bundle/'
let g:vonfry#packages#default = []

function! vonfry#packages#init()
    call vonfry#packages#preinstall()
    call vonfry#packages#use()
    call vonfry#packages#install()
endfunction

function! vonfry#packages#preinstall()
    if has('win16') || has('win32') || has('win64')
        let s:Psep = ';'
        let s:Fsep = '\'
    else
        let s:Psep = ':'
        let s:Fsep = '/'
    endif
    if &compatible
        set nocompatible
    endif
    if filereadable(expand(g:vonfry#packages#dir)
                \ . join(['repos', 'github.com',
                \ 'Shougo', 'dein.vim', 'README.md'],
                \ s:Fsep))
    elseif executable('git')
        exec '!git clone https://github.com/Shougo/dein.vim "'
                    \ . expand(g:vonfry#packages#dir)
                    \ . join(['repos', 'github.com',
                    \ 'Shougo', 'dein.vim"'], s:Fsep)
    else
        echohl WarningMsg
        echom 'You need install git!'
        echohl None
    endif
    exec 'set runtimepath+='. fnameescape(g:vonfry#packages#dir)
            \ . join(['repos', 'github.com', 'Shougo',
            \ 'dein.vim'], s:Fsep)
endfunction

function! vonfry#packages#add(plug)
    if type(plug) == 1 "string
        call dein#add(plug)
    elseif type(plug) == 3 && len(plug) >= 1 && len(plug) <= 2 "list
        if len(plug) == 1
            call dein#add(plug[0])
        else
            call dein#add(plug[0], plug[1])
        endif
    else
        throw "add arguments error"
    endif
endfunction

function! vonfry#packages#begin()
    call dein#load_state(g:vonfry#packages#dir)
    call dein#begin(g:vonfry#packages#dir)
endfunction

function! vonfry#packages#end()
    call dein#end()
    call dein#save_state()
endfunction

function! vonfry#packages#use()
    call vonfry#packages#begin()
    for plug in g:vonfry#packages#default
        vonfry#packages#add(plug)
    endfor
    call vonfry#packages#end()
    filetype plugin indent on
    syntax enable
endfunction

function! vonfry#packages#install()
    if !dein#check_install()
        call dein#install()
    endif
endfunction
