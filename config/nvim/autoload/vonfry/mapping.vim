"" mapping.vim
" define some variables which is used for mapping. Or set them.
"

function! vonfry#mapping#init()
    let g:mapleader = g:vonfry#mapping#nmap#leader
endfunction

function! vonfry#mapping#leader(key, func)
    exec 'nmap <leader>' . key . ' ' . func
endfunction
