"" keybind.vim
" define some variables which is used for keybind. Or set them.
"

function! vonfry#keybind#init()
    let g:mapleader = g:vonfry#keybind#nmap#leader
endfunction

function! vonfry#keybind#leader(key, func)
    exec 'nmap <leader>' . key . ' ' . func
endfunction
