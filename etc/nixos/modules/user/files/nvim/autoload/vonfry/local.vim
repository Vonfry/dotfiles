"" local.vim
" define some variable.

function! vonfry#local#init()
  let g:vonfry#local#cache = stdpath('cache')
  let g:vonfry#local#undo = g:vonfry#local#cache . '/undo/'
  let g:vonfry#local#swap = g:vonfry#local#cache . "/swap/"
  let g:vonfry#local#backup = g:vonfry#local#cache . "/backup/"
endfunction
