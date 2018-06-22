"" lang.vim
"

function! vonfry#bundle#lang#init()
    call vonfry#bundle#add('sheerun/vim-polyglot')
    call vonfry#bundle#lang#doc()
    call vonfry#bundle#lang#web()
    call vonfry#bundle#lang#ruby()
endfunction

function! vonfry#bundle#lang#web()
    call vonfry#bundle#add('tpope/vim-ragtag')
    call vonfry#bundle#add('Valloric/MatchTagAlways')
endfunction

function! vonfry#bundle#lang#ruby()
    call vonfry#bundle#add('tpope/vim-rails')
endfunction

function! vonfry#bundle#lang#shell()
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#terminal, ':terminal')
endfunction

function! vonfry#bundle#lang#doc()
    call vonfry#bundle#add('DoxygenToolkit.vim')
    call vonfry#bundle#add('kshenoy/vim-signature')
endfunction
