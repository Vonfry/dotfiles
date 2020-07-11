"" bundle.vim
" preinstall package manager and define the bundle which are needed by default.
"

let g:vonfry#bundle#dir = g:vonfry#local#cache . '/bundle/'

function! vonfry#bundle#init()
    for bundle in g:vonfry#bundle#default
        exec 'call vonfry#bundle#' . bundle . '#config()'
    endfor
endfunction
