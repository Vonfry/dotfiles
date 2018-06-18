"" mapping.vim
" define some variables which is used for mapping. Or set them.
"

function! vonfry#mapping#init()
    let g:mapleader = g:vonfry#mapping#nmap#leader
endfunction

function! vonfry#mapping#leader(keys, func)
    if type(keys) == 1
        exec 'nmap <leader>' . key . ' ' . func
    elseif type(keys) == 3
        exec 'nmap <leader>' . join(keys, '') . ' ' . func
    endif
endfunction
