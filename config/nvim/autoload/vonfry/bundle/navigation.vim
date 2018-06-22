"" navigation.vim
"

function! vonfry#bundle#nagivation#init()
    call vonfry#bundle#nagivation#easymotion()
    call vonfry#bundle#nagivation#tagbar()
endfunction

function! vonfry#bundle#nagivation#easymotion()
    call vonfry#bundle#add('easymotion/vim-easymotion')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#g, '<Plug>(easymotion-prefix)')
endfunction

function! vonfry#bundle#nagivation#tagbar()
    call vonfry#bundle#add('majutsushi/tagbar')
    let g:tagbar_show_linenumbers = 0
    let g:tagbar_autopreview = 0
    let g:tagbar_autoclose = 1
    let g:tagbar_sort = 0
    let g:tagbar_autoshowtag = 1
endfunction
