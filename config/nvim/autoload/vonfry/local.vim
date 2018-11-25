"" local.vim
" define some variable.

let g:vonfry#local#cache = expand('~/.cache/nvim/')
let g:vonfry#local#undo = g:vonfry#local#cache . 'undo/'
let g:vonfry#local#swap = g:vonfry#local#cache . "swap/"
let g:vonfry#local#backup = g:vonfry#local#cache . "backup/"


function! vonfry#local#init()
endfunction
