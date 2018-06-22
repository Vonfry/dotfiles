"" mapping.vim
" define some variables which is used for mapping. Or set them.
"

function! vonfry#mapping#init()
    let g:mapleader = g:vonfry#mapping#nmap#leader
endfunction

function! vonfry#mapping#leader(keys, func)
    if type(keys) == 1 " string
        exec 'nmap <leader>' . key . ' ' . func
    elseif type(keys) == 3 " list
        exec 'nmap <leader>' . join(keys, '') . ' ' . func
    endif
endfunction

function! vonfry#mapping#lang(keys, func)
    if type(keys) == 1
        exec 'nmap <leader>' . key . ' ' . func
        call vonfry#mapping#leader(g:vonfry#mapping#nmap#lang . keys, func)
    elseif type(keys) == 3
        call vonfry#mapping#leader([g:vonfry#mapping#nmap#lang] + keys, func)
    endif
endfunction
