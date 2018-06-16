"" local.vim
" define some variable.

function! vonfry#local#init()
    let g:vonfry_local_cache = expand('~/.cache/nvim')
    let g:vonfry_local_undo = g:vonfry_local_cache . '/undo'
endfunction
