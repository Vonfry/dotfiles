"" bundle.vim
" preinstall package manager and define the bundle which are needed by default.
"

let g:vonfry#bundle#default = [ "completion", "dev", "file", "interface", "lang", "navigation", "vcs", "visual" ]

function! vonfry#bundle#init()
    for bundle in g:vonfry#bundle#default
        exec 'call vonfry#bundle#' . bundle . '#config()'
    endfor
endfunction
