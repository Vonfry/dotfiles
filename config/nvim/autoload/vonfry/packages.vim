"" packages.vim
" preinstall package manager and define the packages which are needed by default.
"

function! vonfry#packages#init()
    call vonfry#packages#preinstall()
    call vonfry#packages#use()
endfunction

function! vonfry#packages#preinstall()
    let g:vonfry_packages_dir = g:vonfry_local_cache . '/bundle'
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

