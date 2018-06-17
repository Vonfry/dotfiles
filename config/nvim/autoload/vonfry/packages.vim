"" packages.vim
" preinstall package manager and define the packages which are needed by default.
"

let g:vonfry#packages#dir = g:vonfry#local#cache . '/bundle'

function! vonfry#packages#init()
    call vonfry#packages#preinstall()
    call vonfry#packages#use()
endfunction

function! vonfry#packages#preinstall()
    if &compatible
        set nocompatible
    endif
endfunction

function! vonfry#packages#add(repo)
endfunction

function! vonfry#packages#start()
endfunction

function! vonfry#packages#end()
endfunction

function! vonfry#packages#default()
    return []
endfunction

function! vonfry#packages#use()
    call vonfry#packages#start()
    " TODO add
    call vonfry#packages#end()
    filetype plugin indent on
    syntax enable
endfunction

