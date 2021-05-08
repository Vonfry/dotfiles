"" mapping.vim
" define some variables which is used for mapping. Or set them.
"

function! vonfry#mapping#init()
    let g:mapleader = "\<Space>"
    let l:mapleader = "\\"

    " make keys binding for dvorak layouts
    nnoremap q h
    nnoremap Q H
    nnoremap h x
    nnoremap H X
    nnoremap x l
    nnoremap X L
    nnoremap l q
    nnoremap L Q 
endfunction
