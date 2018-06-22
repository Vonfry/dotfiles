"" bundle.vim
" preinstall package manager and define the bundle which are needed by default.
"

let g:vonfry#bundle#dir = g:vonfry#local#cache . '/bundle/'
let g:vonfry#bundle#default = [
            \ 'file',
            \ 'nagivation',
            \ 'visual',
            \ 'interface',
            \ 'completion',
            \ 'vcs',
            \ 'dev',
            \ 'lang'
        ]
let g:vonfry#bundle#manager_dir =
            \fnameescape(g:vonfry#bundle#dir)
            \ . join(['repos', 'github.com', 'Shougo',
            \ 'dein.vim'], s:Fsep)

function! vonfry#bundle#init()
    call vonfry#bundle#preinstall()
endfunction

function! vonfry#bundle#preinstall()
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
    if filereadable(expand(g:vonfry#bundle#dir)
                \ . join(['repos', 'github.com',
                \ 'Shougo', 'dein.vim', 'README.md'],
                \ s:Fsep))
    elseif executable('git')
        exec '!git clone https://github.com/Shougo/dein.vim "'
                    \ . expand(g:vonfry#bundle#dir)
                    \ . join(['repos', 'github.com',
                    \ 'Shougo', 'dein.vim"'], s:Fsep)
    else
        echohl WarningMsg
        echom 'You need install git!'
        echohl None
    endif
    exec 'set runtimepath+=' . g:vonfry#bundle#manager_dir
endfunction

function! vonfry#bundle#add(plug)
    if type(plug) == 1 "string
        call dein#add(plug)
    elseif type(plug) == 3 && len(plug) >= 1 && len(plug) <= 2 "list
        if len(plug) == 1
            call dein#add(plug[0])
        else
            call dein#add(plug[0], plug[1])
        endif
    else
        throw 'add arguments error'
    endif
endfunction

function! vonfry#bundle#begin()
    call dein#load_state(g:vonfry#bundle#dir)
    call dein#begin(g:vonfry#bundle#dir)
endfunction

function! vonfry#bundle#end()
    call dein#end()
    call dein#save_state()
endfunction

function! vonfry#bundle#use()
    call vonfry#bundle#begin()
    call dein#add(g:vonfry#bundle#manager_dir)
    for bundle in g:vonfry#bundle#default
        exec 'call vonfry#bundle#' . g:vonfry#bundle#default . '#init()'
    endfor
    call vonfry#bundle#end()

    filetype plugin indent on
    syntax enable

    call vonfry#bundle#install()
endfunction

function! vonfry#bundle#install()
    if dein#check_install()
        call dein#install()
    endif
endfunction
