"" mapping.vim
" define some variables which is used for mapping. Or set them.
"

function! vonfry#mapping#init()
    let g:mapleader = g:vonfry#mapping#nmap#leader
endfunction

function! vonfry#mapping#leader(keys, func)
    if type(a:keys) == type('')
        exec 'nmap <leader>' . a:keys . ' ' . a:func
    elseif type(a:keys) == type([])
        exec 'nmap <leader>' . join(a:keys, '') . ' ' . a:func
    endif
endfunction

function! vonfry#mapping#lang(keys, func)
    if type(a:keys) == type('')
        exec 'nmap <leader>' . a:keys . ' ' . a:func
        call vonfry#mapping#leader(g:vonfry#mapping#nmap#lang . a:keys, a:func)
    elseif type(a:keys) == type([])
        call vonfry#mapping#leader([g:vonfry#mapping#nmap#lang] + a:keys, a:func)
    endif
endfunction
